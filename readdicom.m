function [] = readdicom(dicom_path)
%xml_path = 'E:\matlab\segmentation\dataset\jpg_fenge\test\248.xml';
% origin_data_path='E:\matlab\segmentation\dataset\dicom\0001\';
dicom_path_cell = strsplit(dicom_path, 'dicom');
xls_folder = strcat('dataset\xls', dicom_path_cell{2});
if exist(xls_folder, 'dir')==0   %该文件夹不存在，则直接创建
    mkdir(xls_folder);
end

[num_mal,sop_text,max_min_xy]=readxml(dicom_path);  %函数调用
%  num_mal = []; %每个结节的恶性度和属于该类别的图片的数量
%  sop_text = { }; %每个图片的标号
% max_min_xy = []; %每个图像中肺结节的x和y的最小值和最大值
sop_num = size(sop_text);%获得行列数，行：1行， 列：图片张数*
mal_num = size(num_mal); %行：图片数？*，每个结节的恶性度和属于该类别的图片的数量
dcm_number = [];   %图片编号*

%------------补齐0，以保证维度一致，后面可以写入xls文件-----------------------------
if sop_num(2)>mal_num(1)%要根据他们两个的差值来决定补多少个0
    for m = 1 : sop_num(2)-mal_num(1)
        num_mal = [num_mal();0,0];%添加扩展维度*
    end
end

if sop_num(2)< mal_num(1)
    for m = 1 :  mal_num(1) - sop_num(2) %只有数据维度一样才能被写入到文件中！所以少的要补上四个0
        dcm_number= [dcm_number;0];%添加扩展维度
        max_min_xy = [max_min_xy;0,0,0,0];%添加扩展维度
    end
end
for md = 1 : sop_num(2) %添加扩展维度
    dcm_number= [dcm_number;0];
end
%----------------------------------------------------------------------------------

%---------------------------------读取dicom文件-------------------------------------
dcm_files = dir(strcat(dicom_path, '\*.dcm')); % 获得文件列表
for j = 1:numel(dcm_files) %遍历文件
    dirname = strcat(dicom_path,dcm_files(j).name);
    dicomInformation = dicominfo(dirname); %存储图片信息
    instance = dicomInformation.SOPInstanceUID;
    imagenum = dicomInformation.InstanceNumber;
    % Make sure that the StudyInstanceUID matches that found in
    % the XML annotations
    for s = 1 : sop_num(2)    %对比
        if strcmpi(instance,sop_text(1,s))
            dcm_number(s) = imagenum; %将dicom图片编号保存
        end
    end
end
total = [dcm_number,max_min_xy,num_mal];
xlswrite(strcat(xls_folder, '1.xls'),total); %导入到表格中




