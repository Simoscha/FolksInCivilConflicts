function [ agents,finderCounter ] = findAgents( world )
%FINDAGENTS Summary of this function goes here
%   Detailed explanation goes here
% Gets a world and gives back all the non-empty agents in it

width=length(world(1,:));
heigth=length(world(:,1));

finderCounter=0;
for k1=1:width
    for k2=1:heigth
        if(world(k2,k1).person~=0) %could be a problem
            finderCounter=finderCounter+1;
            agents(finderCounter)=world(k2,k1).person;
        end
    end
end

end

