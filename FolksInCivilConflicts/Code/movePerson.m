function [ person,world ] = movePerson( person,world )
%MOVEPERSON Summary of this function goes here
%   Detailed explanation goes here
    [neighbours,counter]=getNeighbours(person, world,0); %gets the empty, neighbouring fields and there number

    empty=agent;                %creates agent
    empty.initAgent(0);         %defines it as empty
    
    if(counter>1)   %The agent can only move if there are empty fields in his neighbourhood
        index=randi(counter,1);     %creates a random integer between 1 and the number of free neighbours
        newLoc=neighbours(index);   %the location the person moves to is the one at the position index
        person.place.person=empty;  %sets the previous field to empty
        newLoc.person=person;       %sets the person variable of the new field to the person
        person.place=newLoc;        %sets the place of the person to the new field
    end
        
    if(person.support>0.75)     %If the agent is an active policeman
        [neighbours,counter]=getNeighbours(person, world,1); %gets the occupied neighbouring fields
        
        if(counter==1)      %can only arrest if there are people
            return
        end
        
        index=randi(counter,1); %random integer 
        toCheck=neighbours(index);  %the field to check
        comp=rand;                  %random number between 0 and 1
        if(comp<toCheck.pArrest)    %if comp<pArrest: agent is arrested: his place is set to 0, the location where he was standing is now empty
            arrested=toCheck.person;
            toCheck.person=empty; 
            arrested.place=0;
        end
    end
    
    if(person.support<0.25)     %If the agent is an active mafia supporter
        [neighbours,counter]=getNeighbours(person, world,1); %gets the occupied neighbouring fields
        
        if(counter==1)      %can only injure if there are people
            return
        end
        
        index=randi(counter,1); %random integer 
        toCheck=neighbours(index);  %the field to check
        comp=rand;                  %random number between 0 and 1
        if(comp<toCheck.pInjury)    %if comp<pArrest: agent is arrested: his place is set to 0, the location where he was standing is now empty
            injured=toCheck.person;
            toCheck.person=empty;
            injured.place=0;
        end
    end
    
    
    

end
