close all
clear all

cycles = 10;
numPerson=90;
world = createWorld(10,10,numPerson);
[agent,before]=findAgents(world);
before

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

for index = 1:cycles;
    [agents,amount] = findAgents(world);
    statistics(index,:) = getStatistics(agents,amount);
    displayWorld(world);
    moveAll(world);
    updateAll(world);

    checkReentry(world);
    
end

[agents,amount] = findAgents(world);
amount

plotStatistics(statistics,cycles);
