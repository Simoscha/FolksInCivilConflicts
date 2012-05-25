function [] = analyseWorldsizePopulation(init)
    global prison
    global hospital
    averageSatisfactionArray = zeros(length(init.model.param_agents),length(init.model.param_worldHeight));
    for indexPopulation = 1:length(init.model.param_agents)
       for indexWorldsize = 1:length(init.model.param_worldHeight)
           for rCount=1:init.globals.RUNS
                load(strcat('data/', init.globals.NAME , 'world_PopulationSize_',int2str(init.model.param_agents(indexPopulation)),'_',int2str(init.model.param_worldHeight(indexWorldsize)),'x',int2str(init.model.param_worldWidth(indexWorldsize)),'_',int2str(rCount)));
                %get the last world
                world = worldArray(1 + ((init.model.n_lifetime-1)*init.model.param_worldHeight(indexWorldsize)):init.model.n_lifetime*init.model.param_worldHeight(indexWorldsize),(1 + (1-1)*init.model.param_worldWidth(indexWorldsize)):1*init.model.param_worldWidth(indexWorldsize));
                prison = prisonArray(init.model.n_lifetime+1,1:prisonLengthArray(init.model.n_lifetime+1));
                hospital = hospitalArray(init.model.n_lifetime+1,1:hospitalLengthArray(init.model.n_lifetime+1));
                [agents,amount] = findAllAgents(world);

                averageSatisfaction = 0;
                for index = 1:amount-1
                    averageSatisfaction = averageSatisfaction + agents(index).satisfaction;
                end
                %averageSatisfaction = sum([prison.person.satisfaction]) + sum([hospital.person.satisfaction]);
                
                averageSatisfaction = averageSatisfaction/init.model.param_agents(indexPopulation);
                averageSatisfactionArray(indexWorldsize,indexPopulation) = averageSatisfactionArray(indexWorldsize,indexPopulation) + averageSatisfaction;
            end
            averageSatisfactionArray(indexWorldsize,indexPopulation) = averageSatisfactionArray(indexWorldsize,indexPopulation)/rCount;
             
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