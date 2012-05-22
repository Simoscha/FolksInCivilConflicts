function [ agents,amount ] = findAllAgents( world )
%FINDALLAGENTS Summary of this function goes here
%   Detailed explanation goes here
% includes the people in prison and hospital
global hospital
global prison
    [agents,amount]=findAgents(world);  %First get the agents on the world map
    
    for k=2:length(hospital)    %Get all the non-empty hospital agents
        if(hospital(k).person.number~=0)
            amount=amount+1;
            agents(amount)=hospital(k).person;
        end
    end
    
    for k=2:length(prison)  %Get all the non-empty prison agents
        if(prison(k).person.number~=0)
            amount=amount+1;
            agents(amount)=prison(k).person;
        end
    end    
end

