%
%
function task1_6(MAT_ClusterCentres)
% Input:
%  MAT_ClusterCentres : file name of the MAT file that contains cluster centres C.
%       
% 

    % assuming all file that will be passed centeres will be saved in C var
    load (MAT_ClusterCentres, 'C');

    [N, ~] = size(C);
    % initialize the 4D array that will hold reshaped images in class j
    images=zeros(28, 28, 1, N);
    for i=1:N
        images(:,:,1,i)= reshape(C(i,:), 28, 28)';
    end
    if ~ isempty(images)
        figure
        montage(images, 'size',[2 NaN]);
    end
  
end
