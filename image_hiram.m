%% Read images
im{1} = rgb2gray(imread('http://i.imgur.com/TMyflBl.png'));
im{2} = rgb2gray(imread('http://i.imgur.com/ozygW2g.png'));
im{3} = rgb2gray(imread('http://i.imgur.com/dGj8FNE.png'));
im{4} = rgb2gray(imread('http://i.imgur.com/VbTLPjG.png'));
im{5} = rgb2gray(imread('http://i.imgur.com/huj2El9.png'));
%% Detect and extract MSER features
detectFeatures = @(in) {detectSURFFeatures(in)}; 
regions = cellfun(detectFeatures,im);

extractAndTransposeFeatures = @(in,pts) extractFeatures(in,pts)';
features = cellfun(extractAndTransposeFeatures,im,regions,'UniformOutput',false);

figure;
for i = 1 : 5
    subplot(2,3,i);
    imshow(im{i});
    hold on;
    plot(regions{i});
end

%% Create a visual vocabulary with 20 words
nWords = 20;

%use kmeans for constructing the vocabulary.
[idx,centers] = kmeans([features{:}]',nWords);

%% BoF Feature Representation
histFtrs = cell(5,1);
for i = 1 : 5
    start = 1;
    histFtrs{i} = hist(idx(start:start+size(features{i},2)),nWords)';

      %normalize
      histFtrs{i} = histFtrs{i}./sum(histFtrs{i});
end

%display histograms
figure;
for i = 1 : 5;
    subplot(2,3,i);
    bar(histFtrs{i});
end

%% Partition images into 2 sets using kmeans
idx = kmeans([histFtrs{:}]',2)

% idx =
% 
%      2
%      2
%      2
%      2
%      1
%save idx.mat idx;
%save centers.mat centers;