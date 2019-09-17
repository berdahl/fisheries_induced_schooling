function [ group1, group2 ] = pick_2Groups( groupMoodFrac, beta, gamma )
%PICKGROUP Summary of this function goes here
%   Detailed explanation goes here

    probber = beta + gamma*groupMoodFrac(:)';
    probber = probber./sum(probber);

    x = cumsum([0 probber]);
    x(end) = 1e3*eps + x(end);
    [foo, group1] = histc(rand,x);
    
    probber(group1) = 0;
    probber = probber./sum(probber);
    x = cumsum([0 probber]);
    x(end) = 1e3*eps + x(end);
    [foo, group2] = histc(rand,x);

end

