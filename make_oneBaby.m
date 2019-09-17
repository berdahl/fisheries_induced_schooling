function [ new_limits ] = make_oneBaby( limits, evoNoise )
%MAKE_ONEBABY Summary of this function goes here
%   Detailed explanation goes here

    %this way does it as a fraction
    %added the  + 1 to the first limit, so that it didn't get stuck at zero
    new_limits = [normrnd(limits(1),evoNoise*(limits(1)+1))     normrnd(limits(2),evoNoise*limits(2)) ];
    
    %this way does a fixed amount
    %new_limits = [normrnd(limits(1),evoNoise),     normrnd(limits(2), evoNoise) ];
    
    %this way does a logged amount
    %new_limits = [normrnd(limits(1),2*log2(limits(1)+2)),     normrnd(limits(2),2*log2(limits(2)+2)) ];
    
    %make sure not negative
    if(new_limits(1)<0)
        new_limits(1)=0;
    end
    %make sure they don't cross
    if(new_limits(2)<new_limits(1))
        new_limits(2)=new_limits(1);
    end

end

