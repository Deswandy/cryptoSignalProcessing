function [price, date] = plotData(filename, fs, titlePrefix)
    data = readtable(filename);
    price = fillmissing(data.Close, 'linear');
    date = datetime(data.Price,'InputFormat','yyyy-MM-dd');
    xDays = 0:1/fs:length(price)-1;

    % Nfft = 2048;
    % Fs = fft(price, Nfft);
    % AFs = abs(Fs);
    % f = fs/Nfft*(0:Nfft/2 - 1);

    % Subplots: Time (date), Time (index), Frequency
    %figure('Name', char([titlePrefix ' - Raw Data']), 'NumberTitle', 'off');
    figure;

    
%    subplot(3,1,1);
%    plot(date, price);
%    title([titlePrefix ' - Time Domain (Date)']);
%    xlabel('Date'); ylabel('Price'); grid on;

    % subplot(2,1,1);
    plot(xDays, price);
    title([titlePrefix ' - Time Domain (Index)']);
    xlabel('Days'); ylabel('Price'); grid on;

    % subplot(2,1,2);
    % plot(f, AFs(1:Nfft/2));
    % title([titlePrefix ' - Frequency Domain']);
    % xlabel('Frequency (cycles/day)'); ylabel('Magnitude'); grid on;
end
