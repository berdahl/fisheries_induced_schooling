clear all; close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This code takes the output of main.m and runs it more to get group size histograms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



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



numGenerations = 100;
time_BurnIn = popSize/10;
time_betweenFitnessUpdates = popSize/100;
num_fitnessUpdatesPerGen = 100;

%timing parameters for this only (not from the evo stuff)
time_BurnIn_gs = 2*popSize/10;
num_updatesPerSave = popSize/40;
number_saves = 5000;




%loop over ADvsBC
for ppp = 1:length(rho_list)
    
    rho = rho_list(ppp)
    
    
    %load the already-evolved limits
    inFileName = ['evoData/listFinalFishLimits_Hyst-' upORdown '_popSize-' int2str(popSize) ...
                    '_optGS-' int2str(optimal_GS) '_optGSwidth-' num2str(optimal_width) ...
                    '_rho-' num2str(rho) ...
                    '_minSBC-' num2str(delta_1) ...
                    '_minSAD-' num2str(delta_2) ...
                    '_classicFis-' num2str(no_name) '_alpha-' num2str(alpha) '_beta-' num2str(beta) '_gamma-' num2str(gamma) ...
                    '_brnT-' int2str(time_BurnIn) '_skpT-' int2str(time_betweenFitnessUpdates) ...
                    '_numG-' int2str(numGenerations) '_numF-' int2str(num_fitnessUpdatesPerGen) ...
                    '_rep-' int2str(rep) '.txt'];
    fishLimits = load(inFileName);
    
    %initialize histogram stuff
    gsHist = zeros(popSize,1);
    bounds = 1:popSize;
    
    %initialize groups
    %put the fish into random groups (specify number of groups)
    numGroups = initialNumGroups;
    [  G, groupSizeList, fishGroupID ] = setUp_groups( popSize, numGroups );
    
    %initialize moods
    [ fishMood, groupMoodFrac ] = setUp_moods( popSize, numGroups, G, fishGroupID, groupSizeList, fishLimits);
    
    %run a burn in
    %tic
    % run burn in
    for t=1:time_BurnIn_gs
        %run model for a timestep
        [ G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac, process_DONE ] = run_TimeStep( no_name, alpha, beta, gamma, popSize,  G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac, fishLimits );
    end
    %toc
    
    
    %loop -- 
    for fff=1:number_saves
        tic
        %fff
        %run for a bit
        for u=1:num_updatesPerSave
            %u/num_updatesPerSave
            %run model for a timestep
            [ G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac, process_DONE ] = run_TimeStep( no_name, alpha, beta, gamma, popSize,  G, groupSizeList, numGroups, fishGroupID, fishMood, groupMoodFrac, fishLimits );
        end
        %update group size hist
        gsHist = gsHist + histc(groupSizeList,bounds);
        
        %plot(gsHist)
        %show()
        timeTaken=toc;

        % Display progress
        disp(['Update ' int2str(fff) ' of ' int2str(number_saves) '']);
        disp(['    took ' num2str(timeTaken) 's to run']);
        
    end

    
    SAVER = [bounds',gsHist];
    
    size(SAVER)
    
    %save histogram
                outFileName = ['groupData/gsHist_Hyst-' upORdown '_popSize-' int2str(popSize) ...
                    '_optGS-' int2str(optimal_GS) '_optGSwidth-' num2str(optimal_width) ...
                    '_rho-' num2str(rho) ...
                    '_minSBC-' num2str(delta_1) ...
                    '_minSAD-' num2str(delta_2) ...
                    '_classicFis-' num2str(no_name) '_alpha-' num2str(alpha) '_beta-' num2str(beta) '_gamma-' num2str(gamma) ...
                    '_brnT-' int2str(time_BurnIn) '_skpT-' int2str(time_betweenFitnessUpdates) ...
                    '_numG-' int2str(numGenerations) '_numF-' int2str(num_fitnessUpdatesPerGen) ...
                    '_rep-' int2str(rep) '.txt'];
                    
                
                dlmwrite(outFileName,SAVER)
                
    
end


