% Remoção de ruido com transformada de fourier
clear; clc; close all;
% f = imread('Lena_ruido.bmp');
% fa = fftshift(fft2(f));
% PSF = fspecial('gaussian',size(f),60);
% h = imfilter(fa,PSF);
% 
% cv = h.*fa;
% yf = ifft2(fftshift(cv));
% 
% colormap gray;
% subplot(1,2,1);
% imshow(f);
% subplot(1,2,2);
% 
% imagesc(abs(yf));

%Read in image and take FT
A = imread('trui.png'); 
B = fft2(A); 
B = fftshift(B);

%Construct Gaussian PSF
[x y] = size(A); 
[X Y] = meshgrid(1:x,1:y); 			
h = exp(-(X-x/2).^2./48).*exp(-(Y-y/2).^2./48);		%extending over entire array
H = psf2otf(h,size(h)); H = fftshift(H);                %Get OTF corresponding to PSF
g=ifft2(B.*H); g=abs(g);                            %generate blurred image via %Fourier domain

G=fft2(g); G = fftshift(G);                           %Take FT of image
indices=find(H>1e-6);                               %Do inverse filtering AVOIDING
F=zeros(size(G)); F(indices)= G(indices)./H(indices);	%small values in OTF !!
f = ifft2(F); f=abs(f);                               %Inverse FT to get filtered image
subplot(1,4,1), imshow(g,[min(min(g)) max(max(g))]);	%Display “original” blurred image 
subplot(1,4,2), imagesc(h); axis square; axis off;		%Display PSF
subplot(1,4,3), imagesc(abs(H)); axis square; axis off; 	%Display MTF
subplot(1,4,4), imagesc(f); axis square; axis tight; axis off; 	%Display filtered image


