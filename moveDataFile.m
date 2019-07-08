function [ output_args ] = moveDataFile( dcm_dir )
%MOVEFILE  
%   把dcmDir文件夹深处的文件搬到dcmDir下
    dir_names = getDeepPath(dcm_dir);
    dir_name = char(dir_names(length(dir_names)));
    if strcmp(dcm_dir, dir_name)
        return
    end
    dcm_name = [dir_name,'*.dcm'];
    xml_name = [dir_name,'*.xml'];
    file_list = dir(dcm_name);
    if ~isempty(file_list)
        movefile(dcm_name, dcm_dir);
    end
     file_list = dir(xml_name);
    if ~isempty(file_list)
        movefile(xml_name, dcm_dir);
    end
    
end


function [ deepPath ] = getDeepPath( dirPath )

    dir_list = dir(dirPath);
    tmp_dir = ''; %临时文件夹
    deepPath={dirPath};
    if length(dir_list)  > 2
        %遍历
        for i = 3:length(dir_list)  
            tmp_dir = dir_list(i);
            if tmp_dir.isdir
                [dir_name] = getDeepPath([dirPath, tmp_dir.name,'\']);
                deepPath = [deepPath, dir_name];
            end
        end
%     else
%         deepPath={dirPath};
    end
     

end


