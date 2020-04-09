% Segmenta a imagem vermalha
% Captura video pela WebCam e segmenta imagem
% Autor: Nielsen C. Damasceno
clear; clc; close all;

vid = videoinput('winvideo',1,'YUY2_160x120');
set(vid,'TriggerRepeat',Inf);
set(vid, 'ReturnedColorSpace', 'rgb');
vid.FrameGrabInterval = 5;
start(vid);

while(1)
    IM = getdata(vid,2);
    I = IM(:,:,:,1);
    IGray = rgb2gray(IM(:,:,1:3));
    b = double(I);
    c1 = b(:,:,1) - b(:,:,2);
    c2 = b(:,:,1) - b(:,:,3);
    c1 = c1>40;
    c2 = c2>30;
    d = b(:,:,1).*c2.*c1;
    e = imdilate(d,strel('disk',7));
    f = e>0;
    f = f*255;
    f = imresize(f,.5);
    g2 = edge(IGray,'sobel'); 
    g3 = edge(IGray, 'log', 0, 2);
    g4 = imhist(IGray);
    g5 = medfilt2(IGray);
    g6 = imerode(IGray,strel('disk',11)); 
    subplot(3,3,1);imshow(I(:,:,:,1));title('Entrada Video-Imagem');
    subplot(3,3,2);imshow(IGray);title('Tons de cinza');
    subplot(3,3,3);imshow(f);title('imagem f ');
    subplot(3,3,4);imshow(g3);title('segmentada com Lapla da Gauss');
    subplot(3,3,5);imshow(g2);title('segmentada com sobel');
    subplot(3,3,6);plot(g4);title('Histograma');
    subplot(3,3,7);imshow(e);title('Dilatação');
    subplot(3,3,8);imshow(g5);title('Mediana');
    subplot(3,3,9);imshow(g6);title('Erosão');
    pause(0.05);
end
stop(vid);
