%
%
function [EVecs, EVals, CumVar, MinDims] = task1_3(X)
% Input:
%  X : M-by-D data matrix (double)
% Output:
%  EVecs, Evals: same as in comp_pca.m
%  CumVar  : D-by-1 vector (double) of cumulative variance
%  MinDims : 4-by-1 vector (integer) of the minimum number of PCA dimensions
%            to cover 70%, 80%, 90%, and 95% of the total variance.

    [EVecs, EVals] = comp_pca(X);
    PC_X = X * EVecs;
    CumVar = cumsum(MyVar(PC_X)); % computing cumulative variance.
    
    D = length(EVals);
    
    plot(1:D,CumVar);
    title('Cumulative Variance');
    ylabel('Cumulative Variance');
    xlabel('# of principal components');
    
    
    
    
    %initalizing MinDims to -1 meaning no minimum to over any range
    MinDims =repmat(-1,4,1); 
    % getting sum of all eighen values and finding the minimum value of l
    % eigein values to cover a certain percentage using the ratio of l
    % eigein to the total value of all of them
    eigen_sum=sum(EVals);
    for i=1:D
        if (sum(EVals(1:i))/eigen_sum >= 0.7)
            if MinDims(1,:) < 0
                MinDims(1,:)=i;
            end
         end
        if (sum(EVals(1:i))/eigen_sum >= 0.8)
            if MinDims(2,:) < 0
                MinDims(2,:)=i;
            end
        end
        
        if (sum(EVals(1:i))/eigen_sum >= 0.9)
            if MinDims(3,:) < 0
                MinDims(3,:)=i;
            end
        end
        
        if (sum(EVals(1:i))/eigen_sum >= 0.95)
            if MinDims(4,:) < 0
                MinDims(4,:)=i;
            end
        end
    end  

end
