function [] = analysePoliceThresholdMafiaThreshold(init)
%ANALYSEPOLICETHRESHOLDMAFIATHRESHOLD
%Compares different police and mafie threshold values and makes a 3D plot
    global prison
    global hospital
    averageSatisfactionArray = zeros(length(init.model.param_mafiaThreshold),...
        length(init.model.param_policeThreshold));
    for indexPoliceThreshold = 1:length(init.model.param_policeThreshold)
        policeThreshold = init.model.param_policeThreshold(indexPoliceThreshold);
       for indexMafiaThreshold = 1:length(init.model.param_mafiaThreshold)
           for rCount=1:init.globals.RUNS
               mafiaThreshold = init.model.param_mafiaThreshold(indexMafiaThreshold);
                load(strcat('data/', init.globals.NAME , 'world_PoliceMafiaThreshold_',...
                    num2str(policeThreshold),'_',num2str(mafiaThreshold),'_',int2str(rCount),'.mat'));
                %get the last world
                world = worldArray(1 + ((init.model.n_lifetime-1)*init.model.n_worldHeight):...
                    init.model.n_lifetime*init.model.n_worldHeight,(1 + (1-1)*init.model.n_worldWidth):1*init.model.n_worldWidth);
                prison = prisonArray(init.model.n_lifetime+1,1:prisonLengthArray(init.model.n_lifetime+1));
                hospital = hospitalArray(init.model.n_lifetime+1,1:hospitalLengthArray(init.model.n_lifetime+1));
                [agents,amount] = findAllAgents(world);

                averageSatisfaction = sum([agents.satisfaction]);%alternative way but not faster
    %             averageSatisfaction = 0;
    %             for index = 1:amount-1
    %                 averageSatisfaction = averageSatisfaction + agents(index).satisfaction;
    %             end
                averageSatisfaction = averageSatisfaction/amount;
                averageSatisfactionArray(indexMafiaThreshold,indexPoliceThreshold) = averageSatisfactionArray(indexMafiaThreshold,...
                    indexPoliceThreshold) + averageSatisfaction;
            end
            averageSatisfactionArray(indexMafiaThreshold,indexPoliceThreshold) = averageSatisfactionArray(indexMafiaThreshold,...
                indexPoliceThreshold)/rCount;
             
       end
    end
    x = init.model.param_policeThreshold;
    y = init.model.param_mafiaThreshold;
    view(0,90);
    surf(x,y,averageSatisfactionArray);
    colorbar;
    set(gca,'FontSize',14);
    xlabel('PoliceThreshold');
    ylabel('MafiaThreshold');
    zlabel('Satisfaction');
end