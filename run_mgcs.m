function [Ypreds, MMs, MCovs] = run_mgcs(Xtrain, Ytrain, Xtest, epsilon, L)
% Input:
%   Xtrain : M-by-D training data matrix (double)
%   Ytrain : M-by-1 label vector for Xtrain (uint8)
%   Xtest  : N-by-D test data matrix (double)
%   epsilon : A scalar parameter for regularisation (double)
%   L      : scalar (integer) of the number of Gaussian distributions per class
% Output:
%  Ypreds : N-by-1 matrix of predicted labels for Xtest (integer)
%  MMs     : (L*K)-by-D matrix of mean vectors (double)
%  MCovs   : (L*K)-by-D-by-D 3D array of covariance matrices (double)

    K=10;

%     initialCentres=Xtrain(1:L,:);
%     
%     [~, idx, ~] = my_kMeansClustering(Xtrain, L, initialCentres)
%     
%     for c=1:L
%         x_c=Xtrain(idx==c);
%         y_c=Xtrain(idx==c);
%         
%     [Ypreds, Ms, Covs] = run_gaussian_classifiers(x_c, y_c, Xtest, epsilon);
    [N, D] = size(Xtrain);
    MCovs=zeros((L*K),D,D);
    MMs=zeros((L*K),D);
    for k = 0:K-1
        x_k = Xtrain(Ytrain==k,:);
        initialCentres=x_k(1:L+1,:);
        [~, idx, ~] = my_kMeansClustering(x_k, L, initialCentres);
        
       
        for l = 1:L
            MCovs(k*L+l, :, :) = MyCov(x_k) + (epsilon .* eye(D));
            MMs(k*L+l, :)= MyMean(x_k);
        end
    end
    
    
   like_k = zeros(L*K,size(Xtest,1));
    
   for i=1:L*K
        mu = MMs(i,:)';
        cov_i=  reshape(MCovs(i, :, :), [784,784]);
        logdet_cov = - 0.5 .* logdet(cov_i);
        
        
        for j = 1:size(Xtest,1)
            % Get its difference with the mean vector
            x = Xtest(j, :);
%             x_k = Xtrain(Ytrain==store_n(j,1));
%             size(mu)
%             size(x')
            diff = x' - mu;
            
            % Calculate the likelihood using Naive bayes with gaussian dist
            like_k(i, j) = logdet_cov - 0.5 .* diff' * cov_i * diff;
        end
   end
   
   [~ , Ypreds]  = max(like_k, [], 1);
   Ypreds =floor((Ypreds'-1)/L)

end
