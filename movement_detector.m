%% Detector de movimento
% Captura video pela WebCam e detecta o movimento.
% Autor: Nielsen C. Damasceno
clear;
clc;
vid = videoinput('winvideo',1,'YUY2_640x480');
set(vid,'TriggerRepeat',Inf);
set(vid, 'ReturnedColorSpace', 'rgb');
vid.FrameGrabInterval = 5;
start(vid);

try
    while(vid.FramesAcquired <= 200) % Parar após 200 frames
        IM = getdata(vid,2);
        IMGray = rgb2gray(IM(:,:,1:3));
        IMbw = im2bw(IMGray,0.5);
        IMneg = imadjust(IMGray,[0 1],[1 0]);
        
        subplot(2,3,1);imshow(IM(:,:,:,1));title('Entrada Video-Imagem')
        subplot(2,3,2);imshow(IMbw);title('Video Preto e Branco')
        subplot(2,3,3);imshow(IMGray);title('Video com escala de cinza')
        subplot(2,3,4);imshow(IMneg);title('Negativo da imagem do video')
        
        i1 = IM(:,:,:,1);
        i2 = IM(:,:,:,2);
        i1 = rgb2gray(i1(:,:,1:3));
        i2 = rgb2gray(i2(:,:,1:3));
        m  = abs(double(i1) - double(i2))/256;
        subplot(2,3,5);imshow(m);title('Visualização do movimento')
             
        if sum(sum(m)) > 4.5383e+004 %% Sensibilidade da Web Cam
            beep;
            background = getsnapshot(vid);
            background = double(background)/255;
            imwrite(background,'captura.jpg');
            subplot(2,3,6);imshow(background);title('Imagem Capturada')
        end
       pause(0.25);
    end
    stop(vid);
catch
    stop(vid);
end