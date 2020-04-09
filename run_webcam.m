clear; clc; close all;
vid = videoinput('winvideo',1,'YUY2_352x288');
set(vid,'TriggerRepeat',Inf);
set(vid, 'ReturnedColorSpace', 'rgb');
vid.FrameGrabInterval = 5;
start(vid);
try
    while(1)
       IM = getdata(vid,2);
       I = IM(:,:,:,1);
       imshow(I);
       IGray = rgb2gray(I);
       Ihist = (IGray);
       %g2 = edge(IGray,'sobel');
       %g3 = edge(IGray,'log');
       subplot(2,2,1);imshow(I);
       subplot(2,2,2);imshow(IGray);
       %subplot(2,2,3);hist(Ihist);
       %subplot(2,2,4);imshow(g3);
       pause(0.05);
    end
catch
    stop(vid);
end