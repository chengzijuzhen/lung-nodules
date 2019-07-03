function [] = jianqieimage()
close all;
clear;
clc;
%肺实质的图片
image_path = 'E:\matlab\segmentation\dataset\jpg_fenge\0001\';
%肺结节的位置信息和良恶性程度
xls_path = 'E:\matlab\segmentation\dataset\xls\0001\1.xls';
[txt,num,alldata] = xlsread(xls_path);
xls_num = size(alldata);
xls_num(1);
for m = 1:xls_num(1)
     img_number = alldata(m,1);     
     str = img_number{1};
     img_name = ['0000',num2str(str),'.jpg'];
     jpg_child_path = [image_path,img_name];
     %jpg_child_path='E:\matlab\segmentation\dataset\jpg_fenge\test\000043.jpg';
      if exist(jpg_child_path,'file')
          col4x = txt(m,4) - txt(m,2);
          col4y = txt(m,5) - txt(m,3);
          dir = txt(m,6);
          times = txt(m,7);
          size_center = [];
          if col4x < 64 && col4y < 64
              ma = 0.5 * (64 - max(col4x,col4y));      
              col4xy = [txt(m,2)-ma,txt(m,3)-ma,64,64];  
              size_center =[ma,ma,max(col4x,col4y)];
              jianqie(jpg_child_path,dir,times,size_center,col4xy,m);
              continue;%控制跳过循环体的下面这些语句
          end
          size_center =[0,0,max(col4x,col4y)];
          col4xy = [txt(m,2),txt(m,3),max(col4x,col4y),max(col4x,col4y)];
          jianqie(jpg_child_path,dir,times,size_center,col4xy,m);
      end    
%     break;
end