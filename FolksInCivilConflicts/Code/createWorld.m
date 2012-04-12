function world = createWorld(height,width,peopleAmount)
    %world = zeros(height,width);
    
    %fill with people
    for index = 0:peopleAmount-1
        p = agent;
        loc=location;
        loc.person = p;
        p.initAgent(index+1);
        tempWorld(floor(index/width)+1,mod(index,width)+1) = loc;
    end
    
    %fill empy agents for empty fields
    for index = peopleAmount:(height*width-1)
        loc=location;
        loc.person = 0;
        tempWorld(floor(index/width)+1,mod(index,width)+1) = loc;
    end
    
    
    %random distribution of the agents within the world
    size = height*width;
    randPositions = randperm(size);
    
    for index = 0:height*width-1
       world(floor((randPositions(index+1)-1)/width)+1,mod(randPositions(index+1)-1,width)+1) =  tempWorld(floor(index/width)+1,mod(index,width)+1);
    end  
end