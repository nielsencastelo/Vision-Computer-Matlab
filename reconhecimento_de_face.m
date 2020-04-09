% Reconhecimento de face

close all;clear;clc;

vid = videoinput('winvideo',1,'YUY2_352x288');
set(vid,'TriggerRepeat',Inf);
set(vid, 'ReturnedColorSpace', 'rgb');
vid.FrameGrabInterval = 5;
start(vid);

% Create a cascade detector object.
faceDetector = vision.CascadeObjectDetector;

try
    while(1) % Para parar o algoritmo use Ctrl+C
       
       IM = getdata(vid,2);
       I = IM(:,:,:,1);
       
       BB = step(faceDetector,I);
       figure(1);
       imshow(I); hold on;

       for i = 1 : size(BB,1)
            rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
       end

       title('reconhecimento de face');
       hold off;
       
       pause(0.25);
    end
catch
    stop(vid);
end