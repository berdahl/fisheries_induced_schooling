clear all; close all



%select hysteresis stroke direction
%upORdown = 'UP'
upORdown = 'DOWN'


rep = 50


%some parameters
optimal_GS = 800; %optimal group size, natural
optimal_width = exp(0.5); %width of natural fitness curve
theta = 0.1; %steepness on fishing curve
minTargetGSAD = 300;
delta_1 = 0.75; %minimum surival natural
delta_2 = 0.75; %minimum survival modern


d_rho = 0.1;


if (strcmp(upORdown,'UP'))
        rho_list = 0.0:d_rho:1;
end

if (strcmp(upORdown,'DOWN'))
        rho_list = 1.0:-1*d_rho:0;
end











%set parameters

popSize = 2^8 %20000 %40000;          % total number of fish in the system
initialNumGroups = 100;   %when you start a new generation you divide the fish into this many groups

evoNoise = 0.04; % this is the fractional change in traits when evolution happens

ccc = 10;
xxx = 0.1;
yyy = 0.01;

no_name = 1; % co-efficent of classic fission
alpha = xxx; % co-efficent of new fission
beta = yyy; % co-efficent of classic fusion
gamma = 2*yyy; % co-efficent of new fusion

%undriven conditions
%     no_name = 1; % co-efficent of classic fission
%     alpha = xxx/ccc; % co-efficent of new fission
%     beta = yyy; % co-efficent of classic fusion
%     gamma = 2*yyy/ccc; % co-efficent of new fusion

%very driven conditions 
%     no_name = 1; % co-efficent of classic fission
%     alpha = ccc*xxx; % co-efficent of new fission
%     beta = yyy; % co-efficent of classic fusion
%     gamma = 2*ccc*yyy; % co-efficent of new fusion



numGenerations = 1000;
time_BurnIn = popSize/10;
time_betweenFitnessUpdates = popSize/100;
num_fitnessUpdatesPerGen = 100;

%initialize fish limits
%(method #2 is all random between 0 and 100)
%(method #44 is all random between 0 and 2000)
method_limits = 44; 

% initialize the limits outside of the for loop
initial_Limits = setUp_limits( popSize, method_limits );



%%loop over rho
for ppp = 1:length(rho_list)
    
  
    rho = rho_list(ppp)
   
    
    %evolve some stuff
    [ fishLimits ] = run_Evolution( popSize, initialNumGroups, evoNoise, no_name, alpha, beta, gamma, optimal_GS, optimal_width, numGenerations, time_BurnIn, time_betweenFitnessUpdates, num_fitnessUpdatesPerGen, initial_Limits, theta, minTargetGSAD, delta_1, delta_2, rho, upORdown, rep );

    
    %save some stuff (list of final limits...)
                outFileName = ['evoData/listFinalFishLimits_Hyst-' upORdown '_popSize-' int2str(popSize) ...
                    '_optGS-' int2str(optimal_GS) '_optGSwidth-' num2str(optimal_width) ...
                    '_rho-' num2str(rho) ...
                    '_minSBC-' num2str(delta_1) ...
                    '_minSAD-' num2str(delta_2) ...
                    '_classicFis-' num2str(no_name) '_alpha-' num2str(alpha) '_beta-' num2str(beta) '_gamma-' num2str(gamma) ...
                    '_brnT-' int2str(time_BurnIn) '_skpT-' int2str(time_betweenFitnessUpdates) ...
                    '_numG-' int2str(numGenerations) '_numF-' int2str(num_fitnessUpdatesPerGen) ...
                    '_rep-' int2str(rep) '.txt'];
                
    dlmwrite(outFileName,fishLimits)

    %initialize the next generation with the previous one
    initial_Limits = fishLimits;
    
end


