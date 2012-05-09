function world = createWorld(init)
    height = init.model.n_worldHeight;
    width = init.model.n_worldWidth;
    peopleAmount = init.model.n_agents;
    world(height,width) = location; %allocates memory for the world array
    tempWorld(height,width) = location; %allocates memory for the tempWorld array
    
    %fill with people
    for index = 0:peopleAmount-1
        p = agent;
        loc=location;
        loc.vision = init.model.n_vision;
        p.place = loc;
        loc.person = p;
        p.initAgent(index+1);
        tempWorld(floor(index/width)+1,mod(index,width)+1) = loc;
    end
    
    %fill empy agents for empty fields
    for index = peopleAmount:(height*width-1)
        loc=location;
        loc.vision = init.model.n_vision;
        p = agent;
        p.number = 0;
        loc.person = p;
        tempWorld(floor(index/width)+1,mod(index,width)+1) = loc;
    end
    
    %random distribution of the agents within the world
    size = height*width;
    randPositions = randperm(size);
    
    for index = 0:size-1
       y = floor((randPositions(index+1)-1)/width)+1;
       x = mod(randPositions(index+1)-1,width)+1;
       world(y,x) =  tempWorld(floor(index/width)+1,mod(index,width)+1);
       world(y,x).x = x;
       world(y,x).y = y;
    end 
    
    %initializes all the Locations and agents with their initial properties.
    initAll(world,init.model.n_vision,init.model.n_jailtime,init.model.n_injury);
    
    if(init.globals.DEBUG)
        disp('initialisiert');
    end

    
end