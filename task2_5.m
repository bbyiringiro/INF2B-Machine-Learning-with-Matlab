%
%
function task2_5(Xtrain, Ytrain, Xtest, Ytest, epsilon)
% Input:
%  Xtrain : M-by-D training data matrix (double)
%  Ytrain : M-by-1 label vector (unit8) for Xtrain
%  Xtest  : N-by-D test data matrix (double)
%  Ytest  : N-by-1 label vector (unit8) for Xtest
%  epsilon : a scalar variable (double) for covariance regularisation

n_classes=10;
tic
[Ypreds, Ms, Covs] = run_gaussian_classifiers(Xtrain, Ytrain, Xtest, epsilon);
toc
[cm, acc] = comp_confmat(Ytest, Ypreds,n_classes);

save('task2_5_cm.mat','cm')

M10 = Ms(10,:); 
Cov10 = Covs(10,:,:);

save('task2_5_m10.mat', 'M10')
save('task2_5_cov10.mat','Cov10')


miss=0;
for j=1:10
    for l=1:10
        if j~=l 
            miss = miss + cm(j,l);
        end
    end          
end


outpout = sprintf('N : %d \nNerrs: %d \nacc: %d ',size(Xtest,1), miss, acc);
disp(outpout);


end
