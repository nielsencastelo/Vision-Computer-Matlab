% Teste da função regionprop

close all; clear; clc
im = imread('pillsetc.png');
figure;imshow(im);
% Converte em escala de cinza
img = rgb2gray(im);

% Binarização da imagem
uimg = graythresh(img);
bw = im2bw(img,uimg);

imshow(bw);

[L,Ne] = bwlabel(bw);

% Calcula as propriedades dos objetos
propried = regionprops(L);

hold on;
for n = 1:size(propried,1)
    rectangle('Position',propried(n).BoundingBox,'EdgeColor','g','LineWidth',2);
end

% Localiza area menores que 500
s = find([propried.Area]<600);
% Depois de encontrada marca as areas
for n = 1:size(s,2)
   rectangle('Position',propried(s(n)).BoundingBox,'EdgeColor','r','LineWidth',2);
end

% Agora vamos eliminar essas áreas
for n = 1 : size(s,2)
    d = round(propried(s(n)).BoundingBox);
    bw(d(2):d(2)+d(4),d(1):d(1)+d(3))=0;
end
figure
imshow(bw);