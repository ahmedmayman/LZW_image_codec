% this is a test script for the LZW_img_enc() and LZW_img_dec() functions
% implementing Lempel Ziv Welch method to encode and then decode an image
% calculating the output-to-input compression ratio of the encoding
%
% created by : Ahmed Mohamed Ayman
% date : 13 April 2017
%
clear;

%%
% reading the input image
Input = imread('Image.jpg');
%%
% creating binary vector
Binary = imbinarize(Input(:,:,1));
%%
% Encoding the image
Encoded = logical(LZW_img_enc(Binary')); % the transpose to ascend through the elements row by row
%%
% calculating the compression ratio
Ratio = numel(Encoded)/numel(Binary);
%%
% Decoding the encoded image and fitting to the original size
Decoded = logical(vec2mat(LZW_img_dec(Encoded),numel(Binary(1,:))));
%%
% demonstrating the two images before and after encoding
imshowpair(Input,Decoded,'montage');
