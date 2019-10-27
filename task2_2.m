%
%
function Dmap = task2_2(Xtrain, Ytrain, k, MAT_evecs, MAT_evals, posVec, nbins)
% Input:
%  X   : M-by-D data matrix (double)
%  k   : scalar (integer) - the number of nearest neighbours
%  MAT_evecs : MAT filename of eigenvector matrix of D-by-D
%  MAT_evals : MAT filename of eigenvalue vector of D-by-1
%  posVec    : 1-by-D vector (double) to specity the position of the plane
%  nbins     : scalar (integer) - the number of bins for each PCA axis
% Output:
%  Dmap  : nbins-by-nbins matrix (uint8) - each element represents
%	   the cluster number that the point belongs to.




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
    rng(2); % Set seed
    
    
    

    

    mu = EVecs(:,1:2)' * (MyMean(Xtrain) - posVec)';
    
    Xplot = linspace(mu(1)-5*sqrt(EVals(1)), mu(1)+5*sqrt(EVals(1)), nbins)';
    Yplot = linspace(mu(2)-5*sqrt(EVals(2)), mu(2)+5*sqrt(EVals(2)), nbins)';

    [Xv Yv] = meshgrid(Xplot, Yplot);
    gridX = [Xv(:), Yv(:)]; % Concatenate to get a 2-D point.

    invV = inv(EVecs);
    gridX(:,3:size(EVecs,2)) = 0;
    X = (invV' * gridX')' + posVec;
    
    

    classes = run_knn_classifier(Xtrain, Ytrain, X, [k]);
%     for i = 1:size(X,1)
%         dists = MySqDist(Xtrain, X(i,:))'; % Compute distances
%         [d I] = sort(dists, 'ascend');
%         classes(i) = mode(Ytrain(I(1:k)));
%     end
    
    
 
    figure;
    % This function will draw the decision boundaries
    [CC,h] = contourf(Xplot(:), Yplot(:), reshape(classes, length(Xplot), length(Yplot)));
    set(h,'LineColor','none');
    colormap(cmap); 
    
    
    Dmap = reshape(classes, nbins,nbins);


end
