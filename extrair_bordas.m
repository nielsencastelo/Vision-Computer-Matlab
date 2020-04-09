% A seguinte função extrai bordas de uma imagem
% utilizando a convolução por fourier
% Entrada:  a é a imagem
%
% Saída: 	wx são as bordas horizontais
%           wy são as bordas verticais
%
%
% Author:   Nielsen C. Damasceno
% Date:     26.05.2011
function [wx,wy] = extrair_bordas(a)

    a = double(rgb2gray(a)/255);
    [m,n]=size(a);
    sobx =[1 2 1;0 0 0; -1 -2 -1];   
    soby=[-1 0 1;-2 0 2;-1 0 1];
    f = fftshift( fft2(a));
    fsobx = fftshift(fft2(sobx,m,n));
    fsoby = fftshift(fft2(soby,m,n));
    rx =((fsobx).*(f));%comutativa
    ry =((fsoby).*(f));%comutativa
    wx = abs(ifft2(rx));
    wy = abs(ifft2(ry));
    subplot(1,3,1);  imagesc(a);axis equal
    subplot(1,3,2);  imagesc(wx);title('Bordas horizontais');axis equal
    subplot(1,3,3);  imagesc(wy);colormap(gray);title('Bordas verticais');axis equal
end