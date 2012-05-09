function world = moveAll(world)
    height = length(world(:,1));
    width = length(world(1,:));
    
    %random numbers, ever number appears only once
    randPositions = randperm(height*width);
    
    for index = 0:height*width-1
       y = floor((randPositions(index+1)-1)/width)+1;
       x = mod(randPositions(index+1)-1,width)+1;
       
       if(0 == world(y,x).person.number)
          %no person in this field, do nothing
          continue;
       else
          movePerson(world(y,x).person,world);
       end
    end
end