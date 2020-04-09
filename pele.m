% teste de segmentação de pele
clear; clc; close all;

vid = videoinput('winvideo',1,'YUY2_320x240');
set(vid,'TriggerRepeat',Inf);
set(vid, 'ReturnedColorSpace', 'rgb');
vid.FrameGrabInterval = 30;
start(vid);
while(1)
    %IM = getdata(vid,2);
    IM= getdata(vid, 1, 'double');
    I = IM(:,:,:,1);
    Iseg = segmenta_pele(I);
    subplot(2,1,1);imshow(I);
    subplot(2,1,2);imshow(Iseg);
    pause(0.01);
    drawnow
    %pause(0.01);
end
stop(vid);
delete(vid);