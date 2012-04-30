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
    neighbours((2*vision+1)^2,1)=Location;   %allocates space for the Location-Array
    for k1=x-vision:x+vision        %geht die Spalten durch
        for k2=y-vision:y+vision    %geht die Zeilen durch
            if(k1>0 && k2>0 && k1<width && k2<height)
                if((chooser==0 && world(k2,k1).person.number==0)||(chooser==1 && world(k2,k1).person.number>0))     %if field is in the whished state (empty/occupied): wright it in the neighbours array and increase the counter
                    if(k1~=x && k2~=y) %the persons own field shouldn't be added
                        counter=counter+1;
                        neighbours(counter)=world(k2,k1);
                    end                    
                end
            end
        end
    end
    
    if(counter == 0)        %if there are no avaible neigbours, the neighbours variable would not have been defined
        neighbours = 0;
    end
end

