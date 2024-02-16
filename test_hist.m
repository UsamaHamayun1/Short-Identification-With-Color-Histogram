clc
clear all 
close all

FCB_image= imread("soccer\barcelona\28.jpg");
FCB_fragment=imread("Fragment.jpg");
% extracting the fragment and saving it 
[red_frag,rect] = imcrop(FCB_image);
[blue_frag,rect]=imcrop(FCB_image);
% for better accuracy 
image_fcb= im2double(FCB_image);
imshow(blue_frag)
imshow(red_frag)
