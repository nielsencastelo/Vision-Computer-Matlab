% Identifica objetos redondos
clear;clc;close all;
RGB = imread('pillsetc.png');
imshow(RGB);

% Converter a imagem para preto e branco, a fim de preparar-se para 
% fronteira rastreamento usando bwboundaries.
I = rgb2gray(RGB);
threshold = graythresh(I);
bw = im2bw(I,threshold);
imshow(bw)

% Usando funções morfologia, remove os pixels que não pertencem aos 
% objetos de interesse
% remover todos os objetos que contenham menos de 30 pixels
bw = bwareaopen(bw,30);

% preencher uma lacuna na tampa da caneta
se = strel('disk',2);
bw = imclose(bw,se);

% preencher todos os furos, de modo que regionprops pode ser usado para estimar
% a área delimitada por cada uma das fronteiras
bw = imfill(bw,'holes');
imshow(bw)

[B,L] = bwboundaries(bw,'noholes');

% Display the label matrix and draw each boundary
imshow(label2rgb(L, @jet, [.5 .5 .5]))
hold on
for k = 1:length(B)
  boundary = B{k};
  plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end

metric = 4*pi*area/perimeter.^2;

stats = regionprops(L,'Area','Centroid');

threshold = 0.94;

% loop over the boundaries
for k = 1:length(B)

  % obtain (X,Y) boundary coordinates corresponding to label 'k'
  boundary = B{k};

  % compute a simple estimate of the object's perimeter
  delta_sq = diff(boundary).^2;
  perimeter = sum(sqrt(sum(delta_sq,2)));

  % obtain the area calculation corresponding to label 'k'
  area = stats(k).Area;

  % compute the roundness metric
  metric = 4*pi*area/perimeter^2;

  % display the results
  metric_string = sprintf('%2.2f',metric);

  % mark objects above the threshold with a black circle
  if metric > threshold
    centroid = stats(k).Centroid;
    plot(centroid(1),centroid(2),'ko');
  end

  text(boundary(1,2)-35,boundary(1,1)+13,metric_string,'Color','y',...
       'FontSize',14,'FontWeight','bold');

end

title(['Metrics closer to 1 indicate that ',...
       'the object is approximately round']);