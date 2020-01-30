%% Create task regressors for ICA-AROMA check
% Single SPM.mat file for each run
function [] = first_level_task_regressors(s)
%clear all
%s = 2 %number
subj = ['sub-0' sprintf('%02d', s)];
smoothdir = ['/project/3011226.01/bids/derivatives/SPM/smooth/' subj '/'];
behavdir = ['/project/3011226.01/behavioural/s', sprintf('%02d', s), '/'];
firstleveldir = ['/project/3011226.01/bids/derivatives/SPM/firstlevel/' subj '/']
addpath('/home/common/matlab/spm12/')

n_run = 8;
for i = 1:n_run
    run = int2str(i)
    if s==29 && run=='1' %not running for this session because of missing condition
    elseif s==46 && run=='5'
    else   
        spm('defaults','fmri');
        spm_jobman('initcfg');
        
        matlabbatch{1}.spm.stats.fmri_spec.dir = {[behavdir, run, '/']};
        matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
        matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 1.5;
        matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
        matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;
        if s == 1 && i == 1 || s == 10 && i == 1 || s == 31 && i == 1
            files=dir(strcat(smoothdir, '*Production', run ,'_acq-epi_run-2_space-MNI152NLin2009cAsym_desc-preproc_bold.nii'));
        else
            files=dir(strcat(smoothdir, '*Production', run ,'*-preproc_bold.nii'));
        end
        
        count=1;
        for n=6:210
            vol = num2str(n);
            voladd = [',' vol];
            temp = {smoothdir, files.name, voladd};
            matlabbatch{1}.spm.stats.fmri_spec.sess.scans{count,1} = horzcat(temp{:});
            count = count+1;
        end
        
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
        matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {[firstleveldir 'P' run '.mat']};
        matlabbatch{1}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
        matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {''};
        matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;
        matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
        matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
        matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
        matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
        matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
        matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
        matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
        
        spm_jobman('run',matlabbatch);
    end
end
end