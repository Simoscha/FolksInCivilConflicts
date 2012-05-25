% Main file
% IMPORTANT! Running the whole file at once is not recommended.
% The file is divided in several cells which can executed alone.
% On a multi core prozessor, the whole folder could be copied for each
% core.
% For each core a Matlab instance can be started and run a cell.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIMULATIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Do the simulation Population against Worldsize
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

global policeThreshold
policeThreshold = init.model.n_policeThreshold;
global mafiaThreshold
mafiaThreshold = init.model.n_mafiaThreshold;

global k;%constant to calculation a usable satisfaction
k = 10;

global debug;
debug = init.globals.DEBUG; %to have access in class

for indexPopulation = 1:length(init.model.param_agents)
    init.model.n_agents = init.model.param_agents(indexPopulation);
    for indexWorldsize = 1:length(init.model.param_worldHeight)
        fprintf('Population vs Worldsize %d/%d.\n',(indexPopulation-1)* ...
            length(init.model.param_worldHeight) + indexWorldsize, ...
            length(init.model.param_agents)*length(init.model.param_worldHeight));
        init.model.n_worldHeight = init.model.param_worldHeight(indexWorldsize);
        init.model.n_worldWidth = init.model.param_worldWidth(indexWorldsize);
        
        world = createWorld(init);
        [agent,before]=findAllAgents(world);
        if(init.globals.DEBUG)
            disp(before)
        end

        %preallocate an array to save to world after each round
        worldArray = repmat(world,[(init.model.n_lifetime + 1) init.globals.RUNS]);   
        prisonArray = repmat(location,[(init.model.n_lifetime + 1) init.model.n_agents]);
        hospitalArray = repmat(location,[(init.model.n_lifetime + 1) init.model.n_agents]);
        prisonLengthArray = zeros(init.model.n_lifetime + 1,1);
        hospitalLengthArray = zeros(init.model.n_lifetime + 1,1);
        % Repeat the same simulation RUNS times
        for rCount=1:init.globals.RUNS    

            fprintf('Starting Run: %d/%d of Simulation.\n', ...
                    rCount,init.globals.RUNS)
            fprintf('------------------------------------\n');

            %preallocate a statistics array
            statistics = zeros(init.model.n_lifetime,4);
            for index = 1:init.model.n_lifetime;
                %save the current world
                worldArray(1 + ((index-1)*init.model.n_worldHeight):index* ...
                    init.model.n_worldHeight,(1 + (rCount-1)*init.model.n_worldWidth):rCount* ...
                    init.model.n_worldWidth) = copy(world);%make a deep copy
                prisonArray(index,1:length(prison)) = copy(prison);
                hospitalArray(index,1:length(hospital)) = copy(hospital);
                prisonLengthArray(index) = length(prison);
                hospitalLengthArray(index) = length(hospital);
                %compute statistics
                [agents,amount] = findAllAgents(world);
                statistics(index,:) = getStatistics(agents,amount);
                moveAll(world);
                updateAll(world);
                checkReentry(init,world);
            end

            index = index + 1;
            %save the last world
            worldArray(1 + ((index-1)*init.model.n_worldHeight):index* ...
                init.model.n_worldHeight,(1 + (rCount-1)*init.model.n_worldWidth):rCount* ...
                init.model.n_worldWidth) = world;
            prisonArray(index,1:length(prison)) = copy(prison);
            hospitalArray(index,1:length(hospital)) = copy(hospital);
            statistics(index,:) = getStatistics(agents,amount);

            [agents,amount] = findAllAgents(world);
            if(init.globals.DEBUG)
                disp(amount)
            end

            fprintf('\n\n');
            %save worldarray to disk
            save(strcat('data/', init.globals.NAME , 'world_PopulationSize_', ...
                int2str(init.model.n_agents),'_',int2str(init.model.n_worldHeight),'x', ...
                int2str(init.model.n_worldWidth), '_', int2str(rCount) ,'.mat'),'worldArray', ...
                'statistics','prisonArray','hospitalArray','prisonLengthArray','hospitalLengthArray');
            fprintf('Finished Run:\n');
            fprintf('------------------------------------\n');            

        end   
    end
end

%% Do the simulation Jailtime against Injury

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

global policeThreshold
policeThreshold = init.model.n_policeThreshold;
global mafiaThreshold
mafiaThreshold = init.model.n_mafiaThreshold;

global k;
k = 10;

