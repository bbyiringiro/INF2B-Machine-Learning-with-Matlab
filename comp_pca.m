function [EVecs, EVals] = comp_pca(X)
% Input: 
%   X:  N x D matrix (double)
% Output: 
%   EVecs: D-by-D matrix (double) contains all eigenvectors as columns
%       NB: follow the Task 1.3 specifications on eigenvectors.
%   EVals:
%       Eigenvalues in descending order, D x 1 vector (double)
%   (Note that the i-th columns of Evecs should corresponds to the i-th element in EVals)
      
%     Calculate covariance matrix
    covar_x = MyCov(X);
%   finding the eigenvectors and eigenvalues
    [EVecs, EValsM] = eig(covar_x);
    EVals_ = diag(EValsM);

%     Sorting in eigenvalue and vectors in descending order
    [EVals, ridx] = sort(EVals_, 1, 'descend');
    EVecs = EVecs(:,ridx);
% making sure that the frst element of each eigenvector is non-negative.
    for i = 1 : length(EVecs)
        if EVecs(1,i) < 0
            EVecs(:,i) = (-1)*EVecs(:,i);
        end
    end
end


