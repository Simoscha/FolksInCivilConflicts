function [] = analysePoliceThresholdMafiaThreshold(init)
    global prison
    global hospital
    averageSatisfactionArray = zeros(length(init.model.param_agents),length(init.model.param_worldHeight));
    for indexPoliceThreshold = 1:length(init.model.param_policeThreshold)
        policeThreshold = init.model.param_policeThreshold(indexPoliceThreshold);
       for indexMafiaThreshold = 1:length(init.model.param_mafiaThreshold)
           mafiaThreshold = init.model.param_mafiaThreshold(indexMafiaThreshold);
            load(strcat('data/world_',int2str(policeThreshold),'_',int2str(mafiaThreshold),'.mat'));
            %get the last world
            world = worldArray(1 + ((init.model.n_lifetime-1)*init.model.n_worldHeight):init.model.n_lifetime*init.model.n_worldHeight,(1 + (1-1)*init.model.n_worldWidth):1*init.model.n_worldWidth);
            prison = prisonArray(init.model.n_lifetime+1,1:prisonLengthArray(init.model.n_lifetime+1));
            hospital = hospitalArray(init.model.n_lifetime+1,1:hospitalLengthArray(init.model.n_lifetime+1));
            [agents,amount] = findAllAgents(world);
            
            averageSatisfaction = sum([agents.satisfaction]);
%             averageSatisfaction = 0;
%             for index = 1:amount-1
%                 averageSatisfaction = averageSatisfaction + agents(index).satisfaction;
%             end
            averageSatisfaction = averageSatisfaction/amount;
            averageSatisfactionArray(indexJailtime,indexInjury) = averageSatisfaction;
             
       end
    end
    x = init.model.param_jailtime;
    y = init.model.param_injury;
    view(0,90);
    surf(x,y,averageSatisfactionArray);
    colorbar;
    set(gca,'FontSize',14);
    xlabel('PoliceThreshold');
    ylabel('MafiaThreshold');
    zlabel('Satisfaction');
end