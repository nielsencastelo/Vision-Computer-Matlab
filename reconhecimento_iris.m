% Reconhecimento de iris

close all;clear;clc;

vid = videoinput('winvideo',1,'YUY2_352x288');
set(vid,'TriggerRepeat',Inf);
set(vid, 'ReturnedColorSpace', 'rgb');
vid.FrameGrabInterval = 5;
start(vid);

% Create a cascade detector de iris.
EyeDetector = vision.CascadeObjectDetector('EyePairBig');

try
    while(1) % Para parar o algoritmo use Ctrl+C
       
       IM = getdata(vid,2);
       I = IM(:,:,:,1);
       
       BB = step(EyeDetector,I);
       figure(1);
       imshow(I); hold on;

       rectangle('Position',BB,'LineWidth',4,'LineStyle','-','EdgeColor','r');
       
       Eyes = imcrop(I,BB);
       title('reconhecimento de face');
       hold off;
       
       pause(0.25);
    end
catch
    stop(vid);
end