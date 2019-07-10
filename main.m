clear;clc;
tic
origin_jpg_dir = 'dataset\01\jpg\';      %jpg 文件夹路径
dcm_dir = 'dataset\01\dicom\';          
split_dir = 'dataset\01\jpg_fenge\';
xls_dir = 'dataset\01\xls\';
clip_dir = 'dataset\01\result\';

dir_list = dir(origin_jpg_dir);    %jpg下文件夹列表

 %遍历
for i = 3:length(dir_list) %从3开始去掉.和..文件夹 3:length(dir_list)
%for i = 3:3
    dirname = dir_list(i).name;  %读取jpg文件夹名字,后续分割、xls等均使用此名字
    %拼接文件夹路径
    dcm_dirname = [dcm_dir, dirname, '\']; 
    split_dirname = [split_dir, dirname, '\']; 
    %依次调用流程函数, 不用的流程注释即可
    %fengefeishizhi([origin_jpg_dir, dirname, '\'], split_dirname);
    readdicom(dcm_dirname, xls_dir, dirname);
    %jianqieimage(split_dirname,xls_dir,clip_dir,dirname);    
end
   print('Finsh All!')
