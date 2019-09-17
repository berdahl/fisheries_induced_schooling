function [ G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac  ] = do_FissionClassic( G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac, fishLimits )
%DO_FISSIONCLASSIC Summary of this function goes here
%   Detailed explanation goes here


    %pick a random group, but not a monomer
    thisGroupSize = 0;
        while(thisGroupSize<2)
        fissionGroup = randi(numGroups,1);
        thisGroupSize = groupSizeList(fissionGroup);
    end

    if(thisGroupSize>1)

        %pick a random number of them to leave
        num2leave = randi((thisGroupSize-1),1);

        %pick indices of those to leave
        fish2leave = randperm(thisGroupSize,num2leave);


        %put leavers in a new group
        G{numGroups+1} = G{fissionGroup}(fish2leave);


        %winnow down original group
        G{fissionGroup}(fish2leave) = [];

        %update Group Size List
        groupSizeList(fissionGroup) = length(G{fissionGroup});
        groupSizeList(numGroups+1) = length(fish2leave);

        numGroups = numGroups + 1;

        %update GroupIDs
        fishGroupID(G{numGroups}) = numGroups;

        %update fish moods
        %first fish who stayed
        for i=1:groupSizeList(fissionGroup)
            fishMood(G{fissionGroup}(i)) = get_FishMood( fishLimits(G{fissionGroup}(i),1), fishLimits(G{fissionGroup}(i),2), groupSizeList(fissionGroup));            
        end
        %then fish who left
        for i=1:groupSizeList(numGroups)
            fishMood(G{numGroups}(i)) = get_FishMood( fishLimits(G{numGroups}(i),1), fishLimits(G{numGroups}(i),2), groupSizeList(numGroups));            
        end

        %update the groupMoodFrac list
        groupMoodFrac(fissionGroup) = get_GroupMood( G{fissionGroup}, fishMood, groupSizeList(fissionGroup) );
        groupMoodFrac(numGroups) = get_GroupMood( G{numGroups}, fishMood, groupSizeList(numGroups) );


    end

    

end

