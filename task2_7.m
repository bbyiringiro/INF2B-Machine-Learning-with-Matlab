%
%
function [CM, acc] = task2_7(Xtrain, Ytrain, Xtest, Ytest, epsilon, ratio)
% Input:
%  Xtrain : M-by-D training data matrix (double)
%  Ytrain : M-by-1 label vector (unit8) for Xtrain
%  Xtest  : N-by-D test data matrix (double)
%  Ytest  : N-by-1 label vector (unit8) for Xtest
%  ratio  : scalar (double) - ratio of training data to use.
% Output:
%  CM     : K-by-K matrix (integer) of confusion matrix
%  acc    : scalar (double) of correct classification rate


n_classes=10;
n_train = floor(size(Xtrain,1)*ratio);
n_test = floor(size(Xtest,1)*ratio);
R = ratio * 100;
 


[Ypreds, ~, ~] = run_gaussian_classifiers(Xtrain(1:n_train,:), Ytrain(1:n_train,:), Xtest(1:n_test,:), epsilon);
[CM, acc] = comp_confmat(Ytest(n_test), Ypreds(n_test),n_classes);


save(sprintf('task2_7_cm_%d.mat', R), 'CM');


end
