function [ G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac  ] = do_FissionNew( G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac, fishLimits )
%DO_FISSIONNEW Summary of this function goes here
%   Detailed explanation goes here


    %pick a random fish that thinks its group is too big
    
    %1 find all of them that think group is too big
    mood1_indy = find(fishMood==1);
    
    %this while loop is to make sure you don't pick a monomer
    thisGroupSize=0;
    while(thisGroupSize<2)
        
        %pick one of these fish at random
        fish_indy = randi(length(fishMood(fishMood==1)),1); %%%%% we already do this in the rate stage, combine to speed it up...
        leadFish = mood1_indy(fish_indy);
        
        % Find the group that this fish belongs to
        thisGroup = fishGroupID(leadFish);
    
        %findthe size of that group
        thisGroupSize = groupSizeList(thisGroup);
    end
    
    

    
        %find all (mood=1) fish in that group
        members = G{thisGroup};
        mood1members = members(fishMood(members)==1); %I am not sure about this step!

        %split off all mood1 fish, up to 1/2 of the group size
        half = round(thisGroupSize/2);
        numMood1 = length(mood1members);


        if(half==thisGroupSize)
            numFish2Leave = 1;
            twoFish = G{thisGroup};
            G{thisGroup} = twoFish(1);
            G{numGroups +1} = twoFish(2);
        % If less than half of the group is mood=1, split off all of them
        elseif(numMood1 <= half)
                G{thisGroup} = members(fishMood(members)<1);   
                G{numGroups +1} = members(fishMood(members)==1);
                numFish2Leave = numMood1;

        % ...or else randomly choose a fraction(t) of the mood=1 fish to split off
        else
            splitFish = randperm(numMood1,half);
            G{thisGroup} = members(~ismember(members,mood1members(splitFish)));
            G{numGroups +1} = mood1members(splitFish);
            numFish2Leave = half;

        end

            %update Group Size List
            groupSizeList(thisGroup) = length(G{thisGroup});
            groupSizeList(numGroups+1) = numFish2Leave;

            numGroups = numGroups + 1;

            %update GroupIDs
            fishGroupID(G{numGroups}) = numGroups;

            %update fish moods
            %first fish who stayed
            for i=1:groupSizeList(thisGroup)
                fishMood(G{thisGroup}(i)) = get_FishMood( fishLimits(G{thisGroup}(i),1), fishLimits(G{thisGroup}(i),2), groupSizeList(thisGroup));            
            end
            %then fish who left
            for i=1:groupSizeList(numGroups)
                fishMood(G{numGroups}(i)) = get_FishMood( fishLimits(G{numGroups}(i),1), fishLimits(G{numGroups}(i),2), groupSizeList(numGroups));            
            end

            %update the groupMoodFrac list
            groupMoodFrac(thisGroup) = get_GroupMood( G{thisGroup}, fishMood, groupSizeList(thisGroup) );
            groupMoodFrac(numGroups) = get_GroupMood( G{numGroups}, fishMood, groupSizeList(numGroups) );




end

