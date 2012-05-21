function [ agents,amount ] = findAllAgents( world,hospital,prison )
%FINDALLAGENTS Summary of this function goes here
%   Detailed explanation goes here
% includes the people in prison and hospital
    [agents,amount]=findAgents(world);  %First get the agents on the world map
    
    for k=1:length(hospital)    %Get all the non-empty hospital agents
        if(hospital(k).person.number~=0)
            amount=amount+1;
            agents(length(agents)+1)=hospital(k).person;
        end
    end
    
    for k=1:length(prison)  %Get all the non-empty prison agents
        if(prison(k).person.number~=0)
            amount=amount+1;
            agents(length(agents)+1)=prison(k).person;
        end
    end
    
end

