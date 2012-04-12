function display = displayWorld(world)
    height = length(world(:,1));
    width = length(world(1,:));
    
    figure
    %plot satisfaction
    subplot(2,1,1);
    
    for index = 0:height*width-1
       y = floor(index/width)+1;
       x = mod(index,width)+1;
       if(0 == world(y,x).person.number)
         plot(y,x,'.g');  
         hold on
       else
          blue = world(y,x).person.satisfaction;
          red = 1 - world(y,x).person.satisfaction;
          plot(y,x,'-mo',...
            'LineWidth',2,...
            'MarkerEdgeColor','k',...
            'MarkerFaceColor',[red 0 blue],...
            'MarkerSize',10); 
          hold on
          
       end
    end 
    hold off;
    
    %plot basicsupport
    subplot(2,1,2);
    for index = 0:height*width-1
       y = floor(index/width)+1;
       x = mod(index,width)+1;
       if(0 == world(y,x).person.number)
         plot(y,x,'.g');  
         hold on
       else
          blue = world(y,x).person.basicSupport;
          red = 1 - world(y,x).person.basicSupport;
          plot(y,x,'-mo',...
            'LineWidth',2,...
            'MarkerEdgeColor','k',...
            'MarkerFaceColor',[red 0 blue],...
            'MarkerSize',10); 
          hold on
          
       end
    end
    
    hold off;
    
    display = 0;
end