%
%
function task1_1(X, Y)
% Input:
%  X : M-by-D data matrix (double)
%  Y : M-by-1 label vector (unit8)

    % K the number of classes or samples
    K=length(unique(Y)); % this more dynamic but for this case it's 10
    for j = 1:K
        % filter only images in of class j
        class_k_imgs = X(Y==j-1,:);
        % select the first 10
        first_ten_sample = class_k_imgs(1:K, :);
        
        % initialize the 4D array that will hold reshaped images in class j
        images=zeros(28, 28, 1, K);
        for i=1:K
            images(:,:,1,i)= reshape(first_ten_sample(i,:), 28, 28)';
        end
        if ~ isempty(images)
            figure
            montage(images, 'size',[3 NaN]);
        end
    end
end