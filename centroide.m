function [x,y] = centroide(Bin)

% INICIALIZACAO DE VARIAVEIS

inc=0;
x=0;
y=0;

% LAÇO PARA VARREDURA:ENCONTRA 
% A COMPONENTE 'x' DO CENTROIDE
        
for i=1:size(Bin,1)
            Val=0;
       
       for j=1:size(Bin,2)
           
           if(Bin(i,j)==1)
              Val=Val+1;
           end
       end
              x=x+i*Val;
              inc=inc+Val;
end
              x=x/inc;
              inc=0;
        
% LAÇO PARA VARREDURA:ENCONTRA 
% A COMPONENTE 'y' DO CENTROIDE

for j=1:size(Bin,2)
            Val=0;
       
       for i=1:size(Bin,1)
            
            if(Bin(i,j)==1)
               Val=Val+1;
            end
       end
               y=y+j*Val;
               inc=inc+Val;

end
               y=y/inc;
               Final=Bin; 

% COMPONENTE (x,y) ARREDONDADA 
% CORRESPONDENTE AO CENTROIDE DA MATRIZ           

	    x=fix(x);
        y=fix(y);
            
% VIZINHANÇA DE 8: DENTRO DA MATRIZ QUE
% CONTEM O CENTROIDE (Final) P/ MELHOR 
% VISUALIZACAO DO CENTROIDE = 255;
              
            Final(x-1:x+1,y-1:y+1)=255;
            

    %figure(1),imshow(Final); 
    


end