% Modelo em camadas de fundo com Detecção de Sombra
clc;clear;close all;
vid = videoinput('winvideo',1,'YUY2_160x120');
set(vid,'TriggerRepeat',Inf);
set(vid, 'ReturnedColorSpace', 'rgb');
vid.FrameGrabInterval = 5;
start(vid);

N = 5; % number of layers
T = 20; % RGB Euclidian threshold
U = 0.999; % update rate
A = 0.85; % fraction of observed colour to account for in the background


% Modelo de aprendizagem(imagem 1-5)
% Modelo de teste (imagem 6)
for i = 1:6
    %fn = sprintf('image%d.jpg', i);
    I = getdata(vid,2);
    fn = I(:,:,:,1);
    im = im2double(fn);
    im = subsample3(im, 320, 240);
    if (i==1)        
        bgmodel = initLayeredBackgroundModel(im, N, T, U, A);
    else
        [bgmodel, foreground, bridif, coldif, shadows] = updateLayeredBackgroundModel(bgmodel, im);
        
        if (i==6)
            while (1)
                I = getdata(vid,2);
                fn = I(:,:,:,1);
                im = im2double(fn);
                im = subsample3(im, 320, 240);
                
                subplot(2,3,1);
                shownormimage2(im); title('Image');
                subplot(2,3,2);
                shownormimage2(foreground); title('Detectado Foreground');
                subplot(2,3,4);
                shownormimage2(shadows); title('Sombras');
                subplot(2,3,5);
                imfg = removesmallregions3(foreground,100);
                shownormimage2(imfg); title('Limpa foreground');
                subplot(2,3,6);
                shownormimage2(bluescreen(imfg, im)); title('Objeto detectado');
                pause(0.05);
            end
        end
    end
end

stop(vid);
delete(vid);


