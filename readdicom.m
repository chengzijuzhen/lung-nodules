%function [] = readdicom(dicom_path)
function [] = readdicom()

%��ȡdicom�ļ�Ŀ¼
dicom_path='dataset\01\dicom\';
dicom_path_cell = strsplit(dicom_path, 'dicom');
fprintf('dicom_path_cell{2}: %s\n',dicom_path_cell{2})
%������ȡxml�����xlsĿ¼
xls_folder = strcat('dataset\01\xls', dicom_path_cell{2});
fprintf('xls_folder: %s\n',xls_folder)
%xls_folder = 'dataset\01\xls\';
if exist(xls_folder, 'dir')==0   % ���ļ��в����ڣ���ֱ�Ӵ���
    mkdir(xls_folder);
end

% %��ȡxml�ļ���������������
% [sop_text,max_min_xy,malignent,num_mal]=readxml(dicom_path);  %��������
% 
% %[sop_text,max_min_xy,num_mal]=readxml(dicom_path);  %��������
% %  num_mal = []; %ÿ����ڵĶ��ԶȺ����ڸ�����ͼƬ������
% %  sop_text = { }; %ÿ��ͼƬ�ı��
% % max_min_xy = []; %ÿ��ͼ���зν�ڵ�x��y����Сֵ�����ֵ
% sop_num = size(sop_text);%������������У�1�У� �У�ͼƬ����*
% mal_num = size(num_mal); %�У�ͼƬ����*��ÿ����ڵĶ��ԶȺ����ڸ�����ͼƬ������
% dcm_number = [];   %ͼƬ���*
% 
% %------------����0���Ա�֤ά��һ�£��������д��xls�ļ�-----------------------------
% if sop_num(2)>mal_num(1)%Ҫ�������������Ĳ�ֵ�����������ٸ�0
%     for m = 1 : sop_num(2)-mal_num(1)
%         num_mal = [num_mal();0,0];%�����չά��*
%     end
% end
% 
% if sop_num(2)< mal_num(1)
%     for m = 1:mal_num(1) - sop_num(2) %ֻ������ά��һ�����ܱ�д�뵽�ļ��У������ٵ�Ҫ�����ĸ�0
%         dcm_number= [dcm_number;0];%�����չά��
%         max_min_xy = [max_min_xy;0,0,0,0];%�����չά��
%     end
% end
% for md = 1:sop_num(2) %�����չά��
%     dcm_number= [dcm_number;0];
% end
% %----------------------------------------------------------------------------------
% 
% %---------------------------------��ȡdicom�ļ�-------------------------------------
% %dcm_files = dir(strcat(dicom_path,'\*.dcm')); % ����ļ��б�
% dcm_files=dir('dataset\01\dicom\0002\*.dcm');
% for j = 1:numel(dcm_files) %�����ļ�
%     dicomname=dcm_files(j).name;
%     dirname = strcat('dataset\01\dicom\0002\',dicomname);
%     dicomInformation = dicominfo(dirname); %�洢ͼƬ��Ϣ
%     %fprintf('dirname: %s\n',dirname)
%     instance = dicomInformation.SOPInstanceUID;%ΨһID
%     %imagenum = dicomInformation.InstanceNumber;
%     %fprintf('imagenum: %d\n',imagenum)
%     % Make sure that the StudyInstanceUID matches that found in
%     % the XML annotations
%     for s = 1 : sop_num(2)    %�Ա�
%         if strcmpi(instance,sop_text(1,s))%�Ƚ�����������������ĸ��Сд���졣
%             dcm_number(s) = str2num(dicomname(1:end-4)); %��dicomͼƬ��ű���
%         end
%     end
% end
%  %fprintf('malignent: %d\n',malignent)
% total = [dcm_number,max_min_xy,malignent,num_mal];
% xlswrite(strcat(xls_folder, '2.xls'),total); %���뵽�����
% 
% end
% 
% 
% 
% 
