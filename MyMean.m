function Mean = MyMean(X)
% calculates Average or mean value.
    [nRow, ~] = size(X);
    Mean = sum(X)/nRow;
end

