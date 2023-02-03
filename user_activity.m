% Load data set
prompt1 = {'Type OK to load .xlsx data file for ANOVA application'};
dlgtitle = 'Input';
dim = [1 50];
InputData = inputdlg(prompt1,dlgtitle,dim)

dataload

% Remove outliers & apply Anova
outliers_anova
m1 = msgbox (['You must save your file after applying ANOVA'])
pause(3)
% Load Input File for Training
prompt2 = {'Type OK to load your training data file'};
dlgtitle = 'Training Data Input';
dim = [1 50];
TrainData = inputdlg(prompt2,dlgtitle,dim)

filein
% Load Target File for Training
prompt3 = {'Type OK to load your target data file'};
dlgtitle = 'Target Data Input';
dim = [1 50];
TargetData = inputdlg(prompt3,dlgtitle,dim)
fileout
% take_output
% Start Training for Activity Recognition: Converging Networks
Final_activity_converging
% Start Training for Activity Recognition: Converging Diverging Networks
activity_cd_simple