%
%
function [Corrs] = task2_4(Xtrain, Ytrain)
% Input:
%  Xtrain : M-by-D data matrix (double)
%  Ytrain : M-by-1 label vector (unit8) for X
% Output:
%  Corrs  : (K+1)-by-1 vector (double) of correlation $r_{12}$ 
%           for each class k = 1,...,K, and the last element holds the
%           correlation for the whole data, i.e. Xtrain.

   

  

    class = 10;
    Corrs=zeros(class+1, 1);

    % loop for each class

    for k = 1 : class
        data_k = Xtrain(Ytrain == k-1,:);
        % perfoming pca on each class
        [Evecs , ~] = comp_pca(data_k);
        data_pca_x = data_k* Evecs;
        
        covariance = MyCov(data_pca_x);
        Corrs(k,:)= covariance(1,2)/sqrt(covariance(1,1)*covariance(2,2));
        
    end
    
    [Evecs , ~] = comp_pca(Xtrain);
    data_pca_whole = Xtrain* Evecs;

    covariance = MyCov(data_pca_whole);
    Corrs(k+1,:)= covariance(1,2)/sqrt(covariance(1,1)*covariance(2,2));
        
end


