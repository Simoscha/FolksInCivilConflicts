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
        % Constructor: function name ist Klassenname, obj ist das Rueckgabeelement (obj.numer greift auf die eigene Membervariable zu)

        function obj=agent(num, w, c, i,bS)
            obj.number=num;
            obj.wealth=w;
            obj.courage=c;
            obj.influence=i;
            obj.basicSupport=bS;
        end
        
        % the first input of the functions has to be the agent
        % itself: when using the function you can just wright
        % example.newSat() instead
        
        % Changes the satisfaction
        % We still need to define its range
        function obj=newSat(obj)   
            
            obj.satisfaction=obj.wealth-(obj.place.jailtime*obj.place.pArrest+obj.place.injury*obj.place.pInjury);
            
        end

        % Changes the two risk-values.
        % We still need to define their range
        function obj=newRisk(obj)
                      
            obj.riskP=obj.courage/(obj.satisfaction*obj.place.pArrest*obj.place.jailtime);
            obj.riskM=obj.courage/(obj.satisfaction*obj.place.pInjury*obj.place.injury);
            
        end
        
        % Changes the total Support
        function obj=newSup(obj)
            
            obj.support=obj.basicSupport - obj.riskP + obj.riskM;
            
            %If the support would be leave the defined area: just set it to
            %the boundary-value
            if(obj.support>1)
                obj.support=1;
            end
            if(obj.support<0)
                obj.support=0;
            end
            
            
        end
        
        % Yet to be implemented: a function for movement, arrest and injury
        
          
      
    end
    
end

