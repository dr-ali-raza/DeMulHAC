%% Make folder
fpath = 'D:\OneDrive - Higher Education Commission\extracted data\Data\Mode';
folder = 'Networks_Phase';
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

%Data for Phases
O2 = target(:,2:5);
output_mat2 = O2.';

%% Networks
    for j = 1:10
        
        % Converging Networks array
        HL_arr = [HL_arr j];
        HL_arr(j) = n(j);
        NumHiddenLayers = HL_arr;
        
        %Network2 for Phase Recognition
        
        net2 = patternnet(NumHiddenLayers,'trainscg');
        net2.trainParam.epochs = 10000;    %epochs for which network trains
        net2.trainParam.goal = 1e-20;   %error at which network stops training
        net2.trainParam.lr = 0.0001;    %learning rate
        net2.trainParam.max_fail = 6000; 
        net2.trainParam.min_grad = 1e-20;
        net2.PerformFcn = 'mse';
        net2.divideFcn = 'dividerand';
        net2.divideParam.trainRatio = 0.7;
        net2.divideParam.valRatio = 0.10;
        net2.divideParam.testRatio = 0.20;
        [trainInd,valInd,testInd] = dividerand(input_mat,0.7,0.10,0.20); % training:70%, validation:10%, testing:20%
        [trainInd_O2,valInd_O2,testInd_O2] = dividerand(output_mat2,0.7,0.10,0.20);
        net2.plotFcns = {'plotperform','plotconfusion','plotregression','plottrainstate'};
        [net2,tr(2),error1] = train(net1,input_mat,output_mat1);    % train the network
        out_train2 = net2(input_mat(:,tr(2).trainInd));             %outputs of training data
        out_val2 = net2(input_mat(:,tr(2).valInd));                 %outputs of validation data
        out_test2 = net2(input_mat(:,tr(2).testInd));              %simulate 20% test data
        
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
        save(['Networks_Phase\net2' num2str(j)],'net2');
        
        %MSE Performance
        outputs = (net2(input_mat));
        perf = mse(net2,output_mat1,outputs);
        
        array2_mse = [array2_mse perf];
        Best_net2_mse = min(array2_mse);
        pause(25)
    end