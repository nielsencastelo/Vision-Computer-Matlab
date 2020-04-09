clear;close all;clc;
vid = videoinput('winvideo',1,'YUY2_320x240');
set(vid,'TriggerRepeat',Inf);
set(vid, 'ReturnedColorSpace', 'rgb');
vid.FrameGrabInterval = 5;
start(vid);

% Classificação e ação do NXT
while(1)
    IM = getdata(vid,2);
    I = IM(:,:,:,1);
    E = entropyfilt(I);
    Eim = mat2gray(E);
    BW1 = im2bw(Eim, .8);
    BWao = bwareaopen(BW1,2000);
    nhood = true(9);
    closeBWao = imclose(BWao,nhood);
    roughMask = imfill(closeBWao,'holes');
    I2 = I;
    I2(roughMask) = 0;
    E2 = entropyfilt(I2);
    E2im = mat2gray(E2);
    BW2 = im2bw(E2im,graythresh(E2im));
    mask2 = bwareaopen(BW2,1000);
    texture1 = I;
    texture1(~mask2) = 0;
    texture2 = I;
    texture2(mask2) = 0;
    boundary = bwperim(mask2);
    segmentResults = I;
    segmentResults(boundary) = 255;
    
    subplot(2,2,1);imshow(I(:,:,:,1));title('Entrada Video-Imagem');
    subplot(2,2,2);imshow(texture1);
    subplot(2,2,3);imshow(texture2);
    subplot(2,2,4);imshow(segmentResults);
    pause(0.5);
end
stop(vid);