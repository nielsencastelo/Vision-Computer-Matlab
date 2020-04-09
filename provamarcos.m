clc;clear;close all;
vid = videoinput('winvideo',1,'YUY2_160x120');
set(vid,'TriggerRepeat',Inf);
set(vid, 'ReturnedColorSpace', 'rgb');
vid.FrameGrabInterval = 5;
start(vid);
x = 120;
y = 160;

while(1)
    IM = getdata(vid,2);
    I = IM(:,:,:,1);
    r = I(:,:,1);
    g = I(:,:,2);
    b = I(:,:,3);
   
    for i = 1: x
        for j = 1 : y
            if r(i,j) > 80 && ~(g(i,j)> b(i,j)/2) || (g(i,j)>b(i,j)/2)
                r(i,j) = 255;
                g(i,j) = 255;
                b(i,j) = 255;
            end   
        end
    end
    g = cat(3,r,g,b);
    [cy,cx] = centroide(r);
    subplot(1,2,1);imshow(I(:,:,:,1));title('Entrada Video-Imagem');
    subplot(1,2,2);imshow(g);title('Cor detectada');
    hold on;
    plot(cy,cx,'rx');
    pause(0.05);
end
stop(vid);
delete(vid);