global debug;
debug = init.globals.DEBUG; %to have access in class

for indexJailtime = 1:length(init.model.param_jailtime)
    init.model.n_jailtime = init.model.param_jailtime(indexJailtime);
    for indexInjury = 1:length(init.model.param_injury)
        fprintf('Jailtime vs Injury %d/%d.\n',(indexJailtime-1)*length(init.model.param_injury) ...
            + indexInjury, length(init.model.param_jailtime)*length(init.model.param_injury));
        
        init.model.n_injury = init.model.param_injury(indexInjury);
        
        world = createWorld(init);
        [agent,before]=findAllAgents(world);
        if(init.globals.DEBUG)
            disp(before)
        end

        %preallocate an array to save to world after each round
        worldArray = repmat(world,[(init.model.n_lifetime + 1) init.globals.RUNS]);
        prisonArray = repmat(location,[(init.model.n_lifetime + 1) init.model.n_agents]);
        hospitalArray = repmat(location,[(init.model.n_lifetime + 1) init.model.n_agents]);
        prisonLengthArray = zeros(init.model.n_lifetime + 1,1);
        hospitalLengthArray = zeros(init.model.n_lifetime + 1,1);
        % Repeat the same simulation RUNS times
        for rCount=1:init.globals.RUNS    
            fprintf('Starting Run: %d/%d of Simulation.\n', ...
                    rCount,init.globals.RUNS)
            fprintf('------------------------------------\n');

            %preallocate a statistics array
            statistics = zeros(init.model.n_lifetime,4);
            for index = 1:init.model.n_lifetime;
                %save the current world
                worldArray(1 + ((index-1)*init.model.n_worldHeight):index*init.model.n_worldHeight,...
                    (1 + (rCount-1)*init.model.n_worldWidth):rCount*init.model.n_worldWidth) = copy(world);%make a deep copy
                prisonArray(index,1:length(prison)) = copy(prison);
                hospitalArray(index,1:length(hospital)) = copy(hospital);
                prisonLengthArray(index) = length(prison);
                hospitalLengthArray(index) = length(hospital);
                [agents,amount] = findAllAgents(world);
                statistics(index,:) = getStatistics(agents,amount);
                moveAll(world);
                updateAll(world);
                checkReentry(init,world);
            end

            index = index + 1;
            %save the last world
            worldArray(1 + ((index-1)*init.model.n_worldHeight):index*init.model.n_worldHeight, ...
                (1 + (rCount-1)*init.model.n_worldWidth):rCount*init.model.n_worldWidth) = world;
            prisonArray(index,1:length(prison)) = copy(prison);
            hospitalArray(index,1:length(hospital)) = copy(hospital);
            statistics(index,:) = getStatistics(agents,amount);

            [agents,amount] = findAllAgents(world);
            if(init.globals.DEBUG)
                disp(amount)
            end

            fprintf('\n\n');
            %save worldarray to disk
            save(strcat('data/', init.globals.NAME , 'world_JailtimeInjury_',int2str(init.model.n_jailtime),...
                '_',int2str(init.model.n_injury), '_',  int2str(rCount),'.mat'),'worldArray','statistics',...
                'prisonArray','hospitalArray','prisonLengthArray','hospitalLengthArray');
            
            fprintf('Finished Run:');
            fprintf('------------------------------------\n');
        end        

        
    end
end

%% Do the simulation policeThreshold againt mafiaThreshold
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

global policeThreshold
policeThreshold = init.model.n_policeThreshold;
global mafiaThreshold
mafiaThreshold = init.model.n_mafiaThreshold;

global k;
k = 10;

global debug;
debug = init.globals.DEBUG; %to have access in class

