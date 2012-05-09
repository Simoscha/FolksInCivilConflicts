%% Do the simulation

% Clear workspace
close all
clear all
clc
% Add other directories to path
path(path,'conf/');
%load the configuration file
conffile
%or load saved configuration
%load('AlphaSim');

%initializes the hospital and prison globally and initializes them as
%locations (otherwise it wouldn't work)
%Beware: Because they are already initialized to a location here, the
%first array-element of both hospital and prison is useless: therefore
%the two arrays will always have one element more then there are people
%in hospital or prison
global prison;
prison=location;
prison(1).x=-2;
prison(1).y=1;
global hospital;
hospital=location;
hospital(1).x=-1;
hospital(1).y=1;

for indexPopulation = 1:length(init.model.param_agents)
    init.model.n_agents = init.model.param_agents(indexPopulation);
    for indexWorldsize = 1:length(init.model.param_worldHeight)
        init.model.n_worldHeight = init.model.param_worldHeight(indexWorldsize);
        init.model.n_worldWidth = init.model.param_worldWidth(indexWorldsize);
        
        
        world = createWorld(init);
        [agent,before]=findAgents(world);
        if(init.globals.DEBUG)
            disp(before)
        end

        

        %preallocate an array to save to world after each round
        worldArray = repmat(world,[(init.model.n_lifetime + 1) init.globals.RUNS]);   
        % Repeat the same simulation RUNS times
        for rCount=1:init.globals.RUNS    

            fprintf('\n%s\n',init.name);
            fprintf('Starting Run: %d/%d of Simulation.\n', ...
                    rCount,init.globals.RUNS)
            fprintf('------------------------------------\n');


            %preallocate a statistics array
            statistics = zeros(init.model.n_lifetime,4);
            for index = 1:init.model.n_lifetime;
                %save the current world
                worldArray(1 + ((index-1)*init.model.n_worldHeight):index*init.model.n_worldHeight,(1 + (rCount-1)*init.model.n_worldWidth):rCount*init.model.n_worldWidth) = copy(world);%make a deep copy
                [agents,amount] = findAgents(world);
                statistics(index,:) = getStatistics(agents,amount);
                moveAll(world);
                updateAll(world);
                checkReentry(init,world);
            end

            index = index + 1;
            %save the last world
            worldArray(1 + ((index-1)*init.model.n_worldHeight):index*init.model.n_worldHeight,(1 + (rCount-1)*init.model.n_worldWidth):rCount*init.model.n_worldWidth) = world;



            [agents,amount] = findAgents(world);
            if(init.globals.DEBUG)
                disp(amount)
            end

            fprintf('\n\n');


        end

        %save worldarray to disk
        save(strcat('data/world_',int2str(init.model.n_agents),'_',int2str(init.model.n_worldHeight),'x',int2str(init.model.n_worldWidth) ,'.mat'),'worldArray','statistics');

        fprintf('Finished Run:');
        fprintf('------------------------------------\n');
    end
end

%% Do the simulation

% Clear workspace
close all
clear all
clc
% Add other directories to path
path(path,'conf/');
%load the configuration file
conffile
%or load saved configuration
%load('AlphaSim');

%initializes the hospital and prison globally and initializes them as
%locations (otherwise it wouldn't work)
%Beware: Because they are already initialized to a location here, the
%first array-element of both hospital and prison is useless: therefore
%the two arrays will always have one element more then there are people
%in hospital or prison
global prison;
prison=location;
prison(1).x=-2;
prison(1).y=1;
global hospital;
hospital=location;
hospital(1).x=-1;
hospital(1).y=1;
for indexJailtime = 1:length(init.model.param_jailtime)
    init.model.n_jailtime = init.model.param_jailtime(indexJailtime);
    for indexInjury = 1:length(init.model.param_injury)
        init.model.n_injury = init.model.param_injury(indexInjury);
        
        world = createWorld(init);
        [agent,before]=findAgents(world);
        if(init.globals.DEBUG)
            disp(before)
        end

        %preallocate an array to save to world after each round
        worldArray = repmat(world,[(init.model.n_lifetime + 1) init.globals.RUNS]);   
        % Repeat the same simulation RUNS times
        for rCount=1:init.globals.RUNS    

            fprintf('\n%s\n',init.name);
            fprintf('Starting Run: %d/%d of Simulation.\n', ...
                    rCount,init.globals.RUNS)
            fprintf('------------------------------------\n');


            %preallocate a statistics array
            statistics = zeros(init.model.n_lifetime,4);
            for index = 1:init.model.n_lifetime;
                %save the current world
                worldArray(1 + ((index-1)*init.model.n_worldHeight):index*init.model.n_worldHeight,(1 + (rCount-1)*init.model.n_worldWidth):rCount*init.model.n_worldWidth) = copy(world);%make a deep copy
                [agents,amount] = findAgents(world);
                statistics(index,:) = getStatistics(agents,amount);
                moveAll(world);
                updateAll(world);
                checkReentry(init,world);
            end

            index = index + 1;
            %save the last world
            worldArray(1 + ((index-1)*init.model.n_worldHeight):index*init.model.n_worldHeight,(1 + (rCount-1)*init.model.n_worldWidth):rCount*init.model.n_worldWidth) = world;



            [agents,amount] = findAgents(world);
            if(init.globals.DEBUG)
                disp(amount)
            end

            fprintf('\n\n');


        end

        %save worldarray to disk
        save(strcat('data/world_',int2str(init.model.n_jailtime),'_',int2str(init.model.n_injury),'.mat'),'worldArray','statistics');

        fprintf('Finished Run:');
        fprintf('------------------------------------\n');
    end
end




%% show World

% Clear workspace
close all
clear all
clc
% Add other directories to path
path(path,'conf/');
%load the configuration file
conffile
%load saved world data
load('worldAlphaSim');
rCount = 1;
pause on
for index = 1:(length(worldArray(:,1))/(init.model.n_worldHeight));
    index
    world = worldArray(1 + ((index-1)*init.model.n_worldHeight):index*init.model.n_worldHeight,(1 + (rCount-1)*init.model.n_worldWidth):rCount*init.model.n_worldWidth);
    displayWorld(world);
    pause(.5)
end

%% show statistic

% Clear workspace
close all
clear all
clc
% Add other directories to path
path(path,'conf/');
%load the configuration file
conffile
%load saved world data
load('worldAlphaSim');
plotStatistics(statistics,(length(statistics(:,1))));

%% world size & population -> satisfaction

% Clear workspace
close all
clear all
clc
% Add other directories to path
path(path,'conf/');
%load the configuration file
conffile
%load saved world data
analyseWorldsizePopulation(init);

%% jailtime & injury -> satisfaction

% Clear workspace
close all
clear all
clc
% Add other directories to path
path(path,'conf/');
%load the configuration file
conffile
%load saved world data
analyseJailtimeInjury(init);


