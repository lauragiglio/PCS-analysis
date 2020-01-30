%% Script to create task regressors for first-level analysis in SPM
% Laura Giglio
% output is .mat file as required in SPM
% for s>03 first run logfile.py to make logfile compatible with this script
function [] = task_regressors(s)
%clear all
%cd '/project/3011226.01/'

%% Find coded subjects for who task regressors haven't been created

% find number of subjects for who behavioural coding has been done
%coded_subjs = dir('/project/3011226.01/behavioural/s*');
%subdirs =([files.isdir]);
%coded_subjs = subdirs(startsWith(subdirs, "s"))
%fl_files = dir('/project/3011226.01/bids/derivatives/SPM/first_level/sub-0*')
%count = 1;
%for i = 1:size(coded_subjs,1)
%    task_files = dir(['/project/3011226.01/bids/derivatives/SPM/first_level/' coded_subjs(i).name 'P*.mat']);
%    if size(task_files,1) == 0
%        task_subj{count} = coded_subjs(i).name;
%        count=count+1;
%   end
%end

%% Create .mat files including conditions times durations etc for PRODUCTION
% loop over task subjects to create conditions .mat files
%for s = 1:size(task_subj,2) % to apply whenever coding is actually done
    %sub = task_subj{s};
    %subj = sub(2:3)

    %s = 2 %define here
    subj = sprintf('%02d', s);
    
    behavdir = ['/project/3011226.01/behavioural/s' subj '/'];
    preprocdir = ['/project/3011226.01/bids/derivatives/fmriprep/sub-0' subj '/ses-mri01/func/'];
    firstleveldir = ['/project/3011226.01/bids/derivatives/SPM/firstlevel/'];
    
    mkdir(strcat(firstleveldir, 'sub-0', subj, '/'))
           
    nruns = 8;
    
    % centre parametric modulations (onset times)
    % duration is coded as the offset of speaking: after praat coding
    onset_times = [];
    for i=1:nruns
        run_n = string(i);
        P_duration = readtable(strcat(behavdir, run_n, "/filtered/onsets_durationAutomatic.txt"), 'Delimiter', '\t');
        % need to sort durations after praat's weird ordering
        Ponsets = P_duration.Var2;
        P_duration.Var5 = str2double(P_duration.Var5);
        for i = 1:40
            P{i} = strsplit(Ponsets{i}, '_');
            P_duration.Var5(i) = str2double(P{i}{3});
        end
        P_duration = sortrows(P_duration, 5);
        onset_times = [onset_times; P_duration.Var3];
    end
    mean_onset = mean(onset_times);
    
    for i = 1:nruns
        clear names
        clear onsets
        clear durations
       
        run_n = string(i)
        
        % import presentation logfile with time of trials
        if s < 4           
            Prun = readtable(strcat(behavdir, subj, "_", run_n, "_P_logfile.txt"));
        else
            Prun = readtable(strcat(behavdir, subj, "_", run_n, "_P.csv"));
        end
        
        list_run = Prun.List_Run{1} % find which list was used for this run - the list includes accuracy coding
            
        % import list with accuracy coding
        P_acc = readtable(strcat(behavdir, list_run, ".txt"));

        % if trial was wrong it is re-coded to error and not included in the
        % analysis
        for t = 1:size(P_acc,1)
            if P_acc.Accuracy2(t) ~= 1
                Prun.Condition{t} = 'ERR';
            end
        end
        
        if sum(strcmp(Prun.Condition,'ERR')) == 0
            names = cell(1,4);
            onsets = cell(1,4);
            durations = cell(1,4); 
        else
        % create and fill in .mat file to be used in SPM first-level analysis
            names = cell(1,5);
            onsets = cell(1,5);
            durations = cell(1,5);
        end

        names{1} = 'NP';
        names{2} = 'SC';
        names{3} = 'SE';
        names{4} = 'FIL';
        
        
        onsets{1} = Prun.PictureOnset(find(strcmp(Prun.Condition,'NP')))/1000; %correct for millisecond unit from presentation
        onsets{2} = Prun.PictureOnset(find(strcmp(Prun.Condition,'SC')))/1000;
        onsets{3} = Prun.PictureOnset(find(strcmp(Prun.Condition,'SE')))/1000;
        onsets{4} = Prun.PictureOnset(find(strcmp(Prun.Condition,'FIL')))/1000;
        
        
        % duration is coded as the offset of speaking: after praat coding
        P_duration = readtable(strcat(behavdir, run_n, "/filtered/onsets_durationAutomatic.txt"), 'Delimiter', '\t');
        % need to sort durations after praat's weird ordering
        Ponsets = P_duration.Var2;
        P_duration.Var5 = str2double(P_duration.Var5);
        for i = 1:40
            P{i} = strsplit(Ponsets{i}, '_');
            P_duration.Var5(i) = str2double(P{i}{3});
        end
        P_duration = sortrows(P_duration, 5);
        
        durations{1} = P_duration.Var4(find(strcmp(Prun.Condition,'NP')));
        durations{2} = P_duration.Var4(find(strcmp(Prun.Condition,'SC')));
        durations{3} = P_duration.Var4(find(strcmp(Prun.Condition,'SE')));
        durations{4} = P_duration.Var4(find(strcmp(Prun.Condition,'FIL')));
        
        
        if sum(strcmp(Prun.Condition,'ERR')) > 0
            names{5} = 'ERR';
            onsets{5} = Prun.PictureOnset(find(strcmp(Prun.Condition,'ERR')))/1000;
            durations{5} = P_duration.Var4(find(strcmp(Prun.Condition,'ERR')));
        end
        
        pmod = struct('name',{''},'param',{},'poly',{});
        pmod(1).name{1}  = 'NPonset';
        pmod(1).param{1} = P_duration.Var3(find(strcmp(Prun.Condition,'NP'))) - mean_onset;
        pmod(1).poly{1}  = 1;               
        pmod(2).name{1}  = 'SConset';
        pmod(2).param{1} = P_duration.Var3(find(strcmp(Prun.Condition,'SC'))) - mean_onset;
        pmod(2).poly{1}  = 1;
        pmod(3).name{1}  = 'SEonset';
        pmod(3).param{1} = P_duration.Var3(find(strcmp(Prun.Condition,'SE'))) - mean_onset;
        pmod(3).poly{1}  = 1;        
        pmod(4).name{1}  = 'FILonset';
        pmod(4).param{1} = P_duration.Var3(find(strcmp(Prun.Condition,'FIL'))) - mean_onset;
        pmod(4).poly{1}  = 1;

      
        
        
        save(strcat(firstleveldir,'sub-0', subj, '/', 'P', run_n, '.mat'), 'names','onsets','durations','pmod')
        
          
    end
