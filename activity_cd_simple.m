%n1 = [130 65 90 45];

%% Make folder
fpath = 'D:\OneDrive - Higher Education Commission\extracted data\Data\Mode';
folder1 = 'Networks_Activity_CD_4';
folder2 = 'Networks_Activity_CD_5';
folder3 = 'Networks_Activity_CD_6';
 if ~exist(fullfile(fpath,folder1),'dir')
    mkdir(fullfile(fpath,folder1))
 end
 if ~exist(fullfile(fpath,folder2),'dir')
    mkdir(fullfile(fpath,folder2))
 end
 if ~exist(fullfile(fpath,folder3),'dir')
    mkdir(fullfile(fpath,folder3))
 end
 %% Initialize Variables
p1 = 0;
p2 = 0;
k1 = 0;
k2 = 0;
HL_arr = [];
array1_mse_4L = [];
array1_mse_5L = [];
array1_mse_6L = [];

%% Import Data
I = input(:,:);
input_mat = I.';

%Data for Activity
O1 = target(:,3:8);
output_mat1 = O1.';

%% User Input 
prompt4 = {'Enter the number of hidden layers between 4 to 6:'};
dlgtitle = 'Input';
dim = [1 50];
x = inputdlg(prompt4,dlgtitle,dim)
y = x;

if y == 4
% 4 Layer Network
for j = 1:3
        n(1) = 130; %half the number of neurons of inputs
        n(2) = 130+30; 
        n(3) = 130-30;
        a = [];
        a = [n(j)];
        a = [n(j) n(j)/2];
        a = [n(j) n(j)/2 a(2)+25];
        a = [n(j) n(j)/2 a(2)+25 a(3)/2];
        a = ceil(a);
        A{j} = a;
        NumHiddenLayers = A{1,j}
        
        %Network1 for Activity Recognition
        
        net1 = patternnet(NumHiddenLayers,'trainscg');
        net1.trainParam.epochs = 2;    %epochs for which network trains
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
        out_test1 = net1(input_mat(:,tr(1).testInd));              %simulate 20% test data
        
        % Make Subfolder
        Z = fullfile(fpath,folder1,sprintf('4L_network%d',j));
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
        save(['Networks_Activity_CD_4\net1' num2str(j)],'net1');
        
        %MSE Performance
        outputs = (net1(input_mat));
        perf = mse(net1,output_mat1,outputs);
        
        array1_mse_4L = [array1_mse_4L perf];
        Best_net1_mse_4L = min(array1_mse_4L);
        pause(25)
end

elseif y == 5
% 5 LAYER NETWORKS
for j = 1:3
        n(1) = 130; %half the number of neurons of inputs
        n(2) = 130+30; 
        n(3) = 130-30;
        a = [];
        a = [n(j)];
        a = [n(j) n(j)/2];
        a = [n(j) n(j)/2 a(2)+25];
        a = [n(j) n(j)/2 a(2)+25 a(3)/2];
        a = [n(j) n(j)/2 a(2)+25 a(3)/2 a(4)+25];
        a = ceil(a);
        A{j} = a;
        NumHiddenLayers = A{1,j};
        
        %Network1 for Activity Recognition
        
        net1 = patternnet(NumHiddenLayers,'trainscg');
        net1.trainParam.epochs = 2;    %epochs for which network trains
        net1.trainParam.goal = 1e-20;   %error at which network stops training
        net1.trainParam.lr = 0.0001;    %learning rate
        net1.trainParam.max_fail = 6000; 
        net1.trainParam.min_grad = 1e-20;
        net1.PerformFcn = 'mse';
        net1.divideFcn = 'divideblock';
        net1.divideParam.trainRatio = 0.7;
        net1.divideParam.valRatio = 0.10;
        net1.divideParam.testRatio = 0.20;
        [trainInd,valInd,testInd] = divideblock(input_mat,0.7,0.10,0.20); % training:70%, validation:10%, testing:20%
        [trainInd_O1,valInd_O1,testInd_O1] = divideblock(output_mat1,0.7,0.10,0.20);
        net1.plotFcns = {'plotperform','plotconfusion','plotregression','plottrainstate'};
        [net1,tr(1),error1] = train(net1,input_mat,output_mat1);    % train the network
        out_train1 = net1(input_mat(:,tr(1).trainInd));             %outputs of training data
        out_val1 = net1(input_mat(:,tr(1).valInd));                 %outputs of validation data
        out_test1 = net1(input_mat(:,tr(1).testInd));              %simulate 20% test data
        
        % Make Subfolder
        Z = fullfile(fpath,folder2,sprintf('5L_network%d',j));
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
        save(['Networks_Activity_CD_5\net1' num2str(j)],'net1');
        
        %MSE Performance
        outputs = (net1(input_mat));
        perf = mse(net1,output_mat1,outputs);
        
        array1_mse_5L = [array1_mse_5L perf];
        Best_net1_mse_5L = min(array1_mse_5L);
        %pause(60)
end

else y == 6
% 6 LAYER NETWORKS
for j = 1:3
        n(1) = 130; %half the number of neurons of inputs
        n(2) = 130+30; 
        n(3) = 130-30;
        a = [];
        a = [n(j)];
        a = [n(j) n(j)/2];
        a = [n(j) n(j)/2 a(2)+25];
        a = [n(j) n(j)/2 a(2)+25 a(3)/2];
        a = [n(j) n(j)/2 a(2)+25 a(3)/2 a(4)+25];
        a = [n(j) n(j)/2 a(2)+25 a(3)/2 a(4)+25 a(5)/2];
        a = ceil(a);
        A{j} = a;
        NumHiddenLayers = A{1,j}
        
        %Network1 for Activity Recognition
        
        net1 = patternnet(NumHiddenLayers,'trainscg');
        net1.trainParam.epochs = 2;    %epochs for which network trains
        net1.trainParam.goal = 1e-20;   %error at which network stops training
        net1.trainParam.lr = 0.0001;    %learning rate
        net1.trainParam.max_fail = 6000; 
        net1.trainParam.min_grad = 1e-20;
        net1.PerformFcn = 'mse';
        net1.divideFcn = 'divideblock';
        net1.divideParam.trainRatio = 0.7;
        net1.divideParam.valRatio = 0.10;
        net1.divideParam.testRatio = 0.20;
        [trainInd,valInd,testInd] = divideblock(input_mat,0.7,0.10,0.20); % training:70%, validation:10%, testing:20%
        [trainInd_O1,valInd_O1,testInd_O1] = divideblock(output_mat1,0.7,0.10,0.20);
        net1.plotFcns = {'plotperform','plotconfusion','plotregression','plottrainstate'};
        [net1,tr(1),error1] = train(net1,input_mat,output_mat1);    % train the network
        out_train1 = net1(input_mat(:,tr(1).trainInd));             %outputs of training data
        out_val1 = net1(input_mat(:,tr(1).valInd));                 %outputs of validation data
        out_test1 = net1(input_mat(:,tr(1).testInd));              %simulate 20% test data
        
        % Make Subfolder
        Z = fullfile(fpath,folder3,sprintf('6L_network%d',j));
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
        save(['Networks_Activity_CD_6\net1' num2str(j)],'net1');
        
        %MSE Performance
        outputs = (net1(input_mat));
        perf = mse(net1,output_mat1,outputs);
        
        array1_mse_6L = [array1_mse_6L perf];
        Best_net1_mse_6L = min(array1_mse_6L);
        %pause(60)
end
end