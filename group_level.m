%% Specify second-level
clear all
addpath('/home/common/matlab/spm12/')
cd /project/3011226.01/scripts/

firstleveldir = '/project/3011226.01/bids/derivatives/SPM/firstlevel/';
subjectlist = [1 2 4 7 8 9 10 11 12 14 15 16 17 18 19 20 21 22 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 46];


spm('defaults','fmri');
spm_jobman('initcfg'); 

matlabbatch{1}.spm.stats.factorial_design.dir = {'/project/3011226.01/bids/derivatives/SPM/group_fast'};
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).name = 'subject';
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).dept = 0; % 1 = no independence, 0 = independence
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).variance = 0; % equal variance for subjects
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).ancova = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).name = 'modality';
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).dept = 1;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).variance = 1; % unequal variance because different amount of blocks
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).ancova = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).name = 'structure';
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).dept = 1;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).variance = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).ancova = 0;

for i = 1:length(subjectlist)
    s = subjectlist(i);
    subj = ['sub-0' sprintf('%02d', s)];
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(i).scans = {
                                                                                  [firstleveldir subj '/prod_comp/con_0001.nii,1']
                                                                                  [firstleveldir subj '/prod_comp/con_0002.nii,1']
                                                                                  [firstleveldir subj '/prod_comp/con_0003.nii,1']
                                                                                  [firstleveldir subj '/prod_comp/con_0004.nii,1']
                                                                                  [firstleveldir subj '/prod_comp/con_0005.nii,1']
                                                                                  [firstleveldir subj '/prod_comp/con_0006.nii,1']
                                                                                  };
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(i).conds = [1 1
                                                                                  1 2
                                                                                  1 3
                                                                                  2 1
                                                                                  2 2
                                                                                  2 3];
end
matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{1}.fmain.fnum = 1;
%matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{2}.fmain.fnum = 2;
%matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{3}.fmain.fnum = 3;

matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{2}.inter.fnums = [2
                                                                                  3];
matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;

% run job
spm_jobman('run',matlabbatch);


%% estimate second-level (doesn't work, need to do in batch)

spm('defaults','fmri');
spm_jobman('initcfg'); 

matlabbatch{1}.spm.stats.fmri_est.spmmat = {'/project/3011226.01/bids/derivatives/SPM/grouplevel/SPM.mat'};
matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;

matlabbatch{1}.spm.stats.fmri_est.spmmat = {'/project/3011226.01/bids/derivatives/SPM/grouplevel/SPM.mat'};
matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;
%?????

% run job
spm_jobman('run',matlabbatch);
