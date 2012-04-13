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
    
        number      % Falls man etwas auswerten will, bei dem man die Agents identifizieren muss und bsp. number=0 heisst, kein Agent (für Feld)
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
        % We still need to define their range
        function newRisk(obj)
                      
            obj.riskP=obj.courage/(obj.satisfaction*obj.place.pArrest*obj.place.jailtime);
            obj.riskM=obj.courage/(obj.satisfaction*obj.place.pInjury*obj.place.injury);
            
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
           buffer=location;
           buffer.x=-2;
           buffer.y=length(prison)+1;
           buffer.person=obj;
           empty=agent;
           empty.number=0;
           obj.place.person=empty;
           obj.place=buffer; 
           prison(length(prison)+1)=buffer;
        end
        
        %sends agent to the hospital
        function toHospital(obj,hospital)
           buffer=location;
           buffer.x=-1;
           buffer.y=length(hospital)+1;
           buffer.person=obj;
           empty=agent;
           empty.number=0;
           obj.place.person=empty;
           obj.place=buffer; 
           hospital(length(hospital)+1)=buffer;
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

