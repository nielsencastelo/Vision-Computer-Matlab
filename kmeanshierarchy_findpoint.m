%
% nn = kmeanshierarchy_findpoint(point, hierarchy, startcol, endcol, K)
%
% input:
%   point = 1xD vector (the D-dimensional point query). You wish to find
%   the nearest neighbour of 'point'
%   hierarchy = [created using function 'kmeanshierarchy']
%   startcol, endcol = start and end columns [same values given to 'kmeanshierarchy']
%       should have (endcol-startcol+1) == D
%   K = branching factor [same value given to 'kmeanshierarchy']
%
% 
% output:
%   nn = leaf node of hierarchy that is matched to point
%     nn(startcol:endcol) = approximate nearest neighbour of 'point'
%
function nn = kmeanshierarchy_findpoint(point, hierarchy, startcol, endcol, K)

if (nargin <= 4)
    K=2;
end

if (length(point) ~= (endcol-startcol+1))
    error(sprintf('Point has %d features, but only selected %d columns', length(point), (endcol-startcol+1)));
end

W = size(hierarchy,2);
index = 1;
link=0;
while (link >= 0)
    index=index+link;
    
    % compare point to K centres - pick closest
    best = -1;
    bestdist = 10^100;
    for i = 1:K
        if ((index+i-1) > size(hierarchy,1))
            warning('out of bounds: error in hierarchy, or incorrect branching factor (K) used');
            break;
        end
        dist = sum((hierarchy(index+i-1,startcol:endcol) - point).^2);
        if (dist < bestdist)
            bestdist = dist;
            best = i;
        end
    end
    
    link = hierarchy(index+best-1,W);
    if (link > 0)
        index = index+best-1;
    elseif (link==0)
        warning('loopback found: error in hierarchy, or incorrect branching factor (K) used');
        break;
    end
end

nn = hierarchy(index+best-1,:);




