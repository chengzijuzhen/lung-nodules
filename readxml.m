%function [sop_text,max_min_xy,malignent,num_mal]=readxml(xml_path)
function [sop_text,max_min_xy,num_mal]=readxml(xml_path)
    xml_path='dataset\01\dicom\0002\072.xml';
    %%xml_path = 'E:\matlab\segmentation\dataset\jpg_fenge\test\248.xml';
    %% ��ת���ڲ��ǩunblindedReadNodule
    docNode = xmlread(xml_path);     %��ȡXML�ļ�����һ���ļ�ģ�ͽڵ�*  
    document = docNode.getDocumentElement();
    readingSession = document.getElementsByTagName('readingSession');  %�����������Ԫ�������ӽڵ��Nodelist����*
    %% ��󷵻ص�����ֵ
    %% ��󷵻ص�����ֵ
    %malignent=[];% %ÿ����ڵĶ��Զ�
    num_mal = []; %ÿ����ڵĶ��ԶȺ����ڸ�����ͼƬ������
    sop_text = {}; %ÿ��ͼƬ�ı��
    max_min_xy = []; %ÿ��ͼ���зν�ڵ�x��y����Сֵ�����ֵ
    sop_num = 0; %���н�ڵ�ͼ������*
    %%
    for r = 0:readingSession.getLength()-1
        %unblindedReadNoduleһ���ڵ��ǣ�<unblindedReadNodule>�ڵ����ݰ�����</unblindedReadNodule>*
        unblinded_nodule = readingSession.item(r).getElementsByTagName('unblindedReadNodule');
%         unblinded_nodule.item
%         m=unblinded_nodule.item(0).getElementsByTagName('malignancy');
%         m_int=str2num(char(m.item(0).getTextContent()));
%         malignent=[malignent();m_int];

        for u = 0 : unblinded_nodule.getLength()-1
            roi = unblinded_nodule.item(u).getElementsByTagName('roi');   %item() �����ɷ��ؽڵ��б��д���ָ�������ŵĽڵ㡣*<roi>�������</roi>*
            mal = unblinded_nodule.item(u).getElementsByTagName('malignancy');    %<malignancy>��ڶ��Զ�</malignancy>*
            %���xml�ļ���û��malignancy����roi��ǩֱ������
            if isempty(roi.item(0))       
                continue;
            end
            if isempty(mal.item(0))       
                continue;
            end
            Num_roi = roi.getLength();   %������ͼƬ������
            mal_int = str2num(char(mal.item(0).getTextContent()));        
            num_mal = [num_mal();mal_int,Num_roi];         
            for i = 0 : Num_roi-1  %����*        
                sop_id = roi.item(i).getElementsByTagName('imageSOP_UID');    %ͼƬ���*  
                sop_text{sop_num + i + 1} = char(sop_id.item(0).getTextContent());   %����*
                edgeMap = roi.item(i).getElementsByTagName('edgeMap');   %�߽�* 
                 xy = [];
                for j = 0 :edgeMap.getLength()-1            %�������*
                    xCoord = edgeMap.item(j).getElementsByTagName('xCoord');
                    xCoord_int = str2num(char(xCoord.item(0).getTextContent()));
                    yCoord = edgeMap.item(j).getElementsByTagName('yCoord');
                    yCoord_int = str2num(char(yCoord.item(0).getTextContent()));
                    xy=[xy();xCoord_int,yCoord_int];
                end
                %�ҵ��������*
                if edgeMap.getLength()==1
                   max_min_xy = [max_min_xy();xy,xy];
                   continue;
                end
                [maxr,max_index] = max(xy);
                [minr,min_index] = min(xy);
                max_min_xy = [max_min_xy();minr,maxr];          
            end
            sop_num = sop_num + Num_roi;   %�ܸ���
        end
        if isempty(num_mal)                      
                continue;
        end
        %fprintf('num_mal: %d\n',num_mal())
        %fprintf('malignent: %d\n',malignent())
        %num_mal = [num_mal();0,0];    %��չά��*
    end
end


