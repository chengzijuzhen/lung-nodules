clear;clc;
tic
origin_jpg_dir = 'dataset\01\jpg\';      %jpg �ļ���·��
dcm_dir = 'dataset\01\dicom\';          
split_dir = 'dataset\01\jpg_fenge\';
xls_dir = 'dataset\01\xls\';
clip_dir = 'dataset\01\result\';

dir_list = dir(origin_jpg_dir);    %jpg���ļ����б�

 %����
for i = 3:length(dir_list) %��3��ʼȥ��.��..�ļ��� 3:length(dir_list)
%for i = 3:3
    dirname = dir_list(i).name;  %��ȡjpg�ļ�������,�����ָxls�Ⱦ�ʹ�ô�����
    %ƴ���ļ���·��
    dcm_dirname = [dcm_dir, dirname, '\']; 
    split_dirname = [split_dir, dirname, '\']; 
    %���ε������̺���, ���õ�����ע�ͼ���
    %fengefeishizhi([origin_jpg_dir, dirname, '\'], split_dirname);
    readdicom(dcm_dirname, xls_dir, dirname);
    %jianqieimage(split_dirname,xls_dir,clip_dir,dirname);    
end
   print('Finsh All!')
