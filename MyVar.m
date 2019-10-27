function X_var = MyVar(X)


    [nRow, nCol] = size(X);
    X_var = zeros(1, nCol);
    x_mean = MyMean(X);
    X_var = sum((X-x_mean).^2)/nRow;
     

end

