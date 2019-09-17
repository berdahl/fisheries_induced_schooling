function [ G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac  ] = do_FusionNet( G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac, fishLimits, beta, gamma  )
%DO_FUSIONNEW Summary of this function goes here
%   Detailed explanation goes here

        %select 2 groups
        [fusionGroups(1), fusionGroups(2)] = pick_2Groups( groupMoodFrac, beta, gamma  );
        

        
       
             %update GroupIDs 1/2
                fishGroupID(G{fusionGroups(2)}) = fusionGroups(1);

                % Merge the membership of these two groups
                G{fusionGroups(1)} = [G{fusionGroups(1)} G{fusionGroups(2)}];




                %update Group Size List 1/2
                groupSizeList(fusionGroups(1)) = length(G{fusionGroups(1)});

                %update fish moods (doing this before deleteing the old group so the indexing is still OK)
                for i=1:groupSizeList(fusionGroups(1))
                    fishMood(G{fusionGroups(1)}(i)) = get_FishMood( fishLimits(G{fusionGroups(1)}(i),1), fishLimits(G{fusionGroups(1)}(i),2), groupSizeList(fusionGroups(1)));            
                end

                %update the groupMoodFrac list 1/2
                groupMoodFrac(fusionGroups(1)) = get_GroupMood( G{fusionGroups(1)}, fishMood, groupSizeList(fusionGroups(1)) );

                %update Group Size List 2/2
                groupSizeList(fusionGroups(2)) = [];

                %update the groupMoodFrac list 2/2
                groupMoodFrac(fusionGroups(2)) = [];


                % Delete the old group
                G(fusionGroups(2)) = [];

                % Update the number of groups
                numGroups = numGroups - 1;

                %now we need to fix the groupIDs!
                fishToRatchDown = find(fishGroupID>fusionGroups(2));
                fishGroupID(fishToRatchDown) = fishGroupID(fishToRatchDown)-1;
       


end

