function [ person,world ] = movePerson( person,world)
%MOVEPERSON 
% Moves a Person onto a field in his/her vision
global policeThreshold
global mafiaThreshold
global debug
       

    [neighbours,counter]=getNeighbours(person, world,0); %gets the empty, neighbouring fields and there number
        
    empty=agent;                %creates agent
    empty.initAgent(0);         %defines it as empty
    
    if(counter>0)   %The agent can only move if there are empty fields in his neighbourhood 
                    %(but even if there arent he still can arrest or hurt people so don't just abbort)
        
        %the person can just stay put and not move at all: "moves to his
        %own field"
        if((person.support > policeThreshold) || (person.support < mafiaThreshold))
            
            neighbours(counter+1)=person.place;
            counter=counter+1;
      
            index=randi(counter,1);     %creates a random integer between 1 and the number of free neighbours
            if(index~=counter)              %if index==counter: person doesn't move at all
                x=neighbours(index).x;      %gets the column of the location in the world
                y=neighbours(index).y;      %gets line of the location in the world
                person.moveTo(world(y,x));  %moves the agent to his new location and sets all the member variables
            end
        else    %normal population
                %normal people try to avoid both police and mafia: go where
                %their influence is as small as possible. For people who
                %are rather mafia supportive the police influence is worse
                %than the mafia influence and vice versa
                minInf = 1000;
                indexMin = 1;
                for index = 1:counter
                    if((1-person.support)*neighbours(index).infPolice + person.support*neighbours(index).infMafia < minInf)
                       minInf = (1-person.support)*neighbours(index).infPolice + person.support*neighbours(index).infMafia;
                       indexMin = index;
                    end
                end
                x=neighbours(indexMin).x;  
                y=neighbours(indexMin).y;
                
                %Insert a random element: sometimes the population just
                %moves randomly
                tester=rand;
                if(tester<0.1)
                    index=randi(counter,1);     %creates a random integer between 1 and the number of free neighbours
                    if(index~=counter)              %if index==counter: person doesn't move at all
                        x=neighbours(index).x;      %gets the column of the location in the world
                        y=neighbours(index).y;      %gets line of the location in the world
                    end
                end
                
                person.moveTo(world(y,x));
                
        end
        
        
    end
            
    if(person.support>policeThreshold)     %If the agent is an active policeman
        [neighboursA,counterA]=getNeighbours(person, world,1); %gets the occupied neighbouring fields
        
        if(counterA==0)      %can only arrest if there are people
            return
        end
        
        index=randi(counterA,1); %random integer 
        x=neighboursA(index).x;  %the field to check
        y=neighboursA(index).y;
        
        comp=rand;                  %random number between 0 and 1
        if(comp<(world(y,x).pArrest))    %if comp<pArrest: agent is arrested: his place is set to 0, 
                                         %the location where he was standing is now empty
            world(y,x).person.toPrison();
            if(debug)
             disp('arrested')
          end
        end
    end
    
    if(person.support<mafiaThreshold)     %If the agent is an active mafia supporter
        [neighboursI,counterI]=getNeighbours(person, world,1); %gets the occupied neighbouring fields
        
        if(counterI==0)      %can only injure if there are people
            return
        end
        
        index=randi(counterI,1); %random integer 
        x=neighboursI(index).x;  %the field to check
        y=neighboursI(index).y;        
        comp=rand;                  %random number between 0 and 1
        if(comp<world(y,x).pInjury)    %if comp<pArrest: agent is arrested: his place is set to 0, 
                                       %the location where he was standing is now empty
            world(y,x).person.toHospital();
            if(debug)
             disp('hurt')
          end
        end
    end
    
end

