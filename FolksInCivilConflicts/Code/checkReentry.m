function [] = checkReentry(init,world)
   global prison;
   global hospital;
   prisonlength = length(prison);
   index = 2;
   while(index <= prisonlength)
      prison(index).jailtime = prison(index).jailtime - 1;
      if(prison(index).jailtime <= 0)
         reentry(world,prison(index).person);
         prison(index) = [];
         prisonlength = prisonlength - 1;
         if(init.globals.DEBUG)
             disp('back')
         end
      else
         index = index + 1;
      end
      
   end
   hospitallength = length(hospital);
   index = 2;
   while(index <= hospitallength)
      hospital(index).injury = hospital(index).jailtime - 1;
      if(hospital(index).injury <= 0)
          reentry(world,hospital(index).person);
          hospital(index) = [];
          hospitallength = hospitallength - 1;
          if(init.globals.DEBUG)
             disp('health')
          end
      else
          index = index + 1;
      end
   end

end