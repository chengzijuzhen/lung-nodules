function jianqie(img_path,dir,times,size_center,col4xy,num)
   %dir 为患病可能程度，col4xy为剪切区域
    img=imread(img_path);  %读取图片文件*
    img1=imcrop(img,col4xy);   %返回图像的一个裁剪区域*  I2=imcrop(I,[a b c d]);%利用裁剪函数裁剪图像，其中，
    %（a,b）表示裁剪后左上角像素在原图像中的位置；c表示裁剪后图像的宽，d表示裁剪后图像的高
 %% 分割肺结节实质
    img1_size = size(img1);
    min(min(img1)); %找到最小值，最大值
    max(max(img1));
    t=graythresh(img1); %使用最大类间方差法找到图片的一个合适的阈值threshold
    C=im2bw(img1,t);   %转换为二值图像*
    %figure(),imshow(C,[]),title('显示二值化图像');%显示二值化图像
    D=imfill(C,4,'holes');%对二值化后的图像填充肺实质
    %figure(),imshow(D,[]),title('显示填充肺实质');%显示填充肺实质
    if dir >=4    %大概率为肺癌*
        FMask=bwareaopen(D,10);  %除二值图像中面积小于10的对象  
        D = FMask;
    end
    total = 0;  
    for i = 1:img1_size(1) %行数    
        for j = 1:img1_size(2) %列数
            if D(i,j) == 0  %二值图像当值为0时  （黑色）
                img1(i,j) = 0;
            end
            if D(i,j) == 1 %二值图像当值为1时  （白色）
                if ~(i > size_center(1) && j > size_center(1)&& j < size_center(1) + size_center(3)&& i < size_center(1) + size_center(3))%不在范围内*？
                     img1(i,j) = 0; %取为黑色*
                end
            end
        end
    end
  %% 保存图片
for m = 1:img1_size(1)
    for n = 1:img1_size(2)
        if img1(m,n) == 0 %黑色元素点个数*
            total = total + 1;
        end
    end
end
%figure(),imshow(img1,[]),title('存入图片');
if total ~= img1_size(1)*img1_size(2)   %如果不全是黑*
    figure(),imshow(img1,[]),title('存入图片');
    pngname = ['dataset\result\0001\',num2str(num), '.png'];
    imwrite(img1, pngname, 'png');    %存入图片*
end
end



