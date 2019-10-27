%
%
function Dmap = task1_7(MAT_ClusterCentres, MAT_M, MAT_evecs, MAT_evals, posVec, nbins)
% Input:
%  MAT_ClusterCentres: MAT filename of cluster centre matrix
%  MAT_M     : MAT filename of mean vectors of (K+1)-by-D, where K is
%              the number of classes (which is 10 for the MNIST data)
%  MAT_evecs : MAT filename of eigenvector matrix of D-by-D
%  MAT_evals : MAT filename of eigenvalue vector of D-by-1
%  posVec    : 1-by-D vector (double) to specify the position of the plane
%  nbins     : scalar (integer) to specify the number of bins for each PCA axis
% Output
%  Dmap  : nbins-by-nbins matrix (uint8) - each element represents
%	   the cluster number that the point belongs to.


    % loading data from the files
    load (MAT_ClusterCentres, 'C');
    load (MAT_M, 'M');
    load (MAT_evecs, 'EVecs');
    load (MAT_evals, 'EVals');



    % Colormap we will use to colour each classes.
    cmap = [0.80369089, 0.61814689, 0.46674357;
    0.81411766, 0.58274512, 0.54901962;
    0.58339103, 0.62000771, 0.79337179;
    0.83529413, 0.5584314 , 0.77098041;
    0.77493273, 0.69831605, 0.54108421;
    0.72078433, 0.84784315, 0.30039217;
    0.96988851, 0.85064207, 0.19683199;
    0.93882353, 0.80156864, 0.4219608 ;
    0.83652442, 0.74771243, 0.61853136;
    0.7019608 , 0.7019608 , 0.7019608];
    
    % finding mean of principal components by projecting orginatal mean to
    % 2d pca
    mu = EVecs(:,1:2)' * (M(11,:) - posVec)';
    
    % getting grid axis from standard deviationa and mean and taking care
    % when eighen value is negative
    Xplot = linspace(mu(1)-5*sqrt(abs(EVals(1))), mu(1)+5*sqrt(abs(EVals(1))), nbins)';
    Yplot = linspace(mu(2)-5*sqrt(abs(EVals(2))), mu(2)+5*sqrt(abs(EVals(2))), nbins)';
    % Obtain the grid vectors for the two dimensions
    [Xv Yv] = meshgrid(Xplot, Yplot);
    gridX = [Xv(:), Yv(:)]; % Concatenate to get a 2-D point.

    invV = inv(EVecs);
    gridX(:,3:size(EVecs,2)) = 0; %  extending it to match orginal coordinate system
    %transformation to original  the data to orginal cordiante system
    X = (invV' * gridX')' + posVec;
    
    
% this works however I used my implementation of knn function since it is
% vectorized
%     classes = [];
%     for i = 1:size(X,1)
%         dists = MySqDist(C, X(i,:))'; % Compute distances
%         [d I] = sort(dists, 'ascend');
%         classes(i) = I(1);
%     end
    classes= run_knn_classifier(C, [1:size(C,1)], X, 1)'; 
    

    figure;
    % This function will draw the decision boundaries
    [~,h] = contourf(Xplot(:), Yplot(:), reshape(classes, length(Xplot), length(Yplot)));
    set(h,'LineColor','none');
    colormap(cmap);
    
    
    Dmap = reshape(classes, nbins,nbins);
    

			  
end
