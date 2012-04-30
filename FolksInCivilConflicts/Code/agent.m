classdef agent < handle
    % the "< handle" assures that when an agent-object is given to a
    % function it is passed by reference and not by value: Therefore the
    % Membervariable "person" of a location object is changed if the agent
    % in that location is changed. But if I want to change the "person"
    % Variable to another agent I can just do that with
    % obj.person=agent(a,b,c,d) and the person-reference will just be
    % redirected to the new agent without changing the old one
    %  
    %AGENT Summary of this class goes here
    %   Detailed explanation goes here
    % Beschreibt einen Agent     
    
    properties
    
        number      % Falls man etwas auswerten will, bei dem man die Agents identifizieren muss und bsp. number=0 heisst, kein Agent (f�r Feld)
        wealth
        courage     
        influence
        basicSupport    %General tendency of the agent towards Police or Mafia without interference
        
        place          % present location of the agent
        satisfaction
        support        % Total Support
        riskM         % Risk, the agent is ready to assume against Mafia
        riskP         % Risk, the agent is ready to assume against Police
    
    
    end
    
         
    
    methods
        % initializes the agent-object: has basically the role of a
        % constructor, but doesn't have problems with matrices.
        function initAgent(obj,num)
            obj.number=num;
            if(num==0)
                return
            end
            obj.wealth=randomvalue(1);
            obj.satisfaction=obj.wealth; %wealth ist ja der anfangswert von satisfaction
            obj.courage=randomvalue(1);
            obj.influence=randomvalue(1);
            obj.basicSupport=randomvalue(1);
            obj.support=obj.basicSupport;   %basic support ist ja der anfangswert von support
        end
        
        
        
        % the first input of the functions has to be the agent
        % itself: when using the function you can just wright
        % example.newSat() instead
        
        % Changes the satisfaction
        function newSat(obj)   
            
            obj.satisfaction=obj.satisfaction-(obj.place.jailtime*(obj.place.pArrest-obj.place.pAbefore)+obj.place.injury*(obj.place.pInjury-obj.place.pIbefore));
            
            if(obj.satisfaction>1)
                obj.satisfaction=1;
            end
            if(obj.satisfaction<0)
                obj.satisfaction=0;
            end
        end

        % Changes the two risk-values.
        function newRisk(obj)
             %updates the Risk against the Police
            if(obj.satisfaction*obj.place.pArrest*obj.place.jailtime==0) %would result in dividing by zero (is most likely triggered by pArrest=0 (for example if there are no neighbours present)
                obj.riskP=1;
            else

                obj.riskP=obj.courage/(obj.satisfaction*obj.place.pArrest*obj.place.jailtime);  
            end
            
            %updates the Risk against the Mafia
            if(obj.satisfaction*obj.place.pInjury*obj.place.injury==0) %would result in dividing by zero (most likely because there are no mafia-members so pInjury=0
                obj.riskM=1;
            else
            obj.riskM=obj.courage/(obj.satisfaction*obj.place.pInjury*obj.place.injury);
            end
            
            % For Safety: The Risks have to be between 0 and 1: if they
            % exceed their boundaries they're just set to the
            % boundary-values
            if(obj.riskP>1)
                obj.riskP=1;
            end
            if(obj.riskP<0)
                obj.riskP=0;
            end
            if(obj.riskM>1)
                obj.riskM=1;
            end
            if(obj.riskM<0)
                obj.riskM=0;
            end            
            
        end
        
        % Changes the total Support
        function newSup(obj)
            
            %updates the Support-Value
            obj.support=obj.support - obj.riskP + obj.riskM;
            
            %If the support would be leave the defined area: just set it to
            %the boundary-value
            if(obj.support>1)
                obj.support=1;
            end
            if(obj.support<0)
                obj.support=0;
            end
            
            
        end
               
        %sends agent to prison
        function toPrison(obj,prison)      
           %Create a prison-Cell-location where the agent will be put
           prisonCell=location;
           %initialize it with x=-2, y=position in the prison-array,the
           %jailtime (how long the prisoner has to stay there), vision and
           %injury are unimportant so just set them to zero
           prisonCell.initLocation(-2,length(prison)+1,obj.place.jailtime,0,0),
           %Set the Person in the Cell to the given agent
           prisonCell.person=obj;
           %create an empty-agent and set the place where the arrested
           %agent stood to empty
           empty=agent;
           empty.number=0;
           obj.place.person=empty;
           %sets the location of the arrested person to his prison cell
           obj.place=prisonCell; 
           %attaches the prisonCell to the prison array at its end.
           prison(length(prison)+1)=prisonCell;
        end
        
        %sends agent to the hospital
        function toHospital(obj,hospital)
           %create new location with the "hospital-room"
           room=location;
           %initialize it with x=-2, y=position in the prison-array usw
           room.initLocation(-1,length(hospital)+1,0,obj.place.injury,0);
           %sets the rooms person to the patient
           room.person=obj;
           %make new agent to set on the now empty field
           empty=agent;
           empty.number=0;
           obj.place.person=empty;
           %says to the patient where he is now
           obj.place=room; 
           %attaches the room to the hospital array
           hospital(length(hospital)+1)=room;
        end
        
        %gets the neighbours using getNeighbours (unnecessary but nice)
        function [neighbours,counter] = neighbours(person,world,chooser)
           [neighbours,counter] = getNeighbours(person,world,chooser); 
        end
        
        %moves an agent using movePerson (unnecessary but nice)
        function move(obj,world,hospital,prison)
            movePerson( obj,world,hospital,prison )
        end
              
    end
    
end

