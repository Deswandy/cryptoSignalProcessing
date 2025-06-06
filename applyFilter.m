function filtered_price = applyFilter(price, date, b, fs, titlePrefix, filterLabel)
    filtered_price = filtfilt(b, 1, price);

    % Nfft = 2048;
    % Fs = fft(filtered_price, Nfft);
    % AFs = abs(Fs);
    % f = fs/Nfft*(0:Nfft/2 - 1);

    % Subplots: Time domain + Frequency domain
    figure;

    % subplot(2,1,1);
    plot(date, filtered_price);
    title(sprintf('%s - Filtered Time Domain (%s)', titlePrefix, filterLabel));
    xlabel('Date'); ylabel('Filtered Price');
    grid on;

    % subplot(2,1,2);
    % plot(f, AFs(1:Nfft/2));
    % title(sprintf('%s - Filtered Frequency Domain (%s)', titlePrefix, filterLabel));
    % xlabel('Frequency (cycles/day)'); ylabel('Magnitude');
    % grid on;
end
