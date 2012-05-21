function [] = analyseJailtimeInjury(init)
    
     
    for indexJailtime = 1:length(init.model.param_jailtime)
       for indexInjury = 1:length(init.model.param_injury)
            load(strcat('data/world_',int2str(init.model.param_jailtime(indexJailtime)),'_',int2str(init.model.param_injury(indexInjury))));
            %get the last world
            world = worldArray(1 + ((init.model.n_lifetime-1)*init.model.n_worldHeight):init.model.n_lifetime*init.model.n_worldHeight,(1 + (1-1)*init.model.n_worldWidth):1*init.model.n_worldWidth);
            [agents,amount] = findAgents(world);
            
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
    xlabel('Jailtime');
    ylabel('Injury');
    zlabel('Satisfaction');
end