clc;
clear all;
close all;
workspace;
fontSize = 24;

% Read the input image
inputImage = imread("soccer/teams/barcelona/04.jpg");

% Convert the input image to HSV color space
hsvImage = rgb2hsv(inputImage);
histogram(hsvImage)
% Define the color range for FC Barcelona shirts in HSV
hueRange = [0, 0.05]';  % Adjust as needed
saturationRange = [0.7, 1.0]';  % Adjust as needed
valueRange = [0.7, 1.0]';  % Adjust as needed

% Create a mask for the Barcelona shirt based on the defined color range
shirtMask = (hsvImage(:,:,1) >= hueRange(1) & hsvImage(:,:,1) <= hueRange(2)) & ...
    (hsvImage(:,:,2) >= saturationRange(1) & hsvImage(:,:,2) <= saturationRange(2)) & ...
    (hsvImage(:,:,3) >= valueRange(1) & hsvImage(:,:,3) <= valueRange(2));

% Apply the mask to the original image
detectedShirt = bsxfun(@times, inputImage, cast(shirtMask, 'like', inputImage));

% Display the results
figure;
subplot(1, 2, 1);
imshow(inputImage);
title('Original Image', 'FontSize', fontSize, 'Interpreter', 'None');

subplot(1, 2, 2);
imshow(detectedShirt);
title('Detected Barcelona Shirt', 'FontSize', fontSize, 'Interpreter', 'None');
