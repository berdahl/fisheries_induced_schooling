function [  G, groupSizeList, fishGroupID] = setUp_groups( popSize, numGroups )
%SETUP Summary of this function goes here
%   Detailed explanation goes here

    groupSizeList = ones(numGroups,1);
    fishGroupID = zeros(numGroups,1);
    for i=1:numGroups
        G{i} = i;
        fishGroupID(i) = i;
    end
    
    for i=(numGroups+1):popSize
        groupID = randi(numGroups,1,1);
        G{groupID} = [G{groupID} i];
        groupSizeList(groupID) = groupSizeList(groupID) + 1;
        fishGroupID(i) = groupID;
    end




end

