clc
clear all 
close all 

% Load the image of FC Barcelona shirt 
image_FCB = imread('blue_frag.jpg'); %% we have red_frag ; and pattern frag
mainFolder = 'soccer/teams/';

% List of team names
teams = {'madrid'}; %'acmilan','chelsea','juventus','liverpool','madrid','psv'};
numBins = 8;
distances = 0;
% Calculate the color histogram in RGB space for the Barcelona image
[r_hist, ~] = imhist(image_FCB(:, :, 1), numBins);
[g_hist, ~] = imhist(image_FCB(:, :, 2), numBins);
[b_hist, ~] = imhist(image_FCB(:, :, 3), numBins);

% Calculate the overall RGB color histogram for Barcelona image
rgb_hist_barca = [r_hist, g_hist, b_hist];

% Normalize the RGB color histogram for Barcelona image
rgbbarca_hist = rgb_hist_barca / sum(rgb_hist_barca);

% Define a threshold for similarity


for t = 1:length(teams)
    currentTeam = teams{t};
    teamImages = dir(fullfile(mainFolder, currentTeam, '*.jpg'));
    
    for i = 1:length(teamImages)
        teamImage = imread(fullfile(mainFolder, currentTeam, teamImages(i).name));
        hsvImage = rgb2hsv(teamImage);
        
        % calculate the color histogram in HSV space for the current team image
        [r_hist, ~] = imhist(hsvImage(:, :, 1), numBins);
        [g_hist, ~] = imhist(hsvImage(:, :, 2), numBins);
        [b_hist, ~] = imhist(hsvImage(:, :, 3), numBins);

        % calculate the overall RGB color histogram for the current team image
        rgb_hist = [r_hist, g_hist, b_hist];
        
        % normalize the RGB color histogram for the current team image
        rgb_hist = rgb_hist / sum(rgb_hist);

        % Calculate the chi-squared distance between the model histogram and the current image histogram
        dist = sum((rgbbarca_hist - rgb_hist).^2 ./ (rgbbarca_hist + rgb_hist));
        distances = [distances, dist];
        % If the distance is less than the threshold, the Barça shirt may appear in the image
        if dist > 1.7 && dist < 1.9
            disp(['Barça shirt detected in ', currentTeam, ' image ', num2str(i)]);
        else
            disp(['No Barça shirt detected in ', currentTeam, ' image ', num2str(i)]);
        end
    end
end
histogram(distances, 'BinWidth', 0.1);

xlabel('Distance');
ylabel('Frequency');
title('Distribution of Distances');
% Add a line for the chosen threshold
chosenThreshold = 1.3;  % Adjust this based on visual inspection
hold on;
plot([chosenThreshold, chosenThreshold], [0, max(histcounts(distances))], 'r--', 'LineWidth', 2);
hold off;