%-----------------------------------------------------------------------
% Job saved on 29-Nov-2019 19:09:22 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7487)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------

%% define contrasts for production/comprehension runs
function [] = contrasts_combined(s)
% s = subject number
%  

addpath('/home/common/matlab/spm12/')
firstleveldir = '/project/3011226.01/bids/derivatives/SPM/firstlevel/';
%s = 1 %subject number
subj = ['sub-0' sprintf('%02d', s)];


spm('defaults','fmri');
spm_jobman('initcfg'); 

matlabbatch{1}.spm.stats.con.spmmat = {[firstleveldir subj '/prod_comp/SPM.mat']};

matlabbatch{1}.spm.stats.con.consess{1}.tconsess.name = 'NP_P';
matlabbatch{1}.spm.stats.con.consess{1}.tconsess.coltype.colconds.conweight = 1;
matlabbatch{1}.spm.stats.con.consess{1}.tconsess.coltype.colconds.colcond = 1;
matlabbatch{1}.spm.stats.con.consess{1}.tconsess.coltype.colconds.colbf = 1;
matlabbatch{1}.spm.stats.con.consess{1}.tconsess.coltype.colconds.colmod = 1;
matlabbatch{1}.spm.stats.con.consess{1}.tconsess.coltype.colconds.colmodord = 0;
matlabbatch{1}.spm.stats.con.consess{1}.tconsess.sessions = [1 2 3 4 5 6 7 8];
matlabbatch{1}.spm.stats.con.consess{2}.tconsess.name = 'SC_P';
matlabbatch{1}.spm.stats.con.consess{2}.tconsess.coltype.colconds.conweight = 1;
matlabbatch{1}.spm.stats.con.consess{2}.tconsess.coltype.colconds.colcond = 2;
matlabbatch{1}.spm.stats.con.consess{2}.tconsess.coltype.colconds.colbf = 1;
matlabbatch{1}.spm.stats.con.consess{2}.tconsess.coltype.colconds.colmod = 1;
matlabbatch{1}.spm.stats.con.consess{2}.tconsess.coltype.colconds.colmodord = 0;
matlabbatch{1}.spm.stats.con.consess{2}.tconsess.sessions = [1 2 3 4 5 6 7 8];
matlabbatch{1}.spm.stats.con.consess{3}.tconsess.name = 'SE_P';
matlabbatch{1}.spm.stats.con.consess{3}.tconsess.coltype.colconds.conweight = 1;
matlabbatch{1}.spm.stats.con.consess{3}.tconsess.coltype.colconds.colcond = 3;
matlabbatch{1}.spm.stats.con.consess{3}.tconsess.coltype.colconds.colbf = 1;
matlabbatch{1}.spm.stats.con.consess{3}.tconsess.coltype.colconds.colmod = 1;
matlabbatch{1}.spm.stats.con.consess{3}.tconsess.coltype.colconds.colmodord = 0;
matlabbatch{1}.spm.stats.con.consess{3}.tconsess.sessions = [1 2 3 4 5 6 7 8];
matlabbatch{1}.spm.stats.con.consess{4}.tconsess.name = 'NP_C';
matlabbatch{1}.spm.stats.con.consess{4}.tconsess.coltype.colconds.conweight = 1;
matlabbatch{1}.spm.stats.con.consess{4}.tconsess.coltype.colconds.colcond = 1;
matlabbatch{1}.spm.stats.con.consess{4}.tconsess.coltype.colconds.colbf = 1;
matlabbatch{1}.spm.stats.con.consess{4}.tconsess.coltype.colconds.colmod = 1;
matlabbatch{1}.spm.stats.con.consess{4}.tconsess.coltype.colconds.colmodord = 0;
matlabbatch{1}.spm.stats.con.consess{4}.tconsess.sessions = [9 10 11 12];
matlabbatch{1}.spm.stats.con.consess{5}.tconsess.name = 'SC_C';
matlabbatch{1}.spm.stats.con.consess{5}.tconsess.coltype.colconds.conweight = 1;
matlabbatch{1}.spm.stats.con.consess{5}.tconsess.coltype.colconds.colcond = 2;
matlabbatch{1}.spm.stats.con.consess{5}.tconsess.coltype.colconds.colbf = 1;
matlabbatch{1}.spm.stats.con.consess{5}.tconsess.coltype.colconds.colmod = 1;
matlabbatch{1}.spm.stats.con.consess{5}.tconsess.coltype.colconds.colmodord = 0;
matlabbatch{1}.spm.stats.con.consess{5}.tconsess.sessions = [9 10 11 12];
matlabbatch{1}.spm.stats.con.consess{6}.tconsess.name = 'SE_C';
matlabbatch{1}.spm.stats.con.consess{6}.tconsess.coltype.colconds.conweight = 1;
matlabbatch{1}.spm.stats.con.consess{6}.tconsess.coltype.colconds.colcond = 3;
matlabbatch{1}.spm.stats.con.consess{6}.tconsess.coltype.colconds.colbf = 1;
matlabbatch{1}.spm.stats.con.consess{6}.tconsess.coltype.colconds.colmod = 1;
matlabbatch{1}.spm.stats.con.consess{6}.tconsess.coltype.colconds.colmodord = 0;
matlabbatch{1}.spm.stats.con.consess{6}.tconsess.sessions = [9 10 11 12];
matlabbatch{1}.spm.stats.con.consess{7}.tconsess.name = 'SE>SC_P';
matlabbatch{1}.spm.stats.con.consess{7}.tconsess.coltype.colconds(1).conweight = -1;
matlabbatch{1}.spm.stats.con.consess{7}.tconsess.coltype.colconds(1).colcond = 2;
matlabbatch{1}.spm.stats.con.consess{7}.tconsess.coltype.colconds(1).colbf = 1;
matlabbatch{1}.spm.stats.con.consess{7}.tconsess.coltype.colconds(1).colmod = 1;
matlabbatch{1}.spm.stats.con.consess{7}.tconsess.coltype.colconds(1).colmodord = 0;
matlabbatch{1}.spm.stats.con.consess{7}.tconsess.coltype.colconds(2).conweight = 1;
matlabbatch{1}.spm.stats.con.consess{7}.tconsess.coltype.colconds(2).colcond = 3;
matlabbatch{1}.spm.stats.con.consess{7}.tconsess.coltype.colconds(2).colbf = 1;
matlabbatch{1}.spm.stats.con.consess{7}.tconsess.coltype.colconds(2).colmod = 1;
matlabbatch{1}.spm.stats.con.consess{7}.tconsess.coltype.colconds(2).colmodord = 0;
matlabbatch{1}.spm.stats.con.consess{7}.tconsess.sessions = [1 2 3 4 5 6 7 8];
matlabbatch{1}.spm.stats.con.consess{8}.tconsess.name = 'NP_SC_SE_P';
matlabbatch{1}.spm.stats.con.consess{8}.tconsess.coltype.colconds(1).conweight = -1;
matlabbatch{1}.spm.stats.con.consess{8}.tconsess.coltype.colconds(1).colcond = 1;
matlabbatch{1}.spm.stats.con.consess{8}.tconsess.coltype.colconds(1).colbf = 1;
matlabbatch{1}.spm.stats.con.consess{8}.tconsess.coltype.colconds(1).colmod = 1;
matlabbatch{1}.spm.stats.con.consess{8}.tconsess.coltype.colconds(1).colmodord = 0;
matlabbatch{1}.spm.stats.con.consess{8}.tconsess.coltype.colconds(2).conweight = 1;
matlabbatch{1}.spm.stats.con.consess{8}.tconsess.coltype.colconds(2).colcond = 3;
matlabbatch{1}.spm.stats.con.consess{8}.tconsess.coltype.colconds(2).colbf = 1;
matlabbatch{1}.spm.stats.con.consess{8}.tconsess.coltype.colconds(2).colmod = 1;
matlabbatch{1}.spm.stats.con.consess{8}.tconsess.coltype.colconds(2).colmodord = 0;
matlabbatch{1}.spm.stats.con.consess{8}.tconsess.sessions = [1 2 3 4 5 6 7 8];
matlabbatch{1}.spm.stats.con.consess{9}.tconsess.name = 'SE>SC_C';
matlabbatch{1}.spm.stats.con.consess{9}.tconsess.coltype.colconds(1).conweight = -1;
matlabbatch{1}.spm.stats.con.consess{9}.tconsess.coltype.colconds(1).colcond = 2;
matlabbatch{1}.spm.stats.con.consess{9}.tconsess.coltype.colconds(1).colbf = 1;
matlabbatch{1}.spm.stats.con.consess{9}.tconsess.coltype.colconds(1).colmod = 1;
matlabbatch{1}.spm.stats.con.consess{9}.tconsess.coltype.colconds(1).colmodord = 0;
matlabbatch{1}.spm.stats.con.consess{9}.tconsess.coltype.colconds(2).conweight = 1;
matlabbatch{1}.spm.stats.con.consess{9}.tconsess.coltype.colconds(2).colcond = 3;
matlabbatch{1}.spm.stats.con.consess{9}.tconsess.coltype.colconds(2).colbf = 1;
matlabbatch{1}.spm.stats.con.consess{9}.tconsess.coltype.colconds(2).colmod = 1;
matlabbatch{1}.spm.stats.con.consess{9}.tconsess.coltype.colconds(2).colmodord = 0;
matlabbatch{1}.spm.stats.con.consess{9}.tconsess.sessions = [9 10 11 12];
matlabbatch{1}.spm.stats.con.consess{10}.tconsess.name = 'NP_SC_SE_C';
matlabbatch{1}.spm.stats.con.consess{10}.tconsess.coltype.colconds(1).conweight = -1;
matlabbatch{1}.spm.stats.con.consess{10}.tconsess.coltype.colconds(1).colcond = 1;
matlabbatch{1}.spm.stats.con.consess{10}.tconsess.coltype.colconds(1).colbf = 1;
matlabbatch{1}.spm.stats.con.consess{10}.tconsess.coltype.colconds(1).colmod = 1;
matlabbatch{1}.spm.stats.con.consess{10}.tconsess.coltype.colconds(1).colmodord = 0;
matlabbatch{1}.spm.stats.con.consess{10}.tconsess.coltype.colconds(2).conweight = 1;
matlabbatch{1}.spm.stats.con.consess{10}.tconsess.coltype.colconds(2).colcond = 3;
matlabbatch{1}.spm.stats.con.consess{10}.tconsess.coltype.colconds(2).colbf = 1;
matlabbatch{1}.spm.stats.con.consess{10}.tconsess.coltype.colconds(2).colmod = 1;
matlabbatch{1}.spm.stats.con.consess{10}.tconsess.coltype.colconds(2).colmodord = 0;
matlabbatch{1}.spm.stats.con.consess{10}.tconsess.sessions = [9 10 11 12];
matlabbatch{1}.spm.stats.con.delete = 0;

%only 3 comp runs in subj 2
if s==2
    for i=[4 5 6 9 10] %compr sessions
        matlabbatch{1}.spm.stats.con.consess{i}.tconsess.sessions = [9 10 11];
    end
elseif s==29 % only one prod run
    for i=[1 2 3 7 8]
        matlabbatch{1}.spm.stats.con.consess{i}.tconsess.sessions = [1 2 3 4 5 6 7];
    end
    for i=[4 5 6 9 10]
        matlabbatch{1}.spm.stats.con.consess{i}.tconsess.sessions = [8 9 10 11];
    end
elseif s==46
    for i=[1 2 3 7 8]
        matlabbatch{1}.spm.stats.con.consess{i}.tconsess.sessions = [1 2 3 4 5 6 7];
    end
    for i=[4 5 6 9 10]
        matlabbatch{1}.spm.stats.con.consess{i}.tconsess.sessions = [8 9 10];
    end
end


% run job
spm_jobman('run',matlabbatch);
end
