function [DI] = MySqDist(X, Y)

    % distance calculation vectoriazed btween X and Y
    % using the fact that d_{ij} = (X_i - Y_j) * (X_i - Y_j)^ 
    %= X_i * X_i^T - 2 X_i * Y_j^T + Y_j * Y_j^T
    N = size(X, 1);
    M = size(Y, 1);

    XX = dot(X, X, 2);
    YY = dot(Y, Y, 2);
    DI = repmat(XX,1,M)- (2*X*Y.') + (repmat(YY,1,N)).';

end