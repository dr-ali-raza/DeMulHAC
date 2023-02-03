% Load data set
prompt1 = {'Type OK to load .xlsx data file for ANOVA application'};
dlgtitle = 'Input';
dim = [1 50];
InputData = inputdlg(prompt1,dlgtitle,dim)
dataload
% Remove outliers & apply Anova
outliers_anova
m1 = msgbox (['You must save your file after applying ANOVA'])

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

% Start Training for Phase Recognition: Converging Networks
Final_phase_converging
%Start Training for Phase Recognition: Converging Diverging Networks
phases_cd_simple