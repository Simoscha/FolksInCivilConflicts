close all
clear all

global prison
global hospital

world = createWorld(30,30,80);

displayWorld(world);

moveAll(world);

displayWorld(world);
moveAll(world);
displayWorld(world);
moveAll(world);
displayWorld(world);
moveAll(world);
displayWorld(world);
moveAll(world);
displayWorld(world);
moveAll(world);
displayWorld(world);

[agents,amount] = findAgents(world);
amount