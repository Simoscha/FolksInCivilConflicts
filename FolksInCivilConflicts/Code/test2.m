global halo;
halo

%{
main;
counter=0;
for k1=1:20
    for k2=1:20
        counter=counter+1;
        world(k2,k1).newInfluences(world);
        a(counter)=world(k2,k1).infMafia;
        b(counter)=world(k2,k1).infPolice;
        c(counter)=world(k2,k1).infTot;
    end

end
%}