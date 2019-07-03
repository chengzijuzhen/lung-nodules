clear;clc;
tic
origin_jpg_dir = 'dataset\jpg\';      %jpg 文件夹路径
dcm_dir = 'dataset\dicom\';          
split_dir = 'dataset\jpg_fenge\';
xls_dir = 'dataset\xls\';
clip_dir = 'dataset\result\';

dir_list = dir(origin_jpg_dir);    %jpg下文件夹列表

 %遍历
for i = 3:length(dir_list)  
    dir_name = dir_list(i).name;
    split_dirname = [split_dir, dir_name, '\'];
    fengefeishizhi([origin_jpg_dir, dir_name, '\'], split_dirname);
    %继续调用其他函数
    
end
% instance_index = '';
% origin_jpg_path =  'dataset\jpg\0001\*.jpg';
% dcm_path = 'dataset\dicom\0001\';
% readdicom(dcm_path);
toc