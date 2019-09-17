function [ moodMinusFrac ] = get_GroupMood( fishInGroup, fishMood, groupSize )
%GETGROUPMOOD Summary of this function goes here
%   Detailed explanation goes here

        moodsInGroup = fishMood(fishInGroup);
        numInMoodMinus = length(moodsInGroup(moodsInGroup==-1));
        moodMinusFrac = numInMoodMinus/groupSize;

end

