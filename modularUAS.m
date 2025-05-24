close all; clear all; clc;

% === Settings ===
fs = 1; % 1 sample/day

% === File List ===
filenames = { ...
    "btc_usd_2018.csv", ...
    "eth_usd_2018.csv", ...
    "xrp_usd_2018.csv" ...
};

titles = { ...
    "Bitcoin", ...
    "Etherium", ...
    "XRP" ...
};

% === Filter Settings (each row: [f1, f2]) ===
filters = [
    0.13, 0.15;     % Weekly band
    0.065, 0.075;   % BiWeekly band
    0.025, 0.035;   % Monthly band
];

n = 256;  % Filter order

% === Preallocate result container ===
filtered_prices = cell(length(filenames), size(filters,1));

% === Loop Through Each File and Filter ===
for i = 1:length(filenames)
    filename = filenames{i};
    titlePrefix = titles{i};

    % Load and plot raw data
    [price, date] = plotData(filename, fs, titlePrefix);

    for j = 1:size(filters,1)
        f1 = filters(j,1);
        f2 = filters(j,2);
        filterLabel = sprintf('%.3f–%.3f', f1, f2);

        % Design filter
        b = designFilter(f1, f2, fs, n, sprintf('%s (Filter %s)', titlePrefix, filterLabel));

        % Filter and store result
        filtered_prices{i, j} = applyFilter(price, date, b, fs, titlePrefix, filterLabel);
    end
end



% === Cross-Correlation Between Cryptocurrencies for Each Filter Band ===
filterNames = {'Weekly', 'BiWeekly', 'Monthly'};
numFilters = size(filters, 1);
cryptoPairs = nchoosek(1:length(filenames), 2); % All unique pairs

for j = 1:numFilters
    fprintf('\n=== %s Band Cross-Correlation ===\n', filterNames{j});
    
    for p = 1:size(cryptoPairs, 1)
        idx1 = cryptoPairs(p,1);
        idx2 = cryptoPairs(p,2);
        
        data1 = filtered_prices{idx1, j};
        data2 = filtered_prices{idx2, j};

        % Ensure both signals are the same length
        minLength = min(length(data1), length(data2));
        data1 = data1(1:minLength);
        data2 = data2(1:minLength);

        % Compute cross-correlation
        [xc, lags] = xcorr(data1, data2, 'coeff');
        [maxCorr, maxIdx] = max(xc);
        lagAtMaxCorr = lags(maxIdx);

        % Print result
        fprintf('%s vs %s: Max Corr = %.3f at Lag = %d days\n', ...
            titles{idx1}, titles{idx2}, maxCorr, lagAtMaxCorr);

        % Optional: plot cross-correlation
        figure;
        plot(lags, xc);
        title(sprintf('%s Band: %s vs %s', filterNames{j}, titles{idx1}, titles{idx2}));
        xlabel('Lag (days)');
        ylabel('Cross-correlation');
        grid on;
    end
end