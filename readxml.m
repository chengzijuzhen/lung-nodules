%function [sop_text,max_min_xy,malignent,num_mal]=readxml(xml_path)
function [sop_text,max_min_xy,num_mal]=readxml(xml_path)
    xml_path='dataset\01\dicom\0002\072.xml';
    %%xml_path = 'E:\matlab\segmentation\dataset\jpg_fenge\test\248.xml';
    %% 跳转到内层标签unblindedReadNodule
    docNode = xmlread(xml_path);     %读取XML文件返回一个文件模型节点*  
    document = docNode.getDocumentElement();
    readingSession = document.getElementsByTagName('readingSession');  %返回与给定的元素所有子节点的Nodelist对象*
    %% 最后返回的三个值
    %% 最后返回的三个值
    %malignent=[];% %每个结节的恶性度
    num_mal = []; %每个结节的恶性度和属于该类别的图片的数量
    sop_text = {}; %每个图片的标号
    max_min_xy = []; %每个图像中肺结节的x和y的最小值和最大值
    sop_num = 0; %含有结节的图像张数*
    %%
    for r = 0:readingSession.getLength()-1
        %unblindedReadNodule一个节点标记，<unblindedReadNodule>节点数据包括在</unblindedReadNodule>*
        unblinded_nodule = readingSession.item(r).getElementsByTagName('unblindedReadNodule');
%         unblinded_nodule.item
%         m=unblinded_nodule.item(0).getElementsByTagName('malignancy');
%         m_int=str2num(char(m.item(0).getTextContent()));
%         malignent=[malignent();m_int];

        for u = 0 : unblinded_nodule.getLength()-1
            roi = unblinded_nodule.item(u).getElementsByTagName('roi');   %item() 方法可返回节点列表中处于指定索引号的节点。*<roi>结节轮廓</roi>*
            mal = unblinded_nodule.item(u).getElementsByTagName('malignancy');    %<malignancy>结节恶性度</malignancy>*
            %如果xml文件中没有malignancy或者roi标签直接跳过
            if isempty(roi.item(0))       
                continue;
            end
            if isempty(mal.item(0))       
                continue;
            end
            Num_roi = roi.getLength();   %该类别的图片的数量
            mal_int = str2num(char(mal.item(0).getTextContent()));        
            num_mal = [num_mal();mal_int,Num_roi];         
            for i = 0 : Num_roi-1  %遍历*        
                sop_id = roi.item(i).getElementsByTagName('imageSOP_UID');    %图片编号*  
                sop_text{sop_num + i + 1} = char(sop_id.item(0).getTextContent());   %数组*
                edgeMap = roi.item(i).getElementsByTagName('edgeMap');   %边界* 
                 xy = [];
                for j = 0 :edgeMap.getLength()-1            %获得坐标*
                    xCoord = edgeMap.item(j).getElementsByTagName('xCoord');
                    xCoord_int = str2num(char(xCoord.item(0).getTextContent()));
                    yCoord = edgeMap.item(j).getElementsByTagName('yCoord');
                    yCoord_int = str2num(char(yCoord.item(0).getTextContent()));
                    xy=[xy();xCoord_int,yCoord_int];
                end
                %找到结节轮廓*
                if edgeMap.getLength()==1
                   max_min_xy = [max_min_xy();xy,xy];
                   continue;
                end
                [maxr,max_index] = max(xy);
                [minr,min_index] = min(xy);
                max_min_xy = [max_min_xy();minr,maxr];          
            end
            sop_num = sop_num + Num_roi;   %总个数
        end
        if isempty(num_mal)                      
                continue;
        end
        %fprintf('num_mal: %d\n',num_mal())
        %fprintf('malignent: %d\n',malignent())
        %num_mal = [num_mal();0,0];    %扩展维数*
    end
end


