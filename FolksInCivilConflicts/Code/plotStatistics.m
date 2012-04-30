function stat = plotStatistics(statistics,cycles)
    figure
    plot(1:cycles,statistics);
    legend('Satisfaction','Support','RiskM', 'RiskP');
    stat = 0;
end