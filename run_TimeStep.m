function [ G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac, process_TODO ] = run_TimeStep( no_name, alpha, beta, gamma, popSize,  G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac, fishLimits )
%RUN_TIMESTEP Summary of this function goes here
%   Detailed explanation goes here


%% pick something to do among fiss fiss_new, fuss and fuss_new...
[ process_TODO ] = pick_Process( no_name, alpha, beta, gamma, popSize, numGroups, fishMood, groupMoodFrac);



    if(process_TODO==1)
        %%
        %do Fision classic
        [ G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac  ] = do_FissionClassic( G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac, fishLimits );
    end
        
      
    if(process_TODO==2)
        %% do NEW Fission
       [ G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac  ] = do_FissionNew( G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac, fishLimits );
    end
       

    if(process_TODO==3)
            %%
            %do Fussion new
            %max(groupMoodFrac)
            %groupMoodFrac
            [ G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac  ] = do_FusionNet( G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac, fishLimits, beta, gamma );

    end

    
   % if(any(isnan(groupMoodFrac)))
   %     process_TODO
   %     G
   %     groupSizeList
   %     numGroups
   %     fishGroupID
   %     fishMood
   %     groupMoodFrac
   %     fishLimits
   % end

end

