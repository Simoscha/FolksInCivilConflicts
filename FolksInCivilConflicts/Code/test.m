global halo;
halo=5;
test2;


%{
p=agent;
p.initAgent(1);
loc=location;
loc.initLocation(1,1,5,5,1);
loc.person=p;
p.place=loc;
loc.pArrest=0.2;
loc.pInjury=0.6;
p.newSat;
p.satisfaction
p.satisfaction=3.3;
p.newRisk;
p.riskM
p.riskP
p.newSup;
p.support
%}