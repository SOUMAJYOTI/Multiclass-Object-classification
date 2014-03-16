function [enhanced] = c_enhance(im)

% Written by Soumajyoti Sarkar and Sibashis Chatterjee
% as a part of the Tagme Machine Learning Contest 2014
% held by Indian Institute of Science Bangalore.

srgb2lab = makecform('srgb2lab');
lab2srgb = makecform('lab2srgb');

shadow = imread(im);
shadow_lab = applycform(shadow, srgb2lab); % convert to L*a*b*

% the values of luminosity can span a range from 0 to 100; scale them
% to [0 1] range (appropriate for MATLAB(R) intensity images of class double)
% before applying the three contrast enhancement techniques
max_luminosity = 0.8;
L = shadow_lab(:,:,1)/max_luminosity;

% replace the luminosity layer with the processed data and then convert
% the image back to the RGB colorspace
shadow_imadjust = shadow_lab;
shadow_imadjust(:,:,1) = imadjust(L)*max_luminosity;
shadow_imadjust = applycform(shadow_imadjust, lab2srgb);

shadow_histeq = shadow_lab;
shadow_histeq(:,:,1) = histeq(L)*max_luminosity;
shadow_histeq = applycform(shadow_histeq, lab2srgb);

shadow_adapthisteq = shadow_lab;
shadow_adapthisteq(:,:,1) = adapthisteq(L)*max_luminosity;
shadow_adapthisteq = applycform(shadow_adapthisteq, lab2srgb);

noise_var = 0.008;
PSF = fspecial('motion', 11, 9);
I = im2double(shadow_adapthisteq);
estimated_noise = noise_var/var(I(:));
wnr3 = deconvwnr(I, PSF, estimated_noise);
enhanced = wnr3;

