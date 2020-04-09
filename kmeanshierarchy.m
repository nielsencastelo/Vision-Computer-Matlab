%
% [hierarchy] = kmeanshierarchy(data, startcol, endcol, iters, K)
%
% Input:
%   data = set of data [NxF]  N=num_points F=features
%   startcol, endcol = start and end column of data points
%     therefore, clustering will be done in (endcol-startcol+1) Dimensional space
%   iters = number of iterations of K-means to use for each clustering
%   K = branching factor
%
% Suggested (default) values (iters=3, K=2)
%
%
% Output:
%   hierarchy = hierarchy [Nx(F+1)]
%   [last columns = (relative index to sub trees)]
%
function [hierarchy] = kmeanshierarchy(data, startcol, endcol, iters, K)

if (nargin < 4)
    iters = 3;
end
if (nargin < 5)
    K = 2;
end

L = size(data,1);
W = size(data,2);

if (L <= K)
    hierarchy = [data -ones(L,1); Inf*ones(K-L,W) -ones(K-L,1)];
    return
end

% Select the best K-clustering
besterr = -1;
for iter = 1:iters
    [kcentre2,owner2,sqrerr] = kmeans(data(:,startcol:endcol), K);
    if ((iter==1) | (sqrerr<besterr))
        besterr = sqrerr;
        kcentre = kcentre2;
        owner = owner2;
    end
end



hierarchy = zeros(L+K,W+1);
% add top nodes
hierarchy(1:K,1:W) = [zeros(K,startcol-1) kcentre zeros(K,W-endcol)];

% add links (relative indices)
hierarchy(:,W+1) = -1;

% recurse!
nhierarchy = hierarchy(1:K,:);
for i = 1:K
    % do cluster 'i'
    f = find(owner==i);
    [hbit] = kmeanshierarchy(data(f,1:W), startcol, endcol, iters, K);
    nhierarchy(i,W+1) = size(nhierarchy,1)+1 - i; % relative link
    nhierarchy = [nhierarchy; hbit];
end

hierarchy = nhierarchy;

