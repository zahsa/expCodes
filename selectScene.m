function [sceneImgDir,imgScene,consistent]=selectScene(objname)


HOMEIMAGES ='/home/zahra/Documents/ZahraDocuments/SUN2012/Images';
scenefolders=dir(HOMEIMAGES);
%--make consistent and inconsistent scene images
if rand(1,1)>.5
    consistent=1;
else
    consistent=0;
end

if consistent==1
if strcmp(objname,'car')==1
        car_consistent={'street','highway','building_facade','roundabout'};
        objconsistname=car_consistent;
        
        %-car--incosnsistent:
        %-
elseif strcmp(objname,'person')==1
        
        person_consistent={'street','building_facade','art_studio','airport_terminal'};
        objconsistname=person_consistent;
        
        %
        
elseif strcmp(objname,'tree')==1
        
        tree_consistent={'street','skyscraper','building_facade','forest'};
        objconsistname=tree_consistent;
        
        %
elseif strcmp(objname,'chair')==1
        
        chair_consistent={'dining_room','bedroom','kitchen','conference_room'};
        objconsistname=chair_consistent;
        
        
end
else
 if strcmp(objname,'car')==1
        car_consistent={'forest','highway','bedroom','kitchen'};
        objconsistname=car_consistent;
        
        %-car--incosnsistent:
        %-
elseif strcmp(objname,'person')==1
        
        person_consistent={'forest','highway','river','mountain'};
        objconsistname=person_consistent;
        
        %
        
elseif strcmp(objname,'tree')==1
        
        tree_consistent={'street','highway','bedroom','kitchen'};
        objconsistname=tree_consistent;
        
        %
elseif strcmp(objname,'chair')==1
        
        chair_consistent={'forest','highway','street','roundabout'};
        objconsistname=chair_consistent;
 end
end
    
% objlist={'car','person','tree','chair'};
%     objconsistname=strcat(objlist{i},'_consistent') %doesn't work, it
%     makes a string!

for i=1:length(objconsistname)
    imgScene=objconsistname{i};
    initLet=imgScene(1);
    ImgDir=strcat(HOMEIMAGES,'/',initLet,'/',imgScene);
    %         if isdir(AnnotDir)
    ImgDir2=dir(ImgDir);
    for f=1:length(ImgDir2)
        if ~strcmp(ImgDir2(f).name,'.') && ~strcmp(ImgDir2(f).name,'..')
            ImgSubFolder=strcat(ImgDir,'/',ImgDir2(f).name);
            if isequal(exist(ImgSubFolder, 'dir'),7)
                
                ImgSubFolder2=dir(ImgSubFolder);
                rndimglist=randperm(length(ImgSubFolder2));
                
                for r=1:length(ImgSubFolder2)
                    if ~strcmp(ImgSubFolder2(rndimglist(r)).name,'.') && ~strcmp(ImgSubFolder2(rndimglist(r)).name,'..');
                        sceneImgDir=strcat(ImgSubFolder,'/',ImgSubFolder2(rndimglist(r)).name);
                    end
                end
                
                
            else
                sceneImgDir=ImgSubFolder;
                
                                
            end
        end
    end
end

% figure;imshow(sceneImgDir)
end