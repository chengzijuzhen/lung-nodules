function [] = jianqieimage(image_path,xls_path,result_folder,dirname)
close all;
%肺实质的图片
% image_path = 'dataset\01\jpg_fenge\0002\';
% %肺结节的位置信息和良恶性程度
% xls_path = 'dataset\01\xls\2.xls';
% %剪切出来的图片的存放位置
% result_folder = 'dataset\01\result\0002\';

if exist(result_folder, 'dir')==0   %该文件夹不存在，则直接创建
    mkdir(result_folder);
end
[txt,num,alldata] = xlsread([xls_path,dirname,'.xls']);
xls_num = size(alldata);

fprintf('xls_num: %d\n',xls_num())
for m = 1:xls_num(1)
     img_number = alldata(m,1);     
     str = img_number{1};
     img_name= num2str(str,'%06d');
     img_fullname = [img_name,'.jpg'];
     jpg_child_path = [image_path,img_fullname];
        if exist(jpg_child_path,'file')
          col4x = txt(m,4) - txt(m,2);
          col4y = txt(m,5) - txt(m,3);
          malignent=txt(m,6);
          %dir = txt(m,7);
          %times = txt(m,8);
          size_center = [];
          if col4x < 64 && col4y < 64
              %ma = 0.5 * (32 - max(col4x,col4y));
               ma = (64 - max(col4x,col4y))*0.5;  
              col4xy = [txt(m,2)-ma,txt(m,3)-ma,63,63];  
              size_center =[ma,ma,max(col4x,col4y)];
              jianqie(jpg_child_path,malignent,size_center,col4xy,img_name,m,result_folder,dirname);
              %continue;%控制跳过循环体的下面这些语句          
          else
              size_center =[0,0,max(col4x,col4y)];
              col4xy = [txt(m,2),txt(m,3),max(col4x,col4y),max(col4x,col4y)];
              jianqie(jpg_child_path,malignent,size_center,col4xy,img_name,m,result_folder,dirname);
          end
      end    
%     break;
end
fprintf('finish dirname: %s\n',dirname())
end