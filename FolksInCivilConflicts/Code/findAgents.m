function [ agents,finderCounter ] = findAgents( world )
%FINDAGENTS 
% Gets a world and gives back all the non-empty agents in it

width=length(world(1,:));
heigth=length(world(:,1));
agents(heigth*width)=agent;     %allocates memory for the agents array
finderCounter=0;
for k1=1:width
    for k2=1:heigth
        if(world(k2,k1).person.number~=0)
            finderCounter=finderCounter+1;
            agents(finderCounter)=world(k2,k1).person;
        end
    end
end

end

