function [ fitness ] = update_Fitness( fitness, GS_opt, GS_sig, groupSizeList, fishGroupID, steepnessAD, minTargetGSAD, minSurvBC, minSurvAD, ADvsBC)
%UPDATEFITNESS Summary of this function goes here
%   Detailed explanation goes here

fishGroupSize = groupSizeList(fishGroupID); 

fitness = fitness.*fitnessVSgroupsize( fishGroupSize, GS_opt, GS_sig, steepnessAD, minTargetGSAD, minSurvBC, minSurvAD, ADvsBC );



end

