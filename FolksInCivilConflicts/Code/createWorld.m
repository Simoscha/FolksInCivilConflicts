function world = createWorld(height,width,peopleAmount)

    vision = 1;
    jailtime=6;
    injury=6;
     
    world(height,width) = location; %allocates memory for the world array
    tempWorld(height,width) = location; %allocates memory for the tempWorld array
    
    %fill with people
    for index = 0:peopleAmount-1
        p = agent;
        loc=location;
        loc.vision = vision;
        p.place = loc;
        loc.person = p;
        p.initAgent(index+1);
        tempWorld(floor(index/width)+1,mod(index,width)+1) = loc;
    end
    
    %fill empy agents for empty fields
    for index = peopleAmount:(height*width-1)
        loc=location;
        loc.vision = vision;
        p = agent;
        p.number = 0;
        loc.person = p;
        tempWorld(floor(index/width)+1,mod(index,width)+1) = loc;
    end
    
    
    %random distribution of the agents within the world
    size = height*width;
    randPositions = randperm(size);
    
    for index = 0:height*width-1
       x = floor((randPositions(index+1)-1)/width)+1;
       y = mod(randPositions(index+1)-1,width)+1;
       world(x,y) =  tempWorld(floor(index/width)+1,mod(index,width)+1);
       world(x,y).x = x;
       world(x,y).y = y;
    end  
    
    %initializes all the Locations and agents with their initial properties.
    initAll(world,vision,jailtime,injury);
    hallo='initialisiert'

    
end