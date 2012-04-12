function [ person,world ] = movePerson( person,world )
%MOVEPERSON Summary of this function goes here
%   Detailed explanation goes here
    [neighbours,counter]=getNeighbours(person, world,0); %gets the empty, neighbouring fields and there number

    empty=agent;                %creates agent
    empty.initAgent(0);         %defines it as empty
    %counter
    if(counter>0)   %The agent can only move if there are empty fields in his neighbourhood
        index=randi(counter,1);     %creates a random integer between 1 and the number of free neighbours
        x=neighbours(index).x;      %gets the column of the location in the world
        y=neighbours(index).y;      %gets line of the location in the world
        person.place.person=empty;  %sets the previous field to empty
        world(y,x).person=person;       %sets the person variable of the new field to the person
        person.place=world(y,x);        %sets the place of the person to the new field
    end
        
    if(person.support>0.75)     %If the agent is an active policeman
        [neighbours,counter]=getNeighbours(person, world,1); %gets the occupied neighbouring fields
        
        if(counter==0)      %can only arrest if there are people
            return
        end
        
        index=randi(counter,1); %random integer 
        x=neighbours(index).x;  %the field to check
        y=neighbours(index).y;
        comp=rand;                  %random number between 0 and 1
        if(comp<(world(y,x).pArrest))    %if comp<pArrest: agent is arrested: his place is set to 0, the location where he was standing is now empty
            arrested=world(y,x).person;
            world(y,x).person=empty; 
            arrested.place.prison(length(prison)+1); %location of arrested is set to prison
            prison(length(prison)+1)=arrested;      %the agent is added to the prison array
        end
    end
    
    if(person.support<0.25)     %If the agent is an active mafia supporter
        [neighbours,counter]=getNeighbours(person, world,1); %gets the occupied neighbouring fields
        
        if(counter==0)      %can only injure if there are people
            return
        end
        
        index=randi(counter,1); %random integer 
        x=neighbours(index).x;  %the field to check
        y=neighbours(index).y;        
        comp=rand;                  %random number between 0 and 1
        if(comp<world(y,x).pInjury)    %if comp<pArrest: agent is arrested: his place is set to 0, the location where he was standing is now empty
            injured=world(y,x).person;
            world(y,x).person=empty;
            injured.place.hospital(length(prison)+1);   %location of injured is set to hospital
            hospital(length(hospital)+1)=injured;       %%the agent is added to the hospital array
        end
    end
    
    
    

end

