close all
clear all

global prison
global hospital

world = createWorld(30,30,150);

for index = 1:20;
    displayWorld(world);
    moveAll(world);
end

[agents,amount] = findAgents(world);
amount