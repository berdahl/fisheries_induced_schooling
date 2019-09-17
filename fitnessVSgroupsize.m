function [ fit ] = fitnessVSgroupsize( groupSize, GS_opt, GS_sig, steepnessAD, minTargetGSAD, minSurvBC, minSurvAD, p )
%FITNESSVSGROUPSIZE Summary of this function goes here
%   Detailed explanation goes here



    mu = log(GS_opt);
    sig = log(GS_sig);

    BC = lognpdf(groupSize,mu,sig);
    maxer = lognpdf(exp(mu-sig^2),mu,sig);
    BC = (1-minSurvBC)*BC./maxer + minSurvBC;

    AD =  1 - (1-minSurvAD)./(1 + exp(-steepnessAD*(groupSize-minTargetGSAD)));

    fit = (AD.^(p)).*(BC.^(1-p));
    

end

