% A seguinte fun��o suaviza uma imagem
% dada uma m�scara pr�-definida utilizando a convolu��o por fourier
% Entrada:  a � a imagem
%
% Sa�da: 	w � o vetor resultante
%
%
%
% Author:   Nielsen C. Damasceno
% Date:     26.05.2011
function w = suaviza(a)
    
    a = double(rgb2gray(a)/255);
    [m,n] = size(a);
    mask = [0 0.5 0; 0.1 1 0.5; 0 0.5 0];
    % Convolu��o por Fourier
    f = fftshift(fft2(a));
    fmask = fftshift(fft2(mask,m,n));
    r =((fmask).*(f));% comutativa
    w = abs(ifft2(r));
end