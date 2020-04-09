% Identifica objetos redondos
clear;clc;close all;



% preencher todos os furos, de modo que regionprops pode ser usado para estimar
% a área delimitada por cada uma das fronteiras

clear; clc; close all;
vid = videoinput('winvideo',1,'YUY2_160x120');
set(vid,'TriggerRepeat',Inf);
set(vid, 'ReturnedColorSpace', 'rgb');
vid.FrameGrabInterval = 5;
start(vid)

while(1)
    IM = getdata(vid,2);
    RGB = IM(:,:,:,1);
    % Converter a imagem para preto e branco, a fim de preparar-se para 
    % fronteira rastreamento usando bwboundaries.
    I = rgb2gray(RGB);
    threshold = graythresh(I);
    bw = im2bw(I,threshold);
    % Usando funções morfologia, remove os pixels que não pertencem aos 
    % objetos de interesse
    % remover todos os objetos que contenham menos de 30 pixels
    bw = bwareaopen(bw,30);

    % preencher uma lacuna na tampa da caneta
    se = strel('disk',2);
    bw = imclose(bw,se);
    bw = imfill(bw,'holes');
    imshow(bw)

    [B,L] = bwboundaries(bw,'noholes');

    % Display the label matrix and draw each boundary
    imshow(label2rgb(L, @jet, [.5 .5 .5]))
    hold on
    for k = 1:length(B)
        boundary = B{k};
        plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
    end
    
    pause(0.05);
end
stop(vid);


