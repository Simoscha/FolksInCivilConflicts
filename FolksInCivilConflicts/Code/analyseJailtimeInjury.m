function [] = analyseJailtimeInjury(init)
    global prison
    global hospital
     
    averageSatisfactionArray = zeros(length(init.model.param_jailtime),length(init.model.param_injury));
    for indexJailtime = 1:length(init.model.param_jailtime)
       for indexInjury = 1:length(init.model.param_injury)
            for rCount=1:init.globals.RUNS
                load(strcat('data/', init.globals.NAME , 'world_JailtimeInjury_',int2str(init.model.param_jailtime(indexJailtime)),'_',int2str(init.model.param_injury(indexInjury)),'_',int2str(rCount)));
                %get the last world
                world = worldArray(1 + ((init.model.n_lifetime-1)*init.model.n_worldHeight):init.model.n_lifetime*init.model.n_worldHeight,(1 + (1-1)*init.model.n_worldWidth):1*init.model.n_worldWidth);
                prison = prisonArray(init.model.n_lifetime+1,1:prisonLengthArray(init.model.n_lifetime+1));
                hospital = hospitalArray(init.model.n_lifetime+1,1:hospitalLengthArray(init.model.n_lifetime+1));
                [agents,amount] = findAllAgents(world);

                %averageSatisfaction = sum([agents.satisfaction]);
                averageSatisfaction = 0;
                for index = 1:amount-1
                    averageSatisfaction = averageSatisfaction + agents(index).satisfaction;
                end
                averageSatisfaction = averageSatisfaction/amount;
                averageSatisfactionArray(indexInjury,indexJailtime) = averageSatisfactionArray(indexInjury,indexJailtime) + averageSatisfaction;
            end
            averageSatisfactionArray(indexInjury,indexJailtime) = averageSatisfactionArray(indexInjury,indexJailtime)/rCount;
             
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