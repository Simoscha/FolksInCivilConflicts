function [] = analyseWorldsizePopulation(init)
    
    averageSatisfactionArray = zeros(length(init.model.param_agents),length(init.model.param_worldHeight));
    for indexPopulation = 1:length(init.model.param_agents)
       for indexWorldsize = 1:length(init.model.param_worldHeight)
            load(strcat('data/world_',int2str(init.model.param_agents(indexPopulation)),'_',int2str(init.model.param_worldHeight(indexWorldsize)),'x',int2str(init.model.param_worldWidth(indexWorldsize))));
            %get the last world
            world = worldArray(1 + ((init.model.n_lifetime-1)*init.model.param_worldHeight(indexWorldsize)):init.model.n_lifetime*init.model.param_worldHeight(indexWorldsize),(1 + (1-1)*init.model.param_worldWidth(indexWorldsize)):1*init.model.param_worldWidth(indexWorldsize));
            prison = prisonArray(init.model.n_lifetime+1,1:prisonLengthArray(init.model.n_lifetime+1));
            hospital = hospitalArray(init.model.n_lifetime+1,1:hospitalLengthArray(init.model.n_lifetime+1));
            [agents,amount] = findAllAgents(world,hospital,prison);
            
            averageSatisfaction = 0;
            for index = 1:amount-1
                averageSatisfaction = averageSatisfaction + agents(index).satisfaction;
            end
            averageSatisfaction = averageSatisfaction/amount;
            averageSatisfactionArray(indexPopulation,indexWorldsize) = averageSatisfaction;
             
       end
    end
    x = init.model.param_agents;
    y = init.model.param_worldHeight.*init.model.param_worldWidth;
    view(0,90);
    surf(x,y,averageSatisfactionArray);
    colorbar;
    set(gca,'FontSize',14)
    xlabel('Population');
    ylabel('World size');
    zlabel('Satisfaction');
end