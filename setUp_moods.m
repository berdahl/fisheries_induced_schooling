function [ fishMood, groupMoodFrac ] = setUp_moods( popSize, numGroups, G, fishGroupID, groupSizeList, fishLimits)
%SETUP_MOODS Summary of this function goes here
%   Detailed explanation goes here


fishMood = zeros(popSize,1);

    % Initialize  Mood
    for i=1:popSize
        % Find the group that this fish belongs to
        thisGroup = fishGroupID(i);
        
        thisGroupSize = groupSizeList(thisGroup);

        if(thisGroupSize>fishLimits(i,2))
            fishMood(i) = 1;
        end
        if(thisGroupSize<fishLimits(i,1))
            fishMood(i) = -1;
        end        
    end


    groupMoodFrac = zeros(numGroups,1);
    %initialize this
    for i=1:numGroups
        fishInGroup = G{i};
        moodsInGroup = fishMood(fishInGroup);
        numInMoodMinus = length(moodsInGroup(moodsInGroup==-1));
        groupMoodFrac(i) = numInMoodMinus/groupSizeList(i);
    end   
    

end

