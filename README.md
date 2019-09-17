# fisheries_induced_schooling



To run the model presented in Guerra et al:

1. First run main.m.  This will scan over rho (relative strength of modern fishing), in an increasing or decreasing direction (depending on value of 'upORdown').  This will save both the averaged evolved limits and a list of the values of the evolved limits at the end of the simulation.  Data will be written to directory /evoData. 

2. Run main_groupSizes.m using the same parameters used in main.m.  This will take the output from main.m and run it, without evolution, to generate histrograms of group sizes at steady state in the population. Data will be written to directory /groupData.  


