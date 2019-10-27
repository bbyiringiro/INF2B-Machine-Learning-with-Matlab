%
%
function task2_1(Xtrain, Ytrain, Xtest, Ytest, Ks)
% Input:
%  Xtrain : M-by-D training data matrix (double)
%  Ytrain : M-by-1 label vector (unit8) for Xtrain
%  Xtest  : N-by-D test data matrix (double)
%  Ytest  : N-by-1 label vector (unit8) for Xtest
%  Ks     : 1-by-L vector (integer) of the numbers of nearest neighbours in Xtrain


    
    Ypred = run_knn_classifier(Xtrain, Ytrain, Xtest, Ks);
    
    
    for i=1:size(Ks,2)
        k = Ks(i);
        [CM, acc] = comp_confmat(Ytest, Ypred(:,i), 10);
%         save(sprintf('cm%d',idx), 'cm');

        %Sum of wrongly classified samples
        miss = 0;

        % missclassified
        for j=1:10
            for l=1:10
                if j~=l 
                    miss = miss + CM(j,l);
                end
            end
        end

       
        outpout = sprintf('K: %d \nN : %d \nNerrs: %d \nacc: %d ',k,size(Xtest,1),miss,acc);
        disp(outpout);
    end


end





