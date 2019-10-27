%
%
function task2_3(X, Y)
% Input:
%  X : M-by-D data matrix (double)
%  Y : M-by-1 label vector for X (unit8)


% Reduce the dimentionality;

[Evecs , Evals] = comp_pca(X);
PC_X = X*Evecs;
X=PC_X(:,1:2);


[N , D] = size(X);


class = 10;
means = zeros(class,D);
covariance = zeros(D,D,class);

% loop for each class

for i = 1 : class
    data = X(Y == i-1,:);
    means(i,:) = MyMean(data);
    covariance(:,:,i) = MyCov(data);
    var = diag(covariance(:,:,i));
    maxsd = max(var);
    
    % plot between +-2SDs along each dimension
    % location of points at which x is calculated
    x = means(i,1)-2*maxsd:0.1:means(i,1)+2*maxsd;
    % location of points at which y is calculated
    y = means(i,2)-2*maxsd:0.1:means(i,2)+2*maxsd;
    % Get the number of data
    N = length(x);
    
    % (Inefficient) Compute the Gaussian pdf for each (x,y) pair
    z = zeros(N, N);
    for l = 1:N
        for j = 1:N
            xx = [x(l) y(j)];
            % Evaluate MV Gaussian pdf for the (x,y) pair
            z(l,j) = gaussianMV(means(i,:), covariance(:,:,i), xx);
        end
    end
    % Make contour plot of 2D Gaussian
    figure(1);
    colormap(1,'jet');
    xlabel('1st principal component'); ylabel('2nd principal component');
    contour(x,y,z, 1);
    axis equal;
    
    hold on
end
