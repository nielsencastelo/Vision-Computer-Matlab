load gist.mat;


%% Create a visual vocabulary with 20 words 
nWords = 30;
%use kmeans for constructing the vocabulary. 
[idx,centers] = kmeans([features{:}]',nWords);

%% BoF Feature Representation 
histFtrs = cell(5,1); 
for i = 1 : 5 
    start = 1; 
    histFtrs{i} = hist(idx(start:start+size(features{i},2)),nWords)';

 %normalize 
 histFtrs{i} = histFtrs{i}./sum(hisFtrs{i}); 
end

%display histograms 
figure; 
for i = 1 : 5 
    subplot(2,3,i); 
    bar(histFtrs{i}); 
end