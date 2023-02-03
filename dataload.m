[filename, pathname] = uigetfile({'*.xlsx'}, 'Pick an excel file');
dataset = fullfile(pathname, filename);
data = xlsread(dataset);