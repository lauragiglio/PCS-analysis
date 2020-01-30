%% specify first level for PRODUCTION and COMPREHENSION runs
% organised in 8 sessions corresponding to each run
function [] = specify_first_level_combined_FAST(s)
%clear all

addpath('/home/common/matlab/spm12/')
smoothdir = '/project/3011226.01/bids/derivatives/SPM/smooth/';
%firstleveldir = '/project/3011226.01/bids/derivatives/SPM/fast/';
firstleveldir = '/project/3011226.01/bids/derivatives/SPM/firstlevel/';

%s = 1 %subject number
subj = ['sub-0' sprintf('%02d', s)];

spm('defaults','fmri');
spm_jobman('initcfg'); 

%% define batch
matlabbatch{1}.spm.stats.fmri_spec.dir = {[firstleveldir subj '/prod_comp']};
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 1.5;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;

%% production
% loop over production runs to create each prod session
if s == 46
    nrun = 7;
else
    nrun = 8;
end
for i = 1:nrun
    if s==29 && i==8 %ignore run 1 for subj 29 because of too many errors
    else
        
        if s==29
            run = int2str(i+1);
        elseif s==46 && i > 4 % exclude missing run 5 (wrong phase enc)
            run = int2str(i+1);
        else
            run = int2str(i);
        end
    
     
    
    % add scans for each run, indicating each volume to be considered
    if s == 1 && i == 1 || s == 10 && i == 1 || s==31 && i==1
        files=dir(strcat(smoothdir, subj, '/*Production', run ,'_acq-epi_run-2_space-MNI152NLin2009cAsym_desc-preproc_bold.nii'));
    else
        files=dir(strcat(smoothdir, subj, '/*Production', run ,'*-preproc_bold.nii'));
    end
   
    count=1;
    for n=6:210
        vol = num2str(n);
        voladd = [',' vol];
        temp = {smoothdir, subj, '/', files.name, voladd};
        matlabbatch{1}.spm.stats.fmri_spec.sess(i).scans{count,1} = horzcat(temp{:});
        count = count+1;
    end
    
    % specify condition .mat file and nuisance regressors .txt file
    matlabbatch{1}.spm.stats.fmri_spec.sess(i).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(i).multi = {[firstleveldir subj '/P' run '.mat']};
    matlabbatch{1}.spm.stats.fmri_spec.sess(i).regress = struct('name', {}, 'val', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(i).multi_reg = {[firstleveldir subj '/R' run '.txt']};
    matlabbatch{1}.spm.stats.fmri_spec.sess(i).hpf = 128;

    end
end

%% comprehension
if s == 2 || s==46
    n_runs = 3;
else
    n_runs = 4;
end

prod_runs = size(matlabbatch{1,1}.spm.stats.fmri_spec.sess,2) %sessions already present in design matrix

% loop over comprehension runs to create each session
for i = 1:n_runs
    if s == 2 && i == 3
        run = int2str(i+1); %esclude session 3 in subj 2 because too short - not enough trials per cond
    elseif s==46 && i == 3 % run 3 in wrong phase enc
        run = int2str(i+1);
    else 
        run = int2str(i);
    end
    
    
    % add scans for each run, indicating each volume to be considered
    files=dir(strcat(smoothdir,subj, '/*Comprehension', run ,'*-preproc_bold.nii'));    
    count=1;
    
    if s == 3 && i == 4 % to account for Presentation error in subj 2 and 3 due to buffer
        n_scans = 167;
    else
        n_scans = 210;
    end
   
    for n=6:n_scans
        vol = num2str(n);
        voladd = [',' vol];
        temp = {smoothdir, subj, '/', files.name, voladd};
        matlabbatch{1}.spm.stats.fmri_spec.sess(i+prod_runs).scans{count,1} = horzcat(temp{:});
        count = count+1;
    end
    
    % specify condition .mat file and nuisance regressors .txt file
    matlabbatch{1}.spm.stats.fmri_spec.sess(i+prod_runs).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(i+prod_runs).multi = {[firstleveldir subj '/C' run '.mat']};
    matlabbatch{1}.spm.stats.fmri_spec.sess(i+prod_runs).regress = struct('name', {}, 'val', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(i+prod_runs).multi_reg = {[firstleveldir subj '/RC' run '.txt']};
    matlabbatch{1}.spm.stats.fmri_spec.sess(i+prod_runs).hpf = 128;


end

%% common
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [1 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'FAST';

% run job
spm_jobman('run',matlabbatch);


end
