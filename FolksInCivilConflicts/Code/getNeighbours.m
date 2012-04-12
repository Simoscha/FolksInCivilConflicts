function [ neighbours,counter ] = getNeighbours( person,world,chooser )
%GETNEIGHBOURS Summary of this function goes here
%   Detailed explanation goes here
%gives back an array with all empty (chooser=0) or occupied (chooser=1) fields in the neighbourhood.

    height = length(world(:,1));
    width = length(world(1,:));
    
    vision=person.place.vision;
    x=person.place.x;
    y=person.place.y;
    counter=0;
    %neighbours=zeros(vision^2,1);   %initializes the array of empty neighbouring fields
    for k1=x-vision:x+vision        %geht die Spalten durch
        for k2=y-vision:y+vision    %geht die Zeilen durch
            if(k1>0&&k2>0&&k1<width&&k2<width)
                if((chooser==0 && world(k2,k1).person.number==0)||(chooser==1 && world(k2,k1).person.number>0))     %if field is in the whished state (empty/occupied): wright it in the neighbours array and increase the counter
                                    loc = world(k2,k1);
                    counter=counter+1;
                    neighbours(counter)=loc;
                    
                end
            end
        end
    end
end

