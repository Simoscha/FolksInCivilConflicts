function statistics = getStatistics(agents,amount)
    %Returns the average values of one round
    % 1. Satisfaction
    % 2. Support
    % 3. RiskM
    % 4. RiskP
    averageSatisfaction = 0;
    for index = 1:amount-1
        averageSatisfaction = averageSatisfaction + agents(index).satisfaction;
    end
    statistics(1) = averageSatisfaction/amount;
    
    averageSupport = 0;
    for index = 1:amount-1
        averageSupport = averageSupport + agents(index).support;
    end
    statistics(2) = averageSupport/amount;
    
    averageRiskM = 0;
    for index = 1:amount-1
        averageRiskM = averageRiskM + agents(index).riskM;
    end
    statistics(3) = averageRiskM/amount;
    
    averageRiskP = 0;
    for index = 1:amount-1
        averageRiskP = averageRiskP + agents(index).riskP;
    end
    statistics(4) = averageRiskP/amount;
end