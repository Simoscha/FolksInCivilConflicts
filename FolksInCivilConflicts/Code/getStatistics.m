function statistics = getStatistics(agents,amount)
%STATISTICS
    %Returns the average values of one round
    % 1. Satisfaction
    % 2. Support
    % 3. RiskM
    % 4. RiskP
    averageSatisfaction = 0;
    for index = 1:amount
        averageSatisfaction = averageSatisfaction + agents(index).satisfaction;
    end
    statistics(1) = averageSatisfaction/amount;
    
    averageSupport = 0;
    for index = 1:amount
        averageSupport = averageSupport + agents(index).support;
    end
    statistics(2) = averageSupport/amount;
    
    averageRiskM = 0;
    for index = 1:amount
        averageRiskM = averageRiskM + agents(index).riskM;
    end
    statistics(3) = averageRiskM/amount;
    
    averageRiskP = 0;
    for index = 1:amount
        averageRiskP = averageRiskP + agents(index).riskP;
    end
    statistics(4) = averageRiskP/amount;
end