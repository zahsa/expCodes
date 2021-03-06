stimpath='/home/zahra/Documents/ZahraDocuments/experiment stimulus';

AssertOpenGL;
NOISE=imresize(imread(strcat(stimpath,'/',char('Noise.jpg'))),[256 256]);
KbName('UnifyKeyNames');
objlist={'car','person','tree','chair'};
try
    screens=Screen('Screens');
    screenNumber=max(screens);
    HideCursor;
    gray=GrayIndex(screenNumber);
    
    
    [w, wRect]=Screen('OpenWindow',screenNumber, gray);
    % Set priority for script execution to realtime priority:
    priorityLevel=MaxPriority(w);
    Priority(priorityLevel);
    str1=sprintf('You will see a scenary image followed by an image of an occluded object\n');
    str2=sprintf('You will be asked to type the name of the object you see\n');
    message = ['test phase ...\n' str1 str2 '... press mouse button to begin ...'];
    DrawFormattedText(w, message, 'center', 'center', WhiteIndex(w));
    
    
    % Update the display to show the instruction text:
    Screen('Flip', w);
    
    % Wait for mouse click:
    GetClicks(w);
    
    Screen('Flip', w);
    
    WaitSecs(1.000);
    
    
    ntrials=1;
    randomorder1=randperm(ntrials);     % randperm() is a matlab function  3 yani tedate frame ha
    TT=randperm(ntrials);
    for trial=1:ntrials
        %         if (trial==floor(ntrials/3) || trial == floor(ntrials*2/3))
        %             str2=sprintf('Take a rest \n');
        %             str3=sprintf('5 Minutes \n');
        %             message = [str2 str3 '... press mouse button to continue ...'];
        %             DrawFormattedText(w, message, 'center', 'center', WhiteIndex(w));
        %             % Update the display to show the instruction text:
        %             Screen('Flip', w);
        %
        %             % Wait for mouse click:
        %             GetClicks(w);
        %             WaitSecs(2);
        %
        %         end
        
        
%         imglist=dir(stimpath);
        
%         % read images of a scene
%         sceneDir=strcat([stimpath '\' ],'scene');
%         scenefiles=dir(sceneDir);s=1;
%         for l=1:length(scenefiles)
%             if ~strcmp(scenefiles(l).name,'.') && ~strcmp(scenefiles(l).name,'..')
%                 sceneimgs(s)=scenefiles(l);s=s+1;
%             end
%         end
        
%         % read images of objects
%         objDir=strcat([stimpath '\' ],'object');
%         objfiles=dir(objDir);s=1;
%         for l=1:length(objfiles)
%             if ~strcmp(objfiles(l).name,'.') && ~strcmp(objfiles(l).name,'..')
%                 objimgs(s)=objfiles(l);s=s+1;
%             end
%         end
        samplnum=5;
        objNum=length(objlist);rndlist=randperm(objNum);
        randObj=randperm(objNum);
        for o=1:samplnum
            objname=cell2mat(objlist(randObj(o)));
            stimuli(o).name=objname;
            % 1-select a scene randomly
%             sceneImgDir=strcat([stimpath '\' ],'scene','\',sceneimgs(rndlist(o)).name); % assume stims are in subfolder "stims"
            [sceneImgDir,objconsistname,consist]=selectScene(objname);
            imdata=(imresize((imread(char(sceneImgDir))),[256 256]));
            stimuli(o).scene=objconsistname;
            stimuli(o).consistent=consist;
            % 2-show fixation point
            centx = wRect(3)/2;
            centy = wRect(4)/2;
            fixationArea = [centx-5, centy-5, centx+5, centy+5];
            Screen('FillOval', w, [0 255 0], fixationArea);
            Screen('Flip',w);
            % Fixation presentation
            WaitSecs(1);
            
            
            % %         [KeyIsDown, endrt, KeyCode]=KbCheck;
            
            % 3-display the scene image
            Screen('PutImage', w, imdata);
            %                 tex=Screen('MakeTexture', w, imdata);
            %                 Screen('DrawTexture', w, tex);
            
            [~, startstim]=Screen('Flip', w);
            
            while (GetSecs - startstim)<=0.1
            end
            
            % make the screen gray
            Screen(w, 'FillRect', gray);
            [~,startgray1]=Screen(w, 'Flip');
            Trial.Stimulus_duration(trial)=startgray1-startstim;
            
            while (GetSecs - startgray1)<=0.02
            end
            
            % -dispaly noisy image
            tex=Screen('MakeTexture', w, NOISE);
            Screen('DrawTexture', w, tex);
            [~, startNoise]=Screen('Flip', w);
            
            % make the screen gray
            Trial.gary_duration1(trial)=startNoise-startgray1;
            while (GetSecs - startNoise)<=0.1
            end
            Screen(w, 'FillRect', gray);
            [~,startgray2]=Screen(w, 'Flip');
            Trial.Noise_duration(trial)=startgray2-startNoise;
            %         key3=zeros(size(KeyCode));
            %         key2=zeros(size(KeyCode));
            %         endrt2=0;
            %                 [KeyIsDown, endrt, KeyCode]=KbCheck;
            %                 while ( KeyCode(GO)==0 && KeyCode(NOGO)==0)
            %                     [KeyIsDown, endrt, KeyCode]=KbCheck;
            %                     key1=KeyCode;
            %                     WaitSecs(0.001);
            %                 end
            WaitSecs(1);
            %                 if (strcmp(Type,'test'))
            %                     if KeyCode(GO)==1
            %                         Trial.SubjectRes=[Trial.SubjectRes 0];
            %                     else
            %                         Trial.SubjectRes=[Trial.SubjectRes 1];
            %                     end
            %                 end
            % compute response time
            %                 rt=round(1000*(endrt-startgray2));
            %                 if (strcmp(Type,'test'))
            %                     Trial.ImageNumber=[Trial.ImageNumber CollNum];
            %                     Trial.SubRespTime=[Trial.SubRespTime rt];
            %                 end
            
            
            % -select an object randomly
%             sceneImgDir=strcat([stimpath '\' ],'object','\',objimgs(rndlist(o)).name); % assume stims are in subfolder "stims"
            
            sceneImgDir=selectObjsmpl(objname);

            imdata=(imresize((imread(char(sceneImgDir))),[256 256]));
            
            % -show fixation point
            centx = wRect(3)/2;
            centy = wRect(4)/2;
            fixationArea = [centx-5, centy-5, centx+5, centy+5];
            Screen('FillOval', w, [0 255 0], fixationArea);
            Screen('Flip',w);
            WaitSecs(1);
            
            
            % %         [KeyIsDown, endrt, KeyCode]=KbCheck;
            
            % -show object
            Screen('PutImage', w, imdata);
            %                 tex=Screen('MakeTexture', w, imdata);
            %                 Screen('DrawTexture', w, tex);
            
            [~, startstim]=Screen('Flip', w);
            
            %- wait for .... seconds ????
            while (GetSecs - startstim)<=0.1
            end
            
            %- gray the screen?????
            Screen(w, 'FillRect', gray);
            [~,startgray1]=Screen(w, 'Flip');
            Trial.Stimulus_duration(trial)=startgray1-startstim;
            while (GetSecs - startgray1)<=0.02
            end
            
            %- show noise
            tex=Screen('MakeTexture', w, NOISE);
            Screen('DrawTexture', w, tex);
            [~, startNoise]=Screen('Flip', w);
            Trial.gary_duration1(trial)=startNoise-startgray1;
            
            %-wait for --- secnods ???
            while (GetSecs - startNoise)<=0.1
            end
            
            %- make the screen gray
            Screen(w, 'FillRect', gray);
            [~,startgray2]=Screen(w, 'Flip');
%             Trial.Noise_duration(trial)=startgray2-startNoise;
            %         key3=zeros(size(KeyCode));
            %         key2=zeros(size(KeyCode));
            %         endrt2=0;
            %                 [KeyIsDown, endrt, KeyCode]=KbCheck;
            %                 while ( KeyCode(GO)==0 && KeyCode(NOGO)==0)
            %                     [KeyIsDown, endrt, KeyCode]=KbCheck;
            %                     key1=KeyCode;
            %                     WaitSecs(0.001);
            %                 end
            WaitSecs(1);
            
            %             str2=sprintf('Type the name of the object \n');
            %             message = [str2 '...'];
            %             DrawFormattedText(w, message, 'center', 'center', WhiteIndex(w));
            %             % Update the display to show the instruction text:
            %             Screen('Flip', w);
            %             nameTyped=GetString('useKbCheck'==1);
            %             DrawFormattedText(sprintf('\n your response is:%s',nameTyped));
            %             DrawFormattedText(sprintf('\n press mouse button to continue %s',nameTyped));
            
            typedName=Ask(w,'Type the name of the object you saw, then press enter   ',[],[],'GetChar','center','center',[]);
            %             typedName = GetString('useKbCheck'==1)
           stimuli(o).response=typedName;
            % make the screen gray
            Screen(w, 'FillRect', gray);
            [~,startgray1]=Screen(w, 'Flip');
            %             Trial.Stimulus_duration(trial)=startgray1-startgray1;
%             str1='\n press mouse button to continue ';
%             message=[str1 '...'];
%             DrawFormattedText(w, message, 'center', 'center', WhiteIndex(w));
%             
%             while (GetSecs - startgray1)<=0.02
%             end
            
            %             % Wait for mouse click:
            %             GetClicks(w);
            
            
            WaitSecs(1);
        end
        
    end % for trial loop
    
    Screen('CloseAll');
    ShowCursor;
    fclose('all');
    Priority(0);
    % End of experiment:
    return;
catch
    
    
    % Do same cleanup as at the end of a regular session...
    Screen('CloseAll');
    ShowCursor;
    fclose('all');
    Priority(0);
    
    % Output the error message that describes the error:
    psychrethrow(psychlasterror);
end % try ... catch %
