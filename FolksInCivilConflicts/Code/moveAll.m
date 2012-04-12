function world = moveAll(world)
    height = length(world(:,1));
    width = length(world(1,:));
    
    %random numbers, ever number appears only once
    randPositions = randperm(height*width);
    
    
    for index = 0:height*width-1
       x = floor((randPositions(index+1)-1)/width)+1;
       y = mod(randPositions(index+1)-1,width)+1;
       
       if(0 == world(y,x).person.number)
          %no person in this field, do nothing 
       else
          person = world(y,x).person;
          movePerson(person,world);
       end
    end
    p = agent;
    p.initAgent(100);
    world(1,1).person = p;
end