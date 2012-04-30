close all
clear all

cycles = 5;
world = createWorld(30,30,150);
[agent,before]=findAgents(world);
before

    prison=location;
    prison.x=-2;
    prison.y=5;
    hospital=location;
    hospital.x=-1;
    hospital.y=3;
    
for index = 1:cycles;
    [agents,amount] = findAgents(world);
    statistics(index,:) = getStatistics(agents,amount);
    displayWorld(world);
    moveAll(world,hospital,prison);
    %updateAll(world);
end

[agents,amount] = findAgents(world);
amount

plotStatistics(statistics,cycles);
