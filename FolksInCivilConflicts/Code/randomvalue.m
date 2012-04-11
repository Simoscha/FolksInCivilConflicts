function [ number ] = randomvalue(n)
%RANDOMVALUE Summary of this function goes here
%   Detailed explanation goes here
% gives back a pseudorandom number between 0 and 1 with mean 0.5 and
% standard deviation 0.12 like that the safety protocol that
% sets negative numbers to zero and numbers >1 to 1 is almost never used.
% The +0.5 sets the mean from zero to 0.5 and the *0.12 sets the variance to (0.12)^2

   number=0.12*randn(n,1)+0.5;
    
   if(number<0)
       number=0;
   end
   if(number>1)
       number=1;
   end
      
end

