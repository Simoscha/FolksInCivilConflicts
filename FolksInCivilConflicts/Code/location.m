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
       pArrest        %probability that an Agent is arrested standig here (at the beginning =0 so that in the first change the pAbefore is set to 0)
       pAbefore       %probability of Arrest one iteration step before 
       pInjury        %probability that an Agent is injured standig here
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
            obj.infMafia=0;
            obj.infPolice=0;
            obj.infTot=0;
            obj.pArrest=0;
            obj.pInjury=0;
            obj.pAbefore=0;
            obj.pIbefore=0;
        end
        
        %defines the probilites to be arrested and/or injured
        function probabilities(obj)
            obj.pAbefore=obj.pArrest;   
            obj.pIbefore=obj.pInjury;
            if(obj.person.number==0) %empty field not interesting
                return
            end
            %test if agent on the field is properly initialized
            if(obj.person.place~=obj)
                warning('agent not properly initialized: in location.probabilities')
            end
            %adjust the influences
            if(obj.infMafia==0) %would be dividing by 0
               obj.pArrest=(1-obj.person.support);
            else
            obj.pArrest=(1-obj.person.support)*(1-exp(-obj.infPolice/obj.infMafia));
            end
            if(obj.infPolice==0)
               obj.pInjury=(obj.person.support);
            else
            obj.pInjury=(obj.person.support)*(1-exp(-obj.infMafia/obj.infPolice));
            end
        end
        
        %defines the new influences of Mafia, Police and Total
        function newInfluences(obj,world)
            % the new influences don't depend on the old ones so first set
            % them all to zero
            obj.infMafia=0;     
            obj.infPolice=0;
            obj.infTot=0;
            if(obj.person.number==0)    %empty field: no need to update
                return
            end
             %to be safe: if the agent isn't properly defined: give a
             %warning
            if(obj.person.place~=obj)
                warning('agent not properly initialized: in location.newInfluences')
            end
            
            %get the neighbouring non-empty fields
            [neighbours,amount]=getNeighbours(obj.person,world,1);
            %adds up all the influences
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
        
        %gets the neighbouring Fields, using getNeighbours on the agent on
        %the field (unnecessary but nice)
        function [neighbours,counter] = neighbours(loc,world,chooser)
            [neighbours,counter] = getNeighbours(loc.person,world,chooser);
        end
                
    end
end

