%-----------------------------------------------------------------------
% sample script for a group one-sample t-test analysis based on individual
% contrast images testing for effects at first-level

clear all
addpath('/home/common/matlab/spm12/')
cd /project/3011226.01/scripts/

firstleveldir = '/project/3011226.01/bids/derivatives/SPM/firstlevel/';
subjectlist = [1 2 4 7 8 9 10 11 12 14 15 16 17 18 19 20 21 22 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 46];

%onesample_tests = {'me_mod_PC','me_mod_CP','me_str_SE-NP','me_str_NP-SE','me_se_SE-SC','me_se_SC-SE','int_gra_PC','int_gra_CP','int_se_PC','int_se_CP'};
%onesample_tests = {'prod_gradient', 'comp_gradient', 'prod_embedding','comp_embedding'}
onesample_tests = {'me_const_size', 'int_size_PC','int_size_CP','ME PC', 'ME CP','prod const size', 'comp const size',}

for t = 1:length(onesample_tests)
    test = onesample_tests(t)
    
    spm('defaults','fmri');
    spm_jobman('initcfg'); 
    %options are: (folder names for each contrast image)
    % 41: me_mod_PC, 
    % 42: me_mod_CP, 
    % 43: me_str_SE-NP, 
    % 44: me_str_NP-SE,
    % 45: me_se_SE-SC, 
    % 46: me_se_SC-SE, 
    % 47: int_gra_PC, 
    % 48: int_gra_CP, 
    % 49: int_se_PC, 
    % 50: int_se_CP
    %matlabbatch{1}.spm.stats.factorial_design.dir = {['/project/3011226.01/bids/derivatives/SPM/group/' test{1,1} '/']};
    mkdir(['/project/3011226.01/bids/derivatives/SPM/group_correct/' test{1,1} ])
    
%     if t>2
%         c = t+3
%     else 
%         c = t
%     end
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
%% estimate

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