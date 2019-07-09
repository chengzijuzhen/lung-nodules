clear;clc;
tic
origin_jpg_dir = 'dataset\01\jpg\';      %jpg �ļ���·��
dcm_dir = 'dataset\01\dicom\';          
split_dir = 'dataset\01\jpg_fenge\';
xls_dir = 'dataset\01\xls\';
clip_dir = 'dataset\01\result\';

dir_list = dir(origin_jpg_dir);    %jpg���ļ����б�

 %����
for i = 3:length(dir_list)  %��3��ʼȥ��.��..�ļ���
    dirname = dir_list(i).name;  %��ȡjpg�ļ�������,�����ָxls�Ⱦ�ʹ�ô�����
    %ƴ���ļ���·��
    dcm_dirname = [dcm_dir, dirname, '\']; 
    split_dirname = [split_dir, dirname, '\']; 
    xls_dirname = [xls_dir, dirname, '\'];
    result_dirname = [clip_dir, dirname, '\'];
    %���ε������̺���, ���õ�����ע�ͼ���
%     fengefeishizhi([origin_jpg_dir, dir_name, '\'], split_dirname);

    readdicom(dcm_dirname, xls_dir, dirname);
    
    
    
end
% instance_index = '';
% origin_jpg_path =  'dataset\jpg\0001\*.jpg';
% dcm_path = 'dataset\dicom\0001\';
% readdicom(dcm_path);
