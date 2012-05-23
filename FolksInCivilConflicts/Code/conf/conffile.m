% Modeling and Simulating Social Systems with MATLAB
% Author: Florian Gubler and Christian Käslin, 2012

%%%%%%%%%%%%%
% GLOBAL Conf
%%%%%%%%%%%%%

simName = 'AlphaSim';  % or use the routine time2name()
descr   = 'first test with conf file';
version = 1;
dumpDir = 'dump/';      % or use the routine to generate a unique dir

VIDEO = 0;              % Display real time video
DEBUG = 0;              % Output more verbose 
DUMP = 1;               % Save the results in an external file

COMPUTATION = 0;        % In case you have different engine (e.g. cluster, 
                        % multicore processor, or single core processor)
NAME = 'Christian';
                        
RUNS = 20;              % Number of simulation runs with same param set

globals = struct('dumpDir', dumpDir, ...
                  'RUNS', RUNS, ...
                  'VIDEO', VIDEO, ...
                  'DEBUG', DEBUG, ...
                  'DUMP', DUMP, ...
                  'NAME', NAME ...
                  );

%%%%%%%%%%%%%
% MODEL Conf
%%%%%%%%%%%%%

% It is often convenient to define the model parameters as vectors of
% parameters ranges. This way we prepare already the data in an appropriate
% format to perform parameter sweeping

n_lifetime = 50; %rounds to simulate
n_worldHeight = [10];
n_worldWidth = [10];
n_agents = [30];       % number of agents
n_vision = [1];
n_jailtime = [5];
n_injury = [5];
n_policeThreshold = [0.75];
n_mafiaThreshold = [0.25];

param_agents = [10:5:60];
param_worldHeight = [8:1:18];
param_worldWidth = [8:1:18];

param_jailtime = [0:1:10];
param_injury = [0:1:10];

param_policeThreshold = [0.5:0.05:1];
param_mafiaThreshold = [0:0.05:0.5];


model = struct('n_lifetime' , n_lifetime, ...
               'n_worldHeight', n_worldHeight, ...
               'n_worldWidth', n_worldWidth, ...
                'n_agents', n_agents, ...
                'n_vision', n_vision, ...
                'n_jailtime', n_jailtime, ...
                'n_injury', n_injury, ...
                'n_policeThreshold', n_policeThreshold, ...
                'n_mafiaThreshold', n_mafiaThreshold, ...
                'param_agents', param_agents,...
                'param_worldHeight', param_worldHeight, ...
                'param_worldWidth', param_worldWidth, ...
                'param_jailtime', param_jailtime, ...
                'param_injury', param_injury, ...
                'param_policeThreshold', param_policeThreshold, ...
                'param_mafiaThreshold', param_mafiaThreshold ...
                );
                
            
%%%%%%%%%%%%%%%%%%
% Put all together
%%%%%%%%%%%%%%%%%%

init = struct('name', simName, ...
              'descr', descr, ...
              'version', version, ...
              'globals', globals, ...
              'model', model ...
              );
          
save(simName); % Creates a loadable file 