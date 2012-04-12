close all
clear all


world = createWorld(30,30,150);
[agent,before]=findAgents(world);
before

    prison=location;
    prison.x=-2;
    prison.y=5;
    hospital=location;
    hospital.x=-1;
    hospital.y=3;

for index = 1:5;
    displayWorld(world);
    moveAll(world,hospital,prison);
end

[agents,amount] = findAgents(world);
amount