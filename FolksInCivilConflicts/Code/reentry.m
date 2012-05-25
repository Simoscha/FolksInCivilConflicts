function [] = reentry(world,person)
%REENTRY
%set the agent on a free place in the world
    height = length(world(:,1));
    width = length(world(1,:));
    %find empty place to reentry
    y = floor(rand(1)*height) + 1;
    x = floor(rand(1)*width) + 1;
    while(0 ~= world(y,x).person.number)
        y = floor(rand(1)*height) + 1;
        x = floor(rand(1)*width) + 1;
    end
    %reentry
    world(y,x).person = person;
    person.place = world(y,x);
    
end