%end

%% Create .mat files including conditions times durations etc for COMPREHENSION
% loop over task subjects to create conditions .mat files

%for s = 1:size(task_subj,2) 
    %sub = task_subj{s};
    %subj = sub(2:3)
    
    %s = 2 % define here
    subj = sprintf('%02d', s);
    
    behavdir = ['/project/3011226.01/behavioural/s' subj '/'];
    preprocdir = ['/project/3011226.01/bids/derivatives/fmriprep/sub-0' subj '/ses-mri01/func/'];
    firstleveldir = ['/project/3011226.01/bids/derivatives/SPM/firstlevel/'];
    

    %mkdir(strcat(firstleveldir, 'sub-0', subj, '/'))
           
    nruns = 4;
    for i = 1:nruns
        clear names
        clear onsets
        clear durations
        clear pmod
        run_n= string(i);
        
        % import presentation logfile with time of trials
        if s < 4           
            Crun = readtable(strcat(behavdir, subj, "_", run_n, "_C_logfile.txt"));
        else
            Crun = readtable(strcat(behavdir, subj, "_", run_n, "_C.csv"));
        end
        
        list_run = Crun.List_Run{1} % find which list was used for this run - the list includes accuracy coding
        list_comp = list_run(2);
        
%         if subj == '03' % to correct for wrong trials
%             % import list with accuracy coding
%             C_acc = readtable(strcat('/project/3011226.01/behavioural/', list_run, '.txt'));
% 
%             % if trial was wrong it is re-coded to error and not included in the
%             % analysis
%             for t = 1:size(C_acc,1)
%                 if C_acc.Accuracy(t) ~= 1
%                     Crun.Condition{t} = 'ERR';
%                 end
%             end
%         end

        % create and fill in .mat file to be used in SPM first-level analysis
        names = cell(1,4);
        onsets = cell(1,4);
        durations = cell(1,4);

        names{1} = 'NP';
        names{2} = 'SC';
        names{3} = 'SE';
        names{4} = 'FIL';

        onsets{1} = Crun.PictureOnset(find(strcmp(Crun.Condition,'NP')))/1000; %correct for millisecond unit from presentation
        onsets{2} = Crun.PictureOnset(find(strcmp(Crun.Condition,'SC')))/1000;
        onsets{3} = Crun.PictureOnset(find(strcmp(Crun.Condition,'SE')))/1000;
        onsets{4} = Crun.PictureOnset(find(strcmp(Crun.Condition,'FIL')))/1000;
        
        C_duration = readtable(strcat('/project/3011226.01/behavioural/list', list_comp, '_comp_durations.txt'));
        markersNP = Crun.Sentence_nr(find(strcmp(Crun.Condition,'NP')));
        markersSC = Crun.Sentence_nr(find(strcmp(Crun.Condition,'SC')));
        markersSE = Crun.Sentence_nr(find(strcmp(Crun.Condition,'SE')));
        markersFIL = Crun.Sentence_nr(find(strcmp(Crun.Condition,'FIL')));

        
        durations{1} = C_duration.Duration(markersNP);
        durations{2} = C_duration.Duration(markersSC);
        durations{3} = C_duration.Duration(markersSE);
        durations{4} = C_duration.Duration(markersFIL);
%         
%         pmod = struct('name',{''},'param',{},'poly',{});
%         pmod(1).name{1}  = 'NPonset';
%         pmod(1).param{1} = ones(size(onsets{1},1),1);
%         pmod(1).poly{1}  = 1;               
%         pmod(2).name{1}  = 'SConset';
%         pmod(2).param{1} = ones(size(onsets{2},1),1);
%         pmod(2).poly{1}  = 1;
%         pmod(3).name{1}  = 'SEonset';
%         pmod(3).param{1} = ones(size(onsets{3},1),1);
%         pmod(3).poly{1}  = 1;        
%         pmod(4).name{1}  = 'FILonset';
%         pmod(4).param{1} = ones(size(onsets{4},1),1);
%         pmod(4).poly{1}  = 1;
%         if sum(strcmp(Prun.Condition,'ERR')) > 0
%             pmod(5).name{1}  = 'ERRonset';
%             pmod(5).param{1} = P_duration.Var3(find(strcmp(Prun.Condition,'ERR')));
%             pmod(5).poly{1}  = 1;
%         end
        
        
        save(strcat(firstleveldir,'sub-0', subj, '/', 'C', run_n, '.mat'), 'names','onsets','durations')
        
        
    end
end

    
