function world = moveAll(world)
%MOVEALL
%goes throw all agents and move them
    [agents,finderCounter] = findAgents(world);
    %random numbers, ever number appears only once
    randIndex = randperm(finderCounter);
    for index = 1:finderCounter
        movePerson(agents(randIndex(index)),world);
    end
end