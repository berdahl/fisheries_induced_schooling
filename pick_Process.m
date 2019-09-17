function [ process_TODO ] = pick_Process( no_name, alpha, beta, gamma, popSize, numGroups, fishMood, groupMoodFrac  )
%PICKPROCESS Summary of this function goes here
%   Detailed explanation goes here

    %%
    % there are three different processes that can occur
    rate_Fiss_classic = no_name*numGroups;
    rate_Fiss_new = alpha*length(fishMood(fishMood==1));
    rate_Fuss = (beta + gamma*mean(groupMoodFrac))*numGroups*(numGroups-1)/2;

    
    % These COULD be simplified/approximated as follows
    %rate_Fiss_classic = 1;
    %rate_Fiss_new = alpha*length(fishMood(fishMood==1))/numGroups;
    %rate_Fuss_classic = beta*numGroups;
    %rate_Fuss_new = gamma*sum(groupMoodFrac);


     %% Just make sure...
    if(numGroups==1)
       rate_Fuss = 0; 
    end
    if(numGroups==popSize)
       rate_Fiss_classic = 0;
       rate_Fiss_new = 0; 
    end
    
    %% turn rates into probs 
    %make a normalization
    Z = rate_Fiss_classic + rate_Fiss_new + rate_Fuss;
    
    %normalize these probabilities
    prob_Fiss_classic = rate_Fiss_classic/Z;
    prob_Fiss_new = rate_Fiss_new/Z;
    %prob_Fuss = rate_Fuss/Z;

    %% pick a process
    bound1 = prob_Fiss_classic;
    bound2 = bound1 + prob_Fiss_new;


    
    picker = rand;
    
    if(isnan(bound1))
        %debugging
        problem = 'hey, there is a problem!!!'
    elseif(picker<=bound1)
        process_TODO = 1;
    elseif(picker<=bound2)
        process_TODO = 2;
    else
        process_TODO = 3;
    end
    
    
end

