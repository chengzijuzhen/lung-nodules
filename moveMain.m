clear;clc;
tic

dcm_dir = 'dataset\dicom\';          

dir_list = dir(dcm_dir);    %dicom文件夹列表

 %遍历
for i = 3:length(dir_list)  
    dir_name = dir_list(i).name;
    moveDataFile( [dcm_dir, dir_name, '\'])

end

toc