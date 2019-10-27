%
%
function task1_5(X, Ks)
% Input:
%  X  : M-by-D data matrix (double)
%  Ks : 1-by-L vector (integer) of the numbers of nearest neighbours


    for k=1:length(Ks)
        % picking the first initial k centers
        centres = X(1:Ks(k),:);
        [C, idx, SSE] = my_kMeansClustering(X, Ks(k), centres);

        save(strcat('task1_5_c_',num2str(Ks(k)),'.mat'),'C');
        save(strcat('task1_5_idx_',num2str(Ks(k)),'.mat'),'idx');
        save(strcat('task1_5_sse_',num2str(Ks(k)),'.mat'),'SSE');

    end 

end
