%% SPM GLM pipeline following smoothing
% Laura Giglio

% script to run all of the analysis from specification of first-level
% design matrix to final results at second level
% need smoothed preprocessed files (unzip them first)
% next step is ROI analysis

%% First-level analysis pipeline

clear all

cd /project/3011226.01/scripts/

subjectlist = [1 2 4 7 8 9 10 11 12 14 15 16 17 18 19 20  21 22 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 46]; 

for s = subjectlist

task_regressors_corrected(s)
    
specify_first_level_combined_FAST(s)

estimate_first_level_combined(s)

contrast_weights(s) 

end

%% Second-level one sample t-tests

% run: one_sample_job.m or following

% group one-sample t-test analysis based on individual
% contrast images testing for effects at first-level

%% specify second-level for each contrasts image 
clear all
addpath('/home/common/matlab/spm12/')
cd /project/3011226.01/scripts/

firstleveldir = '/project/3011226.01/bids/derivatives/SPM/firstlevel/';
subjectlist = [1 2 4 7 8 9 10 11 12 14 15 16 17 18 19 20 21 22 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 46];

onesample_tests = {'me_const_size', 'int_size_PC','int_size_CP','ME PC', 'ME CP','prod const size', 'comp const size',}

for t = 1:length(onesample_tests)
    test = onesample_tests(t)
    
    spm('defaults','fmri');
    spm_jobman('initcfg'); 
    mkdir(['/project/3011226.01/bids/derivatives/SPM/group_correct/' test{1,1} ])
    
    matlabbatch{1}.spm.stats.factorial_design.dir = {['/project/3011226.01/bids/derivatives/SPM/group_correct/' test{1,1} '/']};
    for i = 1:length(subjectlist)
        s = subjectlist(i);
        subj = ['sub-0' sprintf('%02d', s)];
        matlabbatch{1}.spm.stats.factorial_design.des.t1.scans(i,1) = {[firstleveldir subj '/prod_comp/con_000' int2str(t) '.nii,1']};
    end

    matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
    matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
    matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
    matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
    matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
    matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
    matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
    matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;

    spm_jobman('run',matlabbatch);
    
    clear matlabbatch
end
%% estimate one-sample t-tests

for t = 1:length(onesample_tests)
    test = onesample_tests(t)

spm('defaults','fmri');
spm_jobman('initcfg'); 

matlabbatch{1}.spm.stats.fmri_est.spmmat = {['/project/3011226.01/bids/derivatives/SPM/group_correct/' test{1,1} '/SPM.mat']};
matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;

% run job
spm_jobman('run',matlabbatch);
end

%% contrasts one-sample t-test

% run contrasts_onesample_group.m 
% or use results in spm gui
% or following

onesample_tests = {'me_const_size', 'int_size_PC','int_size_CP','ME PC', 'ME CP','prod const size', 'comp const size',}
for t = 1:length(onesample_tests)
    test = onesample_tests(t)

    spm('defaults','fmri');
    spm_jobman('initcfg');
    
    matlabbatch{1}.spm.stats.con.spmmat = {['/project/3011226.01/bids/derivatives/SPM/group_corrected/' test{1,1} '/SPM.mat']};
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = test{1,1};
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = 1;
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
    % run job
    spm_jobman('run',matlabbatch);
end

%% ROI analysis

% run ROIanalysis_marsbar.m
