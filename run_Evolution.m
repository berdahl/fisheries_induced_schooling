function [ fishLimits ] = run_Evolution( popSize, initialNumGroups, evoNoise, no_name, alpha, beta, gamma, optimal_GS, optimal_width, numGenerations, time_BurnIn, time_betweenFitnessUpdates, num_fitnessUpdatesPerGen, fishLimits, steepnessAD, minTargetGSAD, minSurvBC, minSurvAD, rho, upORdown, rep)
%RUN_EVOLUTION Summary of this function goes here
%   Detailed explanation goes here



%loop over generations
    for ggg = 1:numGenerations
        tic
        %ggg
        %initialize fitness
        fitness = ones(popSize,1);

        %initialize groups
        %put the fish into random groups (specify number of groups)
        numGroups = initialNumGroups;
        [  G, groupSizeList, fishGroupID ] = setUp_groups( popSize, numGroups );

        %initialize moods
        [ fishMood, groupMoodFrac ] = setUp_moods( popSize, numGroups, G, fishGroupID, groupSizeList, fishLimits);

        %tic
        % run burn in
        for t=1:time_BurnIn
            %run model for a timestep
            [ G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac, process_DONE ] = run_TimeStep( no_name, alpha, beta, gamma, popSize,  G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac, fishLimits );
        end
        %toc



        % loop
        for fff=1:num_fitnessUpdatesPerGen
            %fff
            %run for a bit
            for u=1:time_betweenFitnessUpdates
                %run model for a timestep
                [ G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac, process_DONE ] = run_TimeStep( no_name, alpha, beta, gamma, popSize,  G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac, fishLimits );
            end
            %update fitnesses 
            [ fitness ] = update_Fitness( fitness, optimal_GS, optimal_width, groupSizeList, fishGroupID, steepnessAD, minTargetGSAD, minSurvBC, minSurvAD, rho );
             
        end


            %save some stuff (for the second half of the generations)
        %if(ggg>(numGenerations/2))
        if(mod(ggg,10)==1)
                outFileName = ['evoData/meanFishLimits_Hyst-' upORdown  '_popSize-'  int2str(popSize) ...
                        '_optGS-' int2str(optimal_GS) '_optGSwidth-' num2str(optimal_width) ...
                        '_rho-' num2str(rho) ...
                        '_minSBC-' num2str(minSurvBC) ...
                        '_minSAD-' num2str(minSurvAD) ...
                        '_classicFis-' num2str(no_name) '_alpha-' num2str(alpha) '_beta-' num2str(beta) '_gamma-' num2str(gamma) ...
                        '_brnT-' int2str(time_BurnIn) '_skpT-' int2str(time_betweenFitnessUpdates) ...
                        '_numG-' int2str(numGenerations) '_numF-' int2str(num_fitnessUpdatesPerGen) ...
                        '_rep-' int2str(rep) '.txt'];


                    dlmwrite(outFileName,mean(fishLimits), '-append')
        end%if statement for saving every 10th generation

        %end


        %make a new generation 
        [ fishLimits ] = make_newGeneration( popSize, fitness, fishLimits, evoNoise );


        timeTaken=toc;

        % Display progress
        disp(['Generation ' int2str(ggg) ' of ' int2str(numGenerations) '']);
        disp(['    took ' num2str(timeTaken) 's to run']);




    end








end

