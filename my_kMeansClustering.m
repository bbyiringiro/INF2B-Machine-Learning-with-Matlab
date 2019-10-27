%
function [C, idx, SSE] = my_kMeansClustering(X, k, initialCentres, maxIter)
% Input
%   X : N-by-D matrix (double) of input sample data
%   k : scalar (integer) - the number of clusters
%   initialCentres : k-by-D matrix (double) of initial cluster centres
%   maxIter  : scalar (integer) - the maximum number of iterations
% Output
%   C   : k-by-D matrix (double) of cluster centres
%   idx : N-by-1 vector (integer) of cluster index table
%   SSE : (L+1)-by-1 vector (double) of sum-squared-errors

  
% If 'maxIter' argument is not given, we set by default to 500
    if nargin < 4
        maxIter = 500;
    end


    [N ~] = size(X); 
    % KxN matrix for storing distances between cluster centres and observations
    D = zeros(k, N); 
    SSE =[];
    idx_prev = zeros(1, N);
    C = initialCentres;

    for i = 1:maxIter
    %     Compute Squared Euclidean distance (i.e. the squared distance)
    %     between each cluster centre and each observation
        for c = 1:k
            D(c, :) = MySqDist(X, C(c, :));
        end

    %     Assign data to clusters
    %     Ds are the actual distances and idx are the cluster assignments
        [Ds, idx] = min(D); % find min distance for each observation

        SSE(i) = sum(Ds); % computing the sum squared error


    %     Update cluster centres
        for c = 1:k
    %         check the number of samples assigned to this cluster
            if( sum(idx==c)==0 )
                warning('k-means: cluster %d is empty', c);
            else
                C(c, :) = MyMean(X(idx==c, :));
            end
        end

    %     break if they converge
        if(sum(abs(idx-idx_prev))==0)
            break;
        end

        idx_prev = idx;
    end

    idx=idx';

end
