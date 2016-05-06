 sceneDir=strcat([stimpath '\' ],'scene');
                scenefiles=dir(sceneDir);s=1;
                for l=1:length(scenefiles)
                    if ~strcmp(scenefiles(l).name,'.') && ~strcmp(scenefiles(l).name,'..')
                        sceneimgs(s)=scenefiles(l);s=s+1;
                    end
                end