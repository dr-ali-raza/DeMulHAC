[filename, pathname] = uigetfile ({'*.xlsx'}, 'Pick an excel file');
fullname = fullfile(pathname, filename);
input = xlsread(fullname);
