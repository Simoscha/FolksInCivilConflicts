function [ policemen,mafiosi ] = totalActives( world )
%TOTALACTIVES Summary of this function goes here
%   Detailed explanation goes here
    mafiosi=0;
    policemen=0;
    [agents,counter]=findAgents(world);
    for k=1:counter
        if(agents(k).support>0.75)
            policemen=policemen+1;
        end
        if (agents(k).support<0.25)
              mafiosi=mafiosi+1;
        end
    end

end