for indexPoliceThreshold = 1:length(init.model.param_policeThreshold)
    policeThreshold = init.model.param_policeThreshold(indexPoliceThreshold);
    for indexMafiaThreshold = 1:length(init.model.param_mafiaThreshold)
        fprintf('policeThreshold vs mafiaThreshold %d/%d.\n',(indexPoliceThreshold-1)*...
            length(init.model.param_mafiaThreshold)+indexMafiaThreshold,...
            length(init.model.param_policeThreshold)*length(init.model.param_mafiaThreshold));
        mafiaThreshold = init.model.param_mafiaThreshold(indexMafiaThreshold);
  
        world = createWorld(init);
        [agent,before]=findAllAgents(world);
        if(init.globals.DEBUG)
            disp(before)
        end

        %preallocate an array to save to world after each round
        worldArray = repmat(world,[(init.model.n_lifetime + 1) init.globals.RUNS]);   
        prisonArray = repmat(location,[(init.model.n_lifetime + 1) init.model.n_agents]);
        hospitalArray = repmat(location,[(init.model.n_lifetime + 1) init.model.n_agents]);
        prisonLengthArray = zeros(init.model.n_lifetime + 1,1);
        hospitalLengthArray = zeros(init.model.n_lifetime + 1,1);
        % Repeat the same simulation RUNS times
        for rCount=1:init.globals.RUNS    

            fprintf('Starting Run: %d/%d of Simulation.\n', ...
                    rCount,init.globals.RUNS)
            fprintf('------------------------------------\n');

            %preallocate a statistics array
            statistics = zeros(init.model.n_lifetime,4);
            for index = 1:init.model.n_lifetime;
                %save the current world
                worldArray(1 + ((index-1)*init.model.n_worldHeight):index*...
                    init.model.n_worldHeight,(1 + (rCount-1)*init.model.n_worldWidth):rCount*...
                    init.model.n_worldWidth) = copy(world);%make a deep copy
                prisonArray(index,1:length(prison)) = copy(prison);
                hospitalArray(index,1:length(hospital)) = copy(hospital);
                prisonLengthArray(index) = length(prison);
                hospitalLengthArray(index) = length(hospital);
                [agents,amount] = findAllAgents(world);
                statistics(index,:) = getStatistics(agents,amount);
                moveAll(world);
                updateAll(world);
                checkReentry(init,world);
            end

            index = index + 1;
            %save the last world
            worldArray(1 + ((index-1)*init.model.n_worldHeight):index*init.model.n_worldHeight,...
                (1 + (rCount-1)*init.model.n_worldWidth):rCount*init.model.n_worldWidth) = world;
            prisonArray(index,1:length(prison)) = copy(prison);
            hospitalArray(index,1:length(hospital)) = copy(hospital);
            statistics(index,:) = getStatistics(agents,amount);

            [agents,amount] = findAllAgents(world);
            if(init.globals.DEBUG)
                disp(amount)
            end

            fprintf('\n\n');
            %save worldarray to disk
            save(strcat('data/', init.globals.NAME ,'world_PoliceMafiaThreshold_',num2str(policeThreshold),...
                '_',num2str(mafiaThreshold), '_', int2str(rCount),'.mat'),'worldArray','statistics','prisonArray',...
                'hospitalArray','prisonLengthArray','hospitalLengthArray');
            fprintf('Finished Run:');
            fprintf('------------------------------------\n');

        end    
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Livetime Analysation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% show World

% Clear workspace
close all
clear all

% Add other directories to path
path(path,'conf/');
%load the configuration file
conffile
%load saved world data, the name should be insert by hand
%load(strcat('data/', init.globals.NAME , 'world_JailtimeInjury_','1','_','1','_1'));
%load(strcat('data/','Christianworld_PopulationSize_30_10x10_1'));
load(strcat('data/Christianworld_JailtimeInjury_10_6_1'));
worldHeight = 10;
worldWidth = 10;
rCount = 1;
pause on
for index = 1:(length(worldArray(:,1))/(worldHeight));
    index
    world = worldArray(1 + ((index-1)*worldHeight):index*...
        worldHeight,(1 + (rCount-1)*worldWidth):rCount*worldWidth);
    displayWorld(world);
    pause(0.1)
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
%load saved world data, the name should be insert by hand
%load(strcat('data/','Christianworld_PopulationSize_30_10x10_1'));
%load(strcat('data/Christianworld_JailtimeInjury_5_5_1'));
load(strcat('data/','Christianworld_PoliceMafiaThreshold_0.5_0.5_1.mat'));

plotStatistics(statistics,(length(statistics(:,1))));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End Analysation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% world size & population -> satisfaction

% Clear workspace
close all
clear all
clc

global prison
global hospital
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

global prison
global hospital
% Add other directories to path
path(path,'conf/');
%load the configuration file
conffile
%load saved world data
analyseJailtimeInjury(init);

%% policeThreshold & mafiaThreshold -> satisfaction

% Clear workspace
close all
clear all
clc

global prison
global hospital
% Add other directories to path
path(path,'conf/');
%load the configuration file
conffile
%load saved world data
analysePoliceThresholdMafiaThreshold(init);


