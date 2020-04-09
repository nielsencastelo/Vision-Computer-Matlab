% Função que faz um janelamento de uma imagem bmp
% Entrada
%            a é a imagem
%            tam_jan é o tamanho da janela(ex.:4x4 seria 4)
% Saída
%             d_sai é a imagem janelada
% Data: 21/01/2014
% Autor: Nielsen C. Damasceno

function d_sai = janelamento_imagem(a,tam_jan)

    %a = imread('lena.bmp');

    figure; imagesc(a)
    colorbar
    colormap(gray)
    axis equal
    axis off
    set(gcf, 'color', [ 1 1 1])

    %tam_jan = 4;

    jj = 1;

    tam_d_sai = (size(a,1)/tam_jan)  * (size(a,2)/tam_jan);
    d_sai = zeros(tam_d_sai, tam_jan*tam_jan);

    for i = 1:tam_jan:size(a,1)
        for j = 1:tam_jan:size(a,1)
            d_sai(jj,:) = reshape(a(i:i+tam_jan-1, j:j+tam_jan-1), 1, tam_jan*tam_jan);
            jj = jj + 1;
        end
    end
    d_sai = double(d_sai);
end