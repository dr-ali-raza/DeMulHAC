[filename, pathname] = uigetfile({'*.xlsx'}, 'Pick an excel file');
output = fullfile(pathname, filename);
target = xlsread(output);