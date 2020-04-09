clear; clc;

% CODIGO QUE CARREGA UM VIDEO EM 'avi', SEPARA OS FRAMES, 
% TRANFORMA EM IMAGEM E CALCULA O CENTROIDE DE CADA IMAGEM 

Movie = aviread('rat.avi');         % carrega video
info = aviinfo('Rat.avi');          % informacoes sobre video
Nframes = info.NumFrames;         % numero de frames do video carregado

% LAÇO PARA ACESSO A n-FRAMES DO VIDEO
% ------------------------------------


for i = 1: 100%Nframes
   
     Movie = aviread('Rat.avi',i);  % carrega video em 'avi' e acessa o i-frame  
         M = Movie.cdata;         % tranforma em imagem
         %D = rgb2gray(M);         % p/ observar em escala de cinzar
        %figure(1), imshow(D)     % p/ visualizar a i-imagem

% CHAMADA DA FUNCAO 'CentroideRato()'
% TENDO COMO PARAMETRO DE ENTRADA 'M'(i-imagem)
% E DE RETORNO A COMPONENTE (x,y) DO CENTROIDE  
%------------------------------------

     [x,y] = Centroide(M);

end
