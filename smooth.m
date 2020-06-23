%% Smoothing script after preprocessing: 4mm smoothing in SPM
% $ matlab_sub --walltime 01:00:00 --mem 4gb ./scripts/smooth.m
% -- check time and mem based on how many subjects
% processed serially (about 15 min per subject)
%clear all
fmriprepdir = '/project/3011226.01/bids/derivatives/fmriprep/';
smoothdir = '/project/3011226.01/bids/derivatives/SPM/smooth/';


%% Find which subjects have been preprocessed and need smoothing
% find all the preprocessed folders - check that preprocessed files have
% been unzipped
preproc_files = dir([fmriprepdir 'sub-*']);
% Get a logical vector that tells which is a directory.
flags = [preproc_files.isdir];
% Extract only those that are directories.
preproc_folders = preproc_files(flags);

% find all the smoothed folders
sm_files = dir([smoothdir 'sub*']);
flags = [sm_files.isdir];
sm_folders = sm_files(flags);
% find which folders include smoothed files
count = 1;
smoothed_subj = {};
for i=1:size(sm_folders,1)
    smoothfiles = dir([smoothdir sm_folders(i).name '/*.nii']);
    if size(smoothfiles,1)>0
        smoothed_subj{count} = sm_folders(i).name;
        count=count+1;
    end
end

% find subjects for which preprocessing has been done and smoothing hasn't
% been done
preproc_subj = {};
count=1;
for i=1:size(preproc_folders,1)
    preprocfiles = dir(['/project/3011226.01/bids/derivatives/fmriprep/' preproc_folders(i).name '/ses-mri01/func/*preproc_bold.nii']);
    if size(preprocfiles,1)>0 && sum(strcmp(smoothed_subj, preproc_folders(i).name)) == 0
        preproc_subj{count} = preproc_folders(i).name;
        count=count+1;
    end
end
preproc_subj % to check in output that correct subject(s) done

%% Run smoothing for those subjects

for i = 1:size(preproc_subj,2)    
%isubj = id;
%function [] = smooth(isubj)
   
    subj = preproc_subj{i}
    %subj = sprintf('%02d', isubj);
    preprocdir = [fmriprepdir subj '/ses-mri01/func/'];
    addpath('/home/common/matlab/spm12/')
    
    %run 1
    spm('defaults','fmri');
    spm_jobman('initcfg');
    
    % add all the volumes to the batch 
    files=dir([preprocdir '*-preproc_bold.nii']);
    n_files=size(files,1);
    count=1;
    for iruns = 1:n_files
        for n=6:210
            vol = num2str(n);
            voladd = [',' vol];
            temp = {preprocdir, files(iruns).name, voladd};
            matlabbatch{1}.spm.spatial.smooth.data{count,1} = horzcat(temp{:});
            count = count+1;
        end
    end
    % smoothing parameters
    matlabbatch{1}.spm.spatial.smooth.fwhm = [4 4 4];
    matlabbatch{1}.spm.spatial.smooth.dtype = 0;
    matlabbatch{1}.spm.spatial.smooth.im = 1;
    matlabbatch{1}.spm.spatial.smooth.prefix = 's';
    
    spm_jobman('run',matlabbatch);
    
    % move files from preproc directory to smoothing directory
    movefile([preprocdir 'ssub*'],[smoothdir subj '/']);
    clear matlabbatch
end
