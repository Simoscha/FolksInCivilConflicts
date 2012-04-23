function [  ] = updateAll( world )
%UPDATEALL Summary of this function goes here
%   Detailed explanation goes here
% updates all the Locations with their new values of Influence and
% Probabilities (the new agents have already been set by movePerson) and
% all the agents with their new values of Satisfaction, support and Risks
% (the new places have already been set by movePerson)


    height = length(world(:,1));
    width = length(world(1,:));
    
    % update Locations
    for k1=1:width
        for k2=1:height
           world(k2,k1).newInfluences(world);  % updates the Influence of Police Mafia and TOT
           world(k2,k1).probabilities;         % updates the probabilites to get hurt or arrested
        end
    end
    
    %update Agents
    for k1=1:width
        for k2=1:height
            if(world(k2,k1).person.number~=0) %if not an empty field
               world(k2,k1).person.newSat;      %set the satisfaction
               world(k2,k1).person.newRisk;     %set the risks the agent is ready to take
               world(k2,k1).person.newSup;      %set the new support
            end
        end
    end


end
