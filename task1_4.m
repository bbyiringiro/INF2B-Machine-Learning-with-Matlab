%
%
function task1_4(EVecs)
% Input:
%  Evecs : the same format as in comp_pca.m
%

    n=10; % numbers of principal axes PCA to pick
    first_ten_pca = EVecs(:,1:n)';

    % initialize the 4D array that will hold reshaped images in class j
    images=[];
    for i=1:n
        images(:,:,1,i)= reshape(first_ten_pca(i,:), 28, 28)';
    end
    if ~ isempty(images)
        figure
        montage(images, 'size',[3 NaN], 'DisplayRange',[-0.2, 0.2]);
    end


end
