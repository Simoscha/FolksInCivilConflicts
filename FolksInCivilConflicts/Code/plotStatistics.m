function [] = plotStatistics(statistics,cycles)
    figure
    plot(1:cycles,statistics);
    set(gca,'FontSize',14);
    legend('Satisfaction','Support','RiskM', 'RiskP');
    xlabel('lifecycle');
end