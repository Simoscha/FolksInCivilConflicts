close all
clear all


world = createWorld(30,30,150);
[agent,before]=findAgents(world);
before

    prison=location;
    hospital=location;

for index = 1:5;
    displayWorld(world);
    moveAll(world,hospital,prison);
end

[agents,amount] = findAgents(world);
amount