function [ person,world ] = movePerson( person,world)
%MOVEPERSON Summary of this function goes here
%   Detailed explanation goes here
% Moves a Person onto a field in his/her vision
       

    [neighbours,counter]=getNeighbours(person, world,0); %gets the empty, neighbouring fields and there number
        
    empty=agent;                %creates agent
    empty.initAgent(0);         %defines it as empty
    
    if(counter>0)   %The agent can only move if there are empty fields in his neighbourhood (but even if there arent he still can arrest or hurt people so don't just abbort)
        
        %the person can just stay put and not move at all: "moves to his
        %own field"
        neighbours(counter+1)=person.place;
        counter=counter+1;
        
        index=randi(counter,1);     %creates a random integer between 1 and the number of free neighbours
        
        if(index~=counter)              %if index==counter: person doesn't move at all
%             x=neighbours(index).x;      %gets the column of the location in the world
%             y=neighbours(index).y;      %gets line of the location in the world
%             person.moveTo(world(y,x));  %moves the agent to his new location and sets all the member variables
            
            if(person.support>0.75)
                %police move random
                x=neighbours(index).x;      %gets the column of the location in the world
                y=neighbours(index).y;      %gets line of the location in the world
                person.moveTo(world(y,x));
            elseif(person.support<0.25)
                %mafia stay in mafia place
                maxInf = -1;
                indexMax = 1;
                for index = 1:counter
                    if(neighbours(index).infMafia > maxInf)
                       maxInf = neighbours(index).infMafia;
                       indexMax = index;
                    end
                end
                x=neighbours(indexMax).x;  
                y=neighbours(indexMax).y;
                person.moveTo(world(y,x));
            else
                %normal people move around police
                maxInf = -1;
                indexMax = 1;
                for index = 1:counter
                    if(neighbours(index).infPolice > maxInf)
                       maxInf = neighbours(index).infPolice;
                       indexMax = index;
                    end
                end
                x=neighbours(indexMax).x;  
                y=neighbours(indexMax).y;
                person.moveTo(world(y,x));
            end
        end
    end
        
    if(person.support>0.75)     %If the agent is an active policeman
        [neighboursA,counterA]=getNeighbours(person, world,1); %gets the occupied neighbouring fields
        
        if(counterA==0)      %can only arrest if there are people
            return
        end
        
        index=randi(counterA,1); %random integer 
        x=neighboursA(index).x;  %the field to check
        y=neighboursA(index).y;
        
        comp=rand;                  %random number between 0 and 1
        if(comp<(world(y,x).pArrest))    %if comp<pArrest: agent is arrested: his place is set to 0, the location where he was standing is now empty
            world(y,x).person.toPrison();
            ausgabe='Verhaftet';
        end
    end
    
    if(person.support<0.25)     %If the agent is an active mafia supporter
        [neighboursI,counterI]=getNeighbours(person, world,1); %gets the occupied neighbouring fields
        
        if(counterI==0)      %can only injure if there are people
            return
        end
        
        index=randi(counterI,1); %random integer 
        x=neighboursI(index).x;  %the field to check
        y=neighboursI(index).y;        
        comp=rand;                  %random number between 0 and 1
        if(comp<world(y,x).pInjury)    %if comp<pArrest: agent is arrested: his place is set to 0, the location where he was standing is now empty
            world(y,x).person.toHospital();
            ausgabe='Verletzt';
        end
    end
    
end

