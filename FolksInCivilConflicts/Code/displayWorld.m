function [] = displayWorld(world)
    height = length(world(:,1));
    width = length(world(1,:));

    for index = 0:height*width-1
       y = floor(index/width)+1;
       x = mod(index,width)+1;
       if(0 == world(y,x).person.number)
         plot(x,y,'.g');  
         hold on
       else
          blue = world(y,x).person.basicSupport;
          red = 1 - world(y,x).person.basicSupport;
          xd = x;
          yd = y;
          plot(x,y,'-mo',...
            'LineWidth',2,...
            'MarkerEdgeColor','k',...
            'MarkerFaceColor',[red 0 blue],...
            'MarkerSize',10); 
          hold on
          
       end
    end
    hold off
    drawnow
end