function world = moveAll(world,hospital,prison)
    height = length(world(:,1));
    width = length(world(1,:));
    
    %random numbers, ever number appears only once
    randPositions = randperm(height*width);
    hospital.y=2;
    prison.y=4;
    
    for index = 0:height*width-1
       x = floor((randPositions(index+1)-1)/width)+1;
       y = mod(randPositions(index+1)-1,width)+1;
       
       if(0 == world(y,x).person.number)
          %no person in this field, do nothing 
       else
          person = world(y,x).person; %weglassen??
          movePerson(person,world,hospital,prison);
       end
    end
end