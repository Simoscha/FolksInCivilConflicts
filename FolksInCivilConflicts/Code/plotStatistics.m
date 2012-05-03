function [] = plotStatistics(statistics,cycles)
    figure
    plot(1:cycles,statistics);
    legend('Satisfaction','Support','RiskM', 'RiskP');
end