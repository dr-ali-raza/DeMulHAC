%% Make folder
fpath = 'D:\OneDrive - Higher Education Commission\extracted data\Data\Mode';
folder = 'Networks_Activity';
 if ~exist(fullfile(fpath,folder),'dir')
    mkdir(fullfile(fpath,folder))
 end
 %% Initialize Variables
p1 = 0;
p2 = 0;
k1 = 0;
k2 = 0;
HL_arr = [];
n = [100 90 80 70 60 50 40 30 20 10];
array1_mse = [];
array2_mse = [];
%% Import Data
I = input(:,:);
input_mat = I.';

%Data for Activity
O1 = target(:,3:8);
output_mat1 = O1.';

%% Networks
    for j = 1:10
        
        % Converging Networks array
        HL_arr = [HL_arr j];
        HL_arr(j) = n(j);
        NumHiddenLayers = HL_arr;
        
        %Network1 for Activity Recognition
        
        net1 = patternnet(NumHiddenLayers,'trainscg');
        net1.trainParam.epochs = 10000;    %epochs for which network trains
        net1.trainParam.goal = 1e-20;   %error at which network stops training
        net1.trainParam.lr = 0.0001;    %learning rate
        net1.trainParam.max_fail = 6000; 
        net1.trainParam.min_grad = 1e-20;
        net1.PerformFcn = 'mse';
        net1.divideFcn = 'dividerand';
        net1.divideParam.trainRatio = 0.7;
        net1.divideParam.valRatio = 0.10;
        net1.divideParam.testRatio = 0.20;
        [trainInd,valInd,testInd] = dividerand(input_mat,0.7,0.10,0.20); % training:70%, validation:10%, testing:20%
        [trainInd_O1,valInd_O1,testInd_O1] = dividerand(output_mat1,0.7,0.10,0.20);
        net1.plotFcns = {'plotperform','plotconfusion','plotregression','plottrainstate'};
        [net1,tr(1),error1] = train(net1,input_mat,output_mat1);    % train the network
        out_train1 = net1(input_mat(:,tr(1).trainInd));             %outputs of training data
        out_val1 = net1(input_mat(:,tr(1).valInd));                 %outputs of validation data
        out_test1 = net1(input_mat(:,tr(1).testInd));               %simulate 20% test data
        
        % Make Subfolder
        Z = fullfile(fpath,folder,sprintf('network%d',j));
        if ~exist(Z,'dir')
            mkdir(Z)
        end
        
        %Save figures in Subfolders
        nntraintool('plot', 'plotperform')
        Perform = gcf;
        saveas(Perform, fullfile(Z,sprintf('FIG%d_performance.jpeg',j)))
        nntraintool('plot', 'plottrainstate')
        TrainState = gcf;
        saveas(TrainState, fullfile(Z,sprintf('FIG%d_trainstate.jpeg',j)))
        nntraintool('plot', 'plotconfusion')
        Confusion = gcf;
        saveas(Confusion, fullfile(Z,sprintf('FIG%d_confusion.jpeg',j)))
        nntraintool('plot', 'plotregression')
        Regression = gcf;
        saveas(Regression, fullfile(Z,sprintf('FIG%d_regression.jpeg',j)))
        
        %Save Networks
        save(['Networks_Activity\net1' num2str(j)],'net1');
        
        %MSE Performance
        outputs = (net1(input_mat));
        perf = mse(net1,output_mat1,outputs);
        
        array1_mse = [array1_mse perf];
        Best_net1_mse = min(array1_mse);
         pause(25)
    end
        