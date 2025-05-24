function b = designFilter(f1, f2, fs, n, plotTitle)
    f_low = f1 / (fs/2);
    f_high = f2 / (fs/2);
    b = fir1(n, [f_low f_high], 'bandpass', chebwin(n+1, 100), 'scale');

    [h, f] = freqz(b, 1, 512);

    % Plot in a single figure
    %figure('Name', [plotTitle ' - Filter Response'], 'NumberTitle', 'off');
    figure;
    subplot(1,1,1);
    plot(f * fs / (2*pi), 20 * log10(abs(h)), 'b');
    xlabel('Frequency (cycles/day)');
    ylabel('Gain (dB)');
    title(['Frequency Response - ' plotTitle]);
    grid on;
    hold on;
    yl = ylim;
    plot([1/7 1/7], yl, 'r--', 'LineWidth', 1.2);
    legend('Gain', '1/7 Hz target');
end
