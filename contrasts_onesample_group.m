addpath('/home/common/matlab/spm12/')
firstleveldir = '/project/3011226.01/bids/derivatives/SPM/firstlevel/';
%s = 1 %subject number
subj = ['sub-0' sprintf('%02d', s)];

%onesample_tests = {'me_mod_PC','me_mod_CP','me_str_SE-NP','me_str_NP-SE','me_se_SE-SC','me_se_SC-SE','int_gra_PC','int_gra_CP','int_se_PC','int_se_CP'};
%onesample_tests = {'prod_gradient', 'comp_gradient', 'prod_embedding','comp_embedding'}
%onesample_tests = {'prod const size', 'comp const size', 'me_const_size', 'int_size_PC','int_size_CP'}
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