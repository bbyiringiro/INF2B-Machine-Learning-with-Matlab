%
%
function M = task1_2(X, Y)
% Input:
%  X : M-by-D data matrix (double)
%  Y : M-by-1 label vector (unit8)
% Output:
%  M : (K+1)-by-D mean vector matrix (double)
%      Note that M(K+1,:) is the mean vector of X.

    % K the number of classes or samples
    K=length(unique(Y)); % this more dynamic but for this case it's 10
    [~, nCol] = size(X);
    %initialize means to zeros for each class, k+1 for the whole dataset
    M=zeros(K+1, nCol);
    % initialize the 4D array that will hold reshaped images in class j
    images=zeros(28, 28, 1, K);
    for j=1:10 
        % filter to get only vectors for images of class j
        class_k_imgs = X(Y==j-1,:);
        M(j,:) = MyMean(class_k_imgs);
        images(:,:,1, j)= reshape(M(j,:), 28, 28)';
            
    end
    %calculate mean for the whole dataset 
    M(j+1,:) = MyMean(X);
    images(:,:,1, j+1)= reshape(M(j+1,:), 28, 28)';
    if ~ isempty(images)
            figure
            montage(images, 'size',[3 NaN]);
    end
    

end
