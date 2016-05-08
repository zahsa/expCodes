function objImgDir=selectObjsmpl(objname)

HOMEOBJECTS='/home/zahra/Documents/ZahraDocuments/SUN2012/ObjectsInOneFolder';
objFoldDir=strcat(HOMEOBJECTS,'/',objname);
objSmplDir=dir(objFoldDir);
s=1+fix(length(objSmplDir)*rand(1,1));
% objSceDir=strcat(objSceDir,'/',rndsce
%      for f=1:length(objSceDir)
while strcmp(objSmplDir(s).name,'.')   || strcmp(objSmplDir(s).name,'..')
    s=1+fix(length(objSmplDir)*rand(1,1));
end
objImgDir=strcat(objFoldDir,'/',objSmplDir(s).name);
% figure;imshow(objImgDir)