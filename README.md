# Research Plan FolksInCivilConflicts
---------------------------------------
* Group Name: Mafia of Conflicts
* Group participants names: Florian Gubler, Christian Käslin, Simon Schaefer
* Project Title: FolksInCivilConflicts 

## General Introduction
Civil violence has become a more and more dominating subject in the news. There were several conflicts from governments against the civilians in the last few years. Currently in Syria the people have to bear misery.
But we would like to take a closer look at the drug war in Mexico. Over 47000 people died during the last five years because of the drug war. Several regions are under control of the Mafia, rather than their government. Several rival Mafias fight for the dominance. The police have too few people to get it under control. There are about 100000 people of police and military against about 300000 people from the mafia because it has a great economical background from their drug business. If the government gets one region under control, problems will just continue in another region.
In our research we would like to find optimal strategies for the government to reduce the civil violence as much as possible.

## The Model
### Map
* Population density
* Prosperity

### Initial Parameters
* Number of Mafia followers
* Number of Police officers

### Agent: Police officer
* Traitor? (true/false)
* Willingness to assume risks
* Influence on his environment

### Agent: Mafia agent
* Traitor? (true/false)
* Willingness to assume risks
* Influence on his environment

### Agent: General Population
* General satisfaction/hardship
* Support for the Mafia
* Support for the Police
* Willingness to assume risks
* Influence on his environment
 
## Fundamental Questions
(Main question)
How will the situation in the city, given by its initial parameters, evolve over time?  
(Secondary)
How should the general population act to improve or at least conserve the status of their daily life? 
How aggressively can the police act against suspects without suppressing the general population and therefore increasing their hardship?
How should the police act in general to help the population? 
(Optional)
How should the police balance short term suffering against long term benefit?
How can the Mafia best interfere with successful police work and therefore augment or at least conserve their power over the general population?

## Expected Results
1.	We expect us to find a system of differential equations which will show us an equilibrium of a stable ratio between police and Mafia agents. It seems possible to us that one of these two groups might get extinguished by one another, based on the parameters we initialize our map with. 
2.	Based on reports on current Mafia wars in Mexico City or Southern Italy we expect scenarios where Mafia groups get extinguished to be painful for the surrounding people. We plan to prove this by analyzing their hardship factor.
3.	We expect the Mafia to be more successful being less aggressive and suppressing against people. Furthermore the prosperity should be a significant parameter on how efficient Mafia agents can proceed.

## References
* Epstein, J. M. & Axtell, A. (1996) Growing Artificial Societies: Social Science from the Bottom Up 
* Civil_Violence_Epstein2002.pdf

## Research Methods
We’re planning to use Agent-Based Models to simulate different scenarios.
