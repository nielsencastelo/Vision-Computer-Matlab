% A seguinte função segmentar a pela usando RGB
% Técnicas clássicas de segmentação de pele humana
% Um pixel pertence a pele se satisfizer as condições abaixo:
% R > 95
% G > 40
% B > 20
% max {R, G, B} - min {R, G, B} > 15
% |R  G  B| > 15
% R>G
% R>B
%
% Entrada:  a é uma imagem RGB
%
% Saída: 	I retorna uma imagem segmentada
%
%
%
% Autor:   Nielsen C. Damasceno
% Data:     10.06.2011
function I = segmenta_pele(a)
[lin col din] = size(a);

    for i = 1 : lin
        for j = 1 : col
            p = a(i,j,:);
            ps = (p(1)>95/255).*(p(2)>40/255).*(p(3)>20/255).*(max(p) - min(p)>15/255).*(abs(p(1) - p(2))>15/255).*(p(1)== max(p));
            imagem(i,j) = ps;
        end
    end
    I = imagem;
end
% limiares em CbCr
% imgYCbCr = rgb2ycbcr(img);
% 
% img_s = double(((imgYCbCr(:,:,Cb)>76/255) .* (imgYCbCr(:,:,Cb)<128/255)).*((imgycbcr(:,:,cr)>132/255) .* (imgYCbCr(:,:,Cr)<174/255)));

% limiares em HS 
% imgHSV = rgb2hsv(img);
% 
% img_s = double((imgHSV(:,:,H)<50/360).*((imghsv(:,:,s)>0.23) .* (imgHSV(:,:,S)<0.68)));