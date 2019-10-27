function task2_8(Xtrain, Ytrain, Xtest, Ytest, epsilon, L)
% Input:
%   Xtrain : M-by-D training data matrix (double)
%   Xtrain : M-by-1 label vector (uint8) for Xtrain
%   Xtest  : N-by-D test data matrix (double)
%   Ytest  : N-by-1 label vector (uint8) for Xtest
%   epsilon : A scalar parameter for regularisation
%   L      : scalar (integer) of the number of Gaussian distributions per class


    n_classes=10;
    tic
    [Ypreds, MMs, MCovs] = run_mgcs(Xtrain, Ytrain, Xtest, epsilon, L);
    toc
    [cm, acc] = comp_confmat(Ytest, Ypreds,n_classes);

    save(sprintf('task2_8_cm%d.mat',L),'cm');

    Ms1 = MMs(1:L,:) 
    Covs1 = MCovs(1:L,:,:);

    save(sprintf('task2_8_g%d_m1.mat',L),'Ms1');
    save(sprintf('task2_8_g%_cov1.mat',L),'Covs1');


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
