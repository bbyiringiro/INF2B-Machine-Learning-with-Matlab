function [Ypreds, Ms, Covs] = run_gaussian_classifiers(Xtrain, Ytrain, Xtest, epsilon)
% Input:
%   Xtrain : M-by-D training data matrix (double)
%   Ytrain : M-by-1 label vector for Xtrain (uint8)
%   Xtest  : N-by-D test data matrix (double)
%   epsilon : A scalar variable (double) for covariance regularisation
% Output:
%  Ypreds : N-by-1 matrix (uint8) of predicted labels for Xtest
%  Ms     : K-by-D matrix (double) of mean vectors
%  Covs   : K-by-D-by-D 3D array (double) of covariance matrices

%YourCode - Bayes classification with multivariate Gaussian distributions.




    % Get dimensions
    [~, ~] = size(Xtrain);
    [N, D] = size(Xtest);
    
    % Number of classes
    
    K = 10;
    
    % Prelocate matrices to save time
    Ms = zeros(D, K);
    Covs = zeros(D, D, K);
    invCovs = zeros(D, D, K);
    logdetCovs = zeros(1, K);
    Ypreds = zeros(N, 1);
    
    % Init likelihoods
    likes = zeros(K, N);
    
    % Iterate for each class
    for k = 1:K
        % Get training samples from current class
        cls = Xtrain(Ytrain==k-1, :);
        sz = size(cls, 1);
        mult = ones(1, sz);
        
        % Calculate the mean matrix
        Ms(:, k) = (mult * cls) ./ sz;
        
        % Difference between each sample and the mean
        diff = cls' - repmat(Ms(:, k), 1, sz);
        
        % Calculate the covarience matrix, the inverse and 
        % the logarithm of the determinant
        Covs(:, :, k) = diff * diff' ./ sz;
        Covs(:, :, k) = Covs(:, :, k) + (epsilon .* eye(D));
        invCovs(:, :, k) = inv(Covs(:, :, k));
        logdetCovs(:, k) = - 0.5 .* logdet(Covs(:, :, k));
   
        %Get the mean, cov, inverse matrix and log det for each class
        mu = Ms(:, k);
        inv_cov = invCovs(:, :, k);
        logdet_cov = logdetCovs(:, k);
        
        % Loop through each test sample
        for i = 1:N
            % Get its difference with the mean vector
            x = Xtest(i, :);
            diff = x' - mu;
            % Calculate the likelihood using Naive bayes with gaussian dist
            likes(k, i) = logdet_cov - 0.5 .* diff' * inv_cov * diff;
        end
        
    end    
    

    [~ , Ypreds]  = max(likes, [], 1);
    Ypreds =Ypreds'-1;
    
    

end



% function [Ypreds, Ms, Covs] = run_gaussian_classifiers(Xtrain, Ytrain, Xtest, epsilon)
% 
%     classes =10 
%     features = size(Xtrain,2)
%     testLen = len(Xtest)
% 
%     Ms = zeros(features, classes)
%     Covs = zeros(features, features, classes)
%     Cprobs = zeros(testLen, classes)
%     expectedPreds = (testLen, 1)
%     Ms_inverse = Ms'
%     for k=1:classes
%         
%         
%         row_indices, _ = np.where(Ytrain == k)
% 
%         Ms[:,k] = Xtrain[row_indices].sum(axis=0) / len(row_indices)
% 
%         Mn = np.tile(Ms[:, k][np.newaxis,:], (len(Xtrain[row_indices]), 1))
% 
%         minused = Xtrain[row_indices]-Mn
%         cov = minused.T.dot(minused) / len(row_indices)
% 
%         np.fill_diagonal(cov, np.diagonal(cov) + epsilon)
% 
%         Covs[:,:,k] = cov
% 
%         Covs_inv = np.linalg.inv(cov)
%         Covs_logdet = np.linalg.slogdet(cov)[1]/2
% 
%         mean = Xtest - Ms_inverse[k,:]
%         for i in range(testLen):
%             Cprobs[i,k] = -.5*mean[i].dot(Covs_inv).dot(mean[i].T)-Covs_logdet
%     
%     Ypreds = np.argmax(Cprobs, axis=1).reshape(expectedPreds)
% 
%     return (Ypreds, Ms, Covs)



