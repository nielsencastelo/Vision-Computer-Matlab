function G = image_stats(f)  
    G{1} = size(f);  
    G{2} = mean2(f);  
    G{3} = mean(f,2);  
    G{4} = mean(f,1); 
end 