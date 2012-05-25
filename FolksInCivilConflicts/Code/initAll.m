function [] = initAll( world,vision,jailtime,injury )
%INITALL 
% initializes first all Locations with their initial properties and then
% all the agents with their NON-CONSTANT properties (the constant ones have
% to be defined already)

    height = length(world(:,1));
    width = length(world(1,:));
    
    %initialize all Locations and agents
    for k1=1:width
        for k2=1:height
           world(k2,k1).initLocation(k1,k2,jailtime,injury,vision) %initializes the constant values
               
           %the person and his constant values on the Location has to be already known
           
           if(world(k2,k1).person.number~=0)   %an empty field doesn't need to be initialized 
            world(k2,k1).person.place=world(k2,k1); % set the place of the agent to the place where he's standing
            world(k2,k1).newInfluences(world); %initializes the Influence of Police Mafia and TOT
            world(k2,k1).probabilities;        % initializes the probabilites to get hurt or arrested
            world(k2,k1).person.newRisk;       %set the risks the agent is ready to take
           end
        end
    end

end

