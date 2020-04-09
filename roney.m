clear;clc;close all;
% le imagens
a = imread('a.jpg');
b = imread('b.jpg');

% Converte para tons de cinza
ac = rgb2gray(a);
bc = rgb2gray(b);

[x y] = size(ac);
for i = 1 : x
    for j = 1 : y
        if ac(i,j)==91
           ab(i,j) =255;
        else
           ab(i,j) =0;
        end
    end
end
figure;imshow(a);
figure;imshow(ab);