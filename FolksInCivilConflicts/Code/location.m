classdef location < handle
    % the "< handle" assures that when an agent-object is given to a
    % function it is passed by reference and not by value: Therefore the
    % membervariable "place" of an agent object is changed if his location
    % is changed.
    
    %LOCATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       x                %Column-number in the Array
       y                %Row-number in the  Array
      
       %maybe we don't even need the x and y because they're defined by the
       %coordinates in the array.
       
       jailtime         %how long an arrested agent has to stay in jail
       injury           %how long an injured agent has to stay in the hospital
       vision           %how far the Agent standing here is able to see/interact (how many grid-cells in eache straight direction)
       person           %the agent standing on this spot
       
       infMafia         %influence of Mafia in the vision-radius
       infPolice        %influence of the Police in the vision-radius
       infTot           %Sum of the influences of all agents within vision
       % The influences have to be defined from the outside as they depend
       % from oder location-objects
       pArrest=0        %probability that an Agent is arrested standig here (at the beginning =0 so that in the first change the pAbefore is set to 0)
       pAbefore       %probability of Arrest one iteration step before 
       pInjury=0        %probability that an Agent is injured standig here
       pIbefore       %probability of Injury one iteration step before (at the beginning =0 so that in the first change the pIbefore is set to 0)
       
    end
    
    methods
        %Constructor: initializes the constant properties
        %if the field is empty: person.number=-1;
        function initLocation(obj,x,y,jailtime,injury,vision)
            obj.x=x;
            obj.y=y;
            obj.jailtime=jailtime;
            obj.injury=injury;
            obj.vision=vision;          
        end
        
        %defines the probilites to be arrested and/or injured
        function probabilities(obj)
            obj.pAbefore=obj.pArrest;   
            obj.pIbefore=obj.pInjury;   
            obj.pArrest=(1-obj.person.support)*(1-exp(-obj.infPolice/obj.infMafia));
            obj.pInjury=(obj.person.support)*(1-exp(-obj.infMafia/obj.infTot));
        end
        
        %defines the new influences of Mafia, Police and Total
        function newInfluences(obj,world)
            % the new influences don't depend on the old ones so first set
            % them all to zero
            obj.infMafia=0;     
            obj.infPolice=0;
            obj.infTot=0;
            obj.person.place=obj;   %to be safe: if the agent isn't properly defined
            [neighbours,amount]=getNeighbours(obj.person,world,1);
            for k=1:amount
                obj.infTot=obj.infTot+neighbours(k).person.influence;
                if(neighbours(k).person.support>0.75)
                    obj.infPolice=obj.infPolice+neighbours(k).person.influence;
                end
                if(neighbours(k).person.support<0.25)
                    obj.infMafia=obj.infMafia+neighbours(k).person.influence;
                end
            end
        end
              
    end
end

