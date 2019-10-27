function Cov = MyCov(X)
%MyCov calculates Covariance of a matrix
    [nRow, ~] = size(X);
    x_mean = MyMean(X); %  column mean
    A = bsxfun(@minus,X,x_mean); % Mean shift the original matrix
    Cov = 1/nRow * (A' *  A); % calculate covariance

end

