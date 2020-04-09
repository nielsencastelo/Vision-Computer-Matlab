% Detecção de objetos
clear; clc;close all;

% imaqhwinfo
% cam = imaqhwinfo;
% cam.InstalledAdaptors
% vid = videoinput('winvideo',1);
% preview(vid);
im = imread('fig_geometricos.jpg');
imbw = im2bw(im);
imshow(imbw);
[label num] = bwlabel(imbw,8);
graindata = regionprops(label,'all');

for i = 1 : num
    if graindata(i).Eccentricity < 0.7
        found = 1;
        area = graindata(found).Area;
        radius = sqrt(area/pi);
        centroide = graindata(found).Centroid;
        t = 0:pi/20:2*pi;
        x = centroide(1)+radius*cos(t);
        y = centroide(2)+radius*sin(t);
        hold on;
        plot(x,y);
    end
end

