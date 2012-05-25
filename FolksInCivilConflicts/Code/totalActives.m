function [ policemen,mafiosi ] = totalActives( world )
%TOTALACTIVES 
global policeThreshold
global madiaThreshold
    mafiosi=0;
    policemen=0;
    [agents,counter]=findAgents(world);
    for k=1:counter
        if(agents(k).support>policeThreshold)
            policemen=policemen+1;
        end
        if (agents(k).support<madiaThreshold)
              mafiosi=mafiosi+1;
        end
    end

end

