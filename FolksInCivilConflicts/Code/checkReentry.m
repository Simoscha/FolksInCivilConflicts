function [] = checkReentry(init,world)
%CHECKREENTRY
%counts the jailtime or injury value down, until the agent could be
%released and put back to the world
   global prison;
   global hospital;
   global k;
   prisonlength = length(prison);
   index = 2; %start at index 2 because the first field is empty
   while(index <= prisonlength)
      prison(index).jailtime = prison(index).jailtime - 1;
      if(prison(index).jailtime <= 0)
         %set satisfaction back
         prison(index).person.satisfaction=prison(index).person.satisfaction/ ...
             exp(-init.model.n_jailtime/k);
         reentry(world,prison(index).person);
         prison(index) = []; %delete the agent from prison
         prisonlength = prisonlength - 1;
         if(init.globals.DEBUG)
             disp('released')
         end
      else
         index = index + 1;
      end
      
   end
   hospitallength = length(hospital);
   index = 2;
   while(index <= hospitallength)
      hospital(index).injury = hospital(index).injury - 1;
      if(hospital(index).injury <= 0)
          %set satisfaction back
          hospital(index).person.satisfaction=hospital(index).person.satisfaction/ ...
              exp(-init.model.n_injury/k);
          reentry(world,hospital(index).person);
          hospital(index)= []; %delete agent from hospital
          hospitallength = hospitallength - 1;
          if(init.globals.DEBUG)
             disp('health')
          end
      else
          index = index + 1;
      end
   end

end