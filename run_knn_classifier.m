function [Ypreds] = run_knn_classifier(Xtrain, Ytrain, Xtest, Ks)
% Input:
%   Xtrain : M-by-D training data matrix (double)
%   Ytrain : M-by-1 label vector (uint8) for Xtrain
%   Xtest  : N-by-D test data matrix (double)
%   Ks     : 1-by-L vector (integer) of the numbers of nearest neighbours in Xtrain
% Output:
%   Ypreds : N-by-L matrix (uint8) of predicted labels for Xtest



    % Eucledean Distance between train and test 
    dist_train_test = MySqDist(Xtrain, Xtest);
    % Sort the distances in ascending order
    [dist_train_test,idx] = sort(dist_train_test, 1, 'ascend');
    idx=idx';

    
    Ypreds= zeros(size(Xtest,1), size(Ks,2));
    for i=1: size(Ks,2)
        k=Ks(i);
%          k_neighbours = dist_train_test(:,1:k); % first 'k' distances(not
%          necessary)
         k_idx= idx(:,1:k); % keep the first k indexes

         Ypreds(:,i) = mode(Ytrain(k_idx),1); % majority vote

         
    end



end


% 
% function [predicted_labels,nn_index,accuracy] = KNN_(k,data,labels,t_data,t_labels)
% %KNN_: classifying using k-nearest neighbors algorithm. The nearest neighbors
% %search method is euclidean distance
% %Usage:
% %       [predicted_labels,nn_index,accuracy] = KNN_(3,training,training_labels,testing,testing_labels)
% %       predicted_labels = KNN_(3,training,training_labels,testing)
% %Input:
% %       - k: number of nearest neighbors
% %       - data: (NxD) training data; N is the number of samples and D is the
% %       dimensionality of each data point
% %       - labels: training labels 
% %       - t_data: (MxD) testing data; M is the number of data points and D
% %       is the dimensionality of each data point
% %       - t_labels: testing labels (default = [])
% %Output:
% %       - predicted_labels: the predicted labels based on the k-NN
% %       algorithm
% %       - nn_index: the index of the nearest training data point for each training sample (Mx1).
% %       - accuracy: if the testing labels are supported, the accuracy of
% %       the classification is returned, otherwise it will be zero.
% %Author: Mahmoud Afifi - York University 
% %checks
% if nargin < 4
%     error('Too few input arguments.')
% elseif nargin < 5
%     t_labels=[];
%     accuracy=0;
% end
% if size(data,2)~=size(t_data,2)
%     error('data should have the same dimensionality');
% end
% if mod(k,2)==0
%     error('to reduce the chance of ties, please choose odd k');
% end
% %initialization
% predicted_labels=zeros(size(t_data,1),1);
% ed=zeros(size(t_data,1),size(data,1)); %ed: (MxN) euclidean distances 
% ind=zeros(size(t_data,1),size(data,1)); %corresponding indices (MxN)
% k_nn=zeros(size(t_data,1),k); %k-nearest neighbors for testing sample (Mxk)
% %calc euclidean distances between each testing data point and the training
% %data samples
% for test_point=1:size(t_data,1)
%     for train_point=1:size(data,1)
%         %calc and store sorted euclidean distances with corresponding indices
%         ed(test_point,train_point)=sqrt(...
%             sum((t_data(test_point,:)-data(train_point,:)).^2));
%     end
%     [ed(test_point,:),ind(test_point,:)]=sort(ed(test_point,:));
% end
% %find the nearest k for each data point of the testing data
% k_nn=ind(:,1:k);
% nn_index=k_nn(:,1);
% %get the majority vote 
% for i=1:size(k_nn,1)
%     options=unique(labels(k_nn(i,:)'));
%     max_count=0;
%     max_label=0;
%     for j=1:length(options)
%         L=length(find(labels(k_nn(i,:)')==options(j)));
%         if L>max_count
%             max_label=options(j);
%             max_count=L;
%         end
%     end
%     predicted_labels(i)=max_label;
% end
% %calculate the classification accuracy
% if isempty(t_labels)==0
%     accuracy=length(find(predicted_labels==t_labels))/size(t_data,1);
% end


% function [Ypreds] = run_knn_classifier(Xtrain, Ytrain, Xtest, Knn)
% 
%     % Note - you need to cluster the data prior to classifying as kmeans function
%     % starts with random partition and hence the cluster centres can vary
%     % each time.
% 
%     % Determines number of samples in test data
%     points = size(Xtest, 1);
%     
%     % Initialises prediction matrix
%     YtraYpredsin = zeros(points,1);
%     
%    
% %    for j=1: size(Ks,2)
% %    k=Ks(j)
%     for i=1:points
%         r_zx = square_dist(Xtrain, Xtest(i,:));
%         [r_zx, idx] = sort(r_zx, 2, 'descend');
%         idx_v = idx(1:Knn);
%         
%         Ypreds(i,1) = mode(Ytrain(idx_v));
%     end
% end