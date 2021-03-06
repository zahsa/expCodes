stimpath='C:\Users\Zahra\Documents\ZDoc\IPM project\experiment stimulus';

AssertOpenGL;
NOISE=imresize(imread(strcat(stimpath,'\',char('Noise.jpg'))),[256 256]);
KbName('UnifyKeyNames');
try
    screens=Screen('Screens');
    screenNumber=max(screens);
    HideCursor;
    gray=GrayIndex(screenNumber);
    [w, wRect]=Screen('OpenWindow',screenNumber, gray);
    % Set priority for script execution to realtime priority:
    priorityLevel=MaxPriority(w);
    Priority(priorityLevel);
    str1=sprintf('Type the name of the object \n');
    str2=sprintf(' \n');
    message = ['test phase ...\n' str1 str2 '... press mouse button to begin ...'];
    %     DrawFormattedText(w, message, 'center', 'center', WhiteIndex(w));
    
    
    % Update the display to show the instruction text:
    %     Screen('Flip', w);
    
    % Wait for mouse click:
    %     GetClicks(w);
    
    %     Screen('Flip', w);
    
    WaitSecs(1.000);
    %     objname=dir(stimpath);
    %     objname(1)=[];
    %     objname(1)=[];
    %
    %     for i=1:size(objname,1)
    %         aa(i)=str2num(objname(i).name(1:end-4));
    %     end
    %
    %     aa=[aa ; 1:size(aa,2)];
    %     aa=aa';
    %     B = sortrows(aa,1);
    %     Flag=objname;
    %     for i=1:size(objname,1)
    %         Flag(i)=objname(B(i,2));
    %     end
    %     objname=Flag;
    %     objnumber=1:size(objname,1);
    %     objtype=ones(1,size(objname,1));
    %     for i=1:size(objtype,2)
    %         objtype(i)=1;
    %     end
    
    ntrials=1;
    randomorder1=randperm(ntrials);     % randperm() is a matlab function  3 yani tedate frame ha
    TT=randperm(ntrials);
    for trial=1:ntrials
        if (trial==floor(ntrials/3) || trial == floor(ntrials*2/3))
            str2=sprintf('Take a rest \n');
            str3=sprintf('5 Minutes \n');
            message = [str2 str3 '... press mouse button to continue ...'];
            DrawFormattedText(w, message, 'center', 'center', WhiteIndex(w));
            % Update the display to show the instruction text:
            Screen('Flip', w);
            
            % Wait for mouse click:
            GetClicks(w);
            WaitSecs(2);
            
        end    % read stimulus image into matlab matrix 'imdata':
        
        %         a=[objname((TT(trial))).name];
        %         CollNum=str2num(a(1:end-4));
        
        imglist=dir(stimpath);
        for l=1:length(imglist)
            if ~strcmp(imglist(l).name,'.') && ~strcmp(imglist(l).name,'..')
                
                stimfilename=strcat([stimpath '\' ],imglist(l).name); % assume stims are in subfolder "stims"
                imdata=(imresize((imread(char(stimfilename))),[256 256]));
                
                %             kk=imdata-min(min(imdata));
                %             kkk=kk*(256/max(max(kk)))
                %             imdata=kkk;
                centx = wRect(3)/2;
                centy = wRect(4)/2;
                fixationArea = [centx-5, centy-5, centx+5, centy+5];
                Screen('FillOval', w, [0 255 0], fixationArea);
                Screen('Flip',w);
                % Fixation presentation
                WaitSecs(1);
                
                
                % %         [KeyIsDown, endrt, KeyCode]=KbCheck;
                 Screen('PutImage', w, imdata);
%                  Screen('Flip',w);
%         
%                 tex=Screen('MakeTexture', w, imdata);
%                 
%                 Screen('DrawTexture', w, tex);
                
                [~, startstim]=Screen('Flip', w);
                
                while (GetSecs - startstim)<=0.02
                end
                
                Screen(w, 'FillRect', gray);
                [~,startgray1]=Screen(w, 'Flip');
                Trial.Stimulus_duration(trial)=startgray1-startstim;
                while (GetSecs - startgray1)<=0.02
                end
                
                tex=Screen('MakeTexture', w, NOISE);
                Screen('DrawTexture', w, tex);
                [~, startNoise]=Screen('Flip', w);
                Trial.gary_duration1(trial)=startNoise-startgray1;
                while (GetSecs - startNoise)<=0.1
                end
                % ---------------------------------------------------------------------
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
            end
        end
    end % for trial loop
    
    
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
