%% Contrast weights specified singularly for each session to explore interaction with one-sample T-test at second-level 
%-----------------------------------------------------------------------
%-----------------------------------------------------------------------
function [] = contrast_weights(s)
% s = subject number
%  
addpath('/home/common/matlab/spm12/')
firstleveldir = '/project/3011226.01/bids/derivatives/SPM/firstlevel/';
%s = 1 %subject number
subj = ['sub-0' sprintf('%02d', s)];


spm('defaults','fmri');
spm_jobman('initcfg'); 

matlabbatch{1}.spm.stats.con.spmmat = {[firstleveldir subj '/prod_comp/SPM.mat']};

% load SPM design matrix for individual participants to find info about
% betas to be able to write contrasts
load([firstleveldir subj '/prod_comp/SPM.mat'])

%find condition and session specific betas
if size(SPM.Sess,2) == 12
    NP_P1 = find(strcmp(SPM.xX.name, 'Sn(1) NP*bf(1)'));
    NP_P2 = find(strcmp(SPM.xX.name, 'Sn(2) NP*bf(1)'));
    NP_P3 = find(strcmp(SPM.xX.name, 'Sn(3) NP*bf(1)'));
    NP_P4 = find(strcmp(SPM.xX.name, 'Sn(4) NP*bf(1)'));
    NP_P5 = find(strcmp(SPM.xX.name, 'Sn(5) NP*bf(1)'));
    NP_P6 = find(strcmp(SPM.xX.name, 'Sn(6) NP*bf(1)'));
    NP_P7 = find(strcmp(SPM.xX.name, 'Sn(7) NP*bf(1)'));
    NP_P8 = find(strcmp(SPM.xX.name, 'Sn(8) NP*bf(1)'));
    SC_P1 = find(strcmp(SPM.xX.name, 'Sn(1) SC*bf(1)'));
    SC_P2 = find(strcmp(SPM.xX.name, 'Sn(2) SC*bf(1)'));
    SC_P3 = find(strcmp(SPM.xX.name, 'Sn(3) SC*bf(1)'));
    SC_P4 = find(strcmp(SPM.xX.name, 'Sn(4) SC*bf(1)'));
    SC_P5 = find(strcmp(SPM.xX.name, 'Sn(5) SC*bf(1)'));
    SC_P6 = find(strcmp(SPM.xX.name, 'Sn(6) SC*bf(1)'));
    SC_P7 = find(strcmp(SPM.xX.name, 'Sn(7) SC*bf(1)'));
    SC_P8 = find(strcmp(SPM.xX.name, 'Sn(8) SC*bf(1)'));
    SE_P1 = find(strcmp(SPM.xX.name, 'Sn(1) SE*bf(1)'));
    SE_P2 = find(strcmp(SPM.xX.name, 'Sn(2) SE*bf(1)'));
    SE_P3 = find(strcmp(SPM.xX.name, 'Sn(3) SE*bf(1)'));
    SE_P4 = find(strcmp(SPM.xX.name, 'Sn(4) SE*bf(1)'));
    SE_P5 = find(strcmp(SPM.xX.name, 'Sn(5) SE*bf(1)'));
    SE_P6 = find(strcmp(SPM.xX.name, 'Sn(6) SE*bf(1)'));
    SE_P7 = find(strcmp(SPM.xX.name, 'Sn(7) SE*bf(1)'));
    SE_P8 = find(strcmp(SPM.xX.name, 'Sn(8) SE*bf(1)'));
    
    NP_C1 = find(strcmp(SPM.xX.name, 'Sn(9) NP*bf(1)'));
    NP_C2 = find(strcmp(SPM.xX.name, 'Sn(10) NP*bf(1)'));
    NP_C3 = find(strcmp(SPM.xX.name, 'Sn(11) NP*bf(1)'));
    NP_C4 = find(strcmp(SPM.xX.name, 'Sn(12) NP*bf(1)'));
    SC_C1 = find(strcmp(SPM.xX.name, 'Sn(9) SC*bf(1)'));
    SC_C2 = find(strcmp(SPM.xX.name, 'Sn(10) SC*bf(1)'));
    SC_C3 = find(strcmp(SPM.xX.name, 'Sn(11) SC*bf(1)'));
    SC_C4 = find(strcmp(SPM.xX.name, 'Sn(12) SC*bf(1)'));    
    SE_C1 = find(strcmp(SPM.xX.name, 'Sn(9) SE*bf(1)'));
    SE_C2 = find(strcmp(SPM.xX.name, 'Sn(10) SE*bf(1)'));
    SE_C3 = find(strcmp(SPM.xX.name, 'Sn(11) SE*bf(1)'));
    SE_C4 = find(strcmp(SPM.xX.name, 'Sn(12) SE*bf(1)'));

    NP_P = [NP_P1,NP_P2,NP_P3,NP_P4,NP_P5,NP_P6,NP_P7,NP_P8];
    SC_P = [SC_P1,SC_P2,SC_P3,SC_P4,SC_P5,SC_P6,SC_P7,SC_P8];
    SE_P = [SE_P1,SE_P2,SE_P3,SE_P4,SE_P5,SE_P6,SE_P7,SE_P8];
    NP_C = [NP_C1,NP_C2,NP_C3,NP_C4];
    SC_C = [SC_C1,SC_C2,SC_C3,SC_C4];
    SE_C = [SE_C1,SE_C2,SE_C3,SE_C4];
    nProd=8;
    nComp=4;
elseif s==2
    NP_P1 = find(strcmp(SPM.xX.name, 'Sn(1) NP*bf(1)'));
    NP_P2 = find(strcmp(SPM.xX.name, 'Sn(2) NP*bf(1)'));
    NP_P3 = find(strcmp(SPM.xX.name, 'Sn(3) NP*bf(1)'));
    NP_P4 = find(strcmp(SPM.xX.name, 'Sn(4) NP*bf(1)'));
    NP_P5 = find(strcmp(SPM.xX.name, 'Sn(5) NP*bf(1)'));
    NP_P6 = find(strcmp(SPM.xX.name, 'Sn(6) NP*bf(1)'));
    NP_P7 = find(strcmp(SPM.xX.name, 'Sn(7) NP*bf(1)'));
    NP_P8 = find(strcmp(SPM.xX.name, 'Sn(8) NP*bf(1)'));
    SC_P1 = find(strcmp(SPM.xX.name, 'Sn(1) SC*bf(1)'));
    SC_P2 = find(strcmp(SPM.xX.name, 'Sn(2) SC*bf(1)'));
    SC_P3 = find(strcmp(SPM.xX.name, 'Sn(3) SC*bf(1)'));
    SC_P4 = find(strcmp(SPM.xX.name, 'Sn(4) SC*bf(1)'));
    SC_P5 = find(strcmp(SPM.xX.name, 'Sn(5) SC*bf(1)'));
    SC_P6 = find(strcmp(SPM.xX.name, 'Sn(6) SC*bf(1)'));
    SC_P7 = find(strcmp(SPM.xX.name, 'Sn(7) SC*bf(1)'));
    SC_P8 = find(strcmp(SPM.xX.name, 'Sn(8) SC*bf(1)'));
    SE_P1 = find(strcmp(SPM.xX.name, 'Sn(1) SE*bf(1)'));
    SE_P2 = find(strcmp(SPM.xX.name, 'Sn(2) SE*bf(1)'));
    SE_P3 = find(strcmp(SPM.xX.name, 'Sn(3) SE*bf(1)'));
    SE_P4 = find(strcmp(SPM.xX.name, 'Sn(4) SE*bf(1)'));
    SE_P5 = find(strcmp(SPM.xX.name, 'Sn(5) SE*bf(1)'));
    SE_P6 = find(strcmp(SPM.xX.name, 'Sn(6) SE*bf(1)'));
    SE_P7 = find(strcmp(SPM.xX.name, 'Sn(7) SE*bf(1)'));
    SE_P8 = find(strcmp(SPM.xX.name, 'Sn(8) SE*bf(1)'));
    
    NP_C1 = find(strcmp(SPM.xX.name, 'Sn(9) NP*bf(1)'));
    NP_C2 = find(strcmp(SPM.xX.name, 'Sn(10) NP*bf(1)'));
    NP_C3 = find(strcmp(SPM.xX.name, 'Sn(11) NP*bf(1)'));
    SC_C1 = find(strcmp(SPM.xX.name, 'Sn(9) SC*bf(1)'));
    SC_C2 = find(strcmp(SPM.xX.name, 'Sn(10) SC*bf(1)'));
    SC_C3 = find(strcmp(SPM.xX.name, 'Sn(11) SC*bf(1)'));
    SE_C1 = find(strcmp(SPM.xX.name, 'Sn(9) SE*bf(1)'));
    SE_C2 = find(strcmp(SPM.xX.name, 'Sn(10) SE*bf(1)'));
    SE_C3 = find(strcmp(SPM.xX.name, 'Sn(11) SE*bf(1)'));

    NP_P = [NP_P1,NP_P2,NP_P3,NP_P4,NP_P5,NP_P6,NP_P7,NP_P8];
    SC_P = [SC_P1,SC_P2,SC_P3,SC_P4,SC_P5,SC_P6,SC_P7,SC_P8];
    SE_P = [SE_P1,SE_P2,SE_P3,SE_P4,SE_P5,SE_P6,SE_P7,SE_P8];
    NP_C = [NP_C1,NP_C2,NP_C3];
    SC_C = [SC_C1,SC_C2,SC_C3];
    SE_C = [SE_C1,SE_C2,SE_C3];
    nProd=8;
    nComp=3;
elseif s==29
    NP_P1 = find(strcmp(SPM.xX.name, 'Sn(1) NP*bf(1)'));
    NP_P2 = find(strcmp(SPM.xX.name, 'Sn(2) NP*bf(1)'));
    NP_P3 = find(strcmp(SPM.xX.name, 'Sn(3) NP*bf(1)'));
    NP_P4 = find(strcmp(SPM.xX.name, 'Sn(4) NP*bf(1)'));
    NP_P5 = find(strcmp(SPM.xX.name, 'Sn(5) NP*bf(1)'));
    NP_P6 = find(strcmp(SPM.xX.name, 'Sn(6) NP*bf(1)'));
    NP_P7 = find(strcmp(SPM.xX.name, 'Sn(7) NP*bf(1)'));
    SC_P1 = find(strcmp(SPM.xX.name, 'Sn(1) SC*bf(1)'));
    SC_P2 = find(strcmp(SPM.xX.name, 'Sn(2) SC*bf(1)'));
    SC_P3 = find(strcmp(SPM.xX.name, 'Sn(3) SC*bf(1)'));
    SC_P4 = find(strcmp(SPM.xX.name, 'Sn(4) SC*bf(1)'));
    SC_P5 = find(strcmp(SPM.xX.name, 'Sn(5) SC*bf(1)'));
    SC_P6 = find(strcmp(SPM.xX.name, 'Sn(6) SC*bf(1)'));
    SC_P7 = find(strcmp(SPM.xX.name, 'Sn(7) SC*bf(1)'));
    SE_P1 = find(strcmp(SPM.xX.name, 'Sn(1) SE*bf(1)'));
    SE_P2 = find(strcmp(SPM.xX.name, 'Sn(2) SE*bf(1)'));
    SE_P3 = find(strcmp(SPM.xX.name, 'Sn(3) SE*bf(1)'));
    SE_P4 = find(strcmp(SPM.xX.name, 'Sn(4) SE*bf(1)'));
    SE_P5 = find(strcmp(SPM.xX.name, 'Sn(5) SE*bf(1)'));
    SE_P6 = find(strcmp(SPM.xX.name, 'Sn(6) SE*bf(1)'));
    SE_P7 = find(strcmp(SPM.xX.name, 'Sn(7) SE*bf(1)'));
    
    NP_C1 = find(strcmp(SPM.xX.name, 'Sn(8) NP*bf(1)'));
    NP_C2 = find(strcmp(SPM.xX.name, 'Sn(9) NP*bf(1)'));
    NP_C3 = find(strcmp(SPM.xX.name, 'Sn(10) NP*bf(1)'));
    NP_C4 = find(strcmp(SPM.xX.name, 'Sn(11) NP*bf(1)'));
    SC_C1 = find(strcmp(SPM.xX.name, 'Sn(8) SC*bf(1)'));
    SC_C2 = find(strcmp(SPM.xX.name, 'Sn(9) SC*bf(1)'));
    SC_C3 = find(strcmp(SPM.xX.name, 'Sn(10) SC*bf(1)'));
    SC_C4 = find(strcmp(SPM.xX.name, 'Sn(11) SC*bf(1)'));    
    SE_C1 = find(strcmp(SPM.xX.name, 'Sn(8) SE*bf(1)'));
    SE_C2 = find(strcmp(SPM.xX.name, 'Sn(9) SE*bf(1)'));
    SE_C3 = find(strcmp(SPM.xX.name, 'Sn(10) SE*bf(1)'));
    SE_C4 = find(strcmp(SPM.xX.name, 'Sn(11) SE*bf(1)'));

    NP_P = [NP_P1,NP_P2,NP_P3,NP_P4,NP_P5,NP_P6,NP_P7];
    SC_P = [SC_P1,SC_P2,SC_P3,SC_P4,SC_P5,SC_P6,SC_P7];
    SE_P = [SE_P1,SE_P2,SE_P3,SE_P4,SE_P5,SE_P6,SE_P7];
    NP_C = [NP_C1,NP_C2,NP_C3,NP_C4];
    SC_C = [SC_C1,SC_C2,SC_C3,SC_C4];
    SE_C = [SE_C1,SE_C2,SE_C3,SE_C4];
    nProd=7;
    nComp=4;
elseif s==46
    NP_P1 = find(strcmp(SPM.xX.name, 'Sn(1) NP*bf(1)'));
    NP_P2 = find(strcmp(SPM.xX.name, 'Sn(2) NP*bf(1)'));
    NP_P3 = find(strcmp(SPM.xX.name, 'Sn(3) NP*bf(1)'));
    NP_P4 = find(strcmp(SPM.xX.name, 'Sn(4) NP*bf(1)'));
    NP_P5 = find(strcmp(SPM.xX.name, 'Sn(5) NP*bf(1)'));
    NP_P6 = find(strcmp(SPM.xX.name, 'Sn(6) NP*bf(1)'));
    NP_P7 = find(strcmp(SPM.xX.name, 'Sn(7) NP*bf(1)'));
    SC_P1 = find(strcmp(SPM.xX.name, 'Sn(1) SC*bf(1)'));
    SC_P2 = find(strcmp(SPM.xX.name, 'Sn(2) SC*bf(1)'));
    SC_P3 = find(strcmp(SPM.xX.name, 'Sn(3) SC*bf(1)'));
    SC_P4 = find(strcmp(SPM.xX.name, 'Sn(4) SC*bf(1)'));
    SC_P5 = find(strcmp(SPM.xX.name, 'Sn(5) SC*bf(1)'));
    SC_P6 = find(strcmp(SPM.xX.name, 'Sn(6) SC*bf(1)'));
    SC_P7 = find(strcmp(SPM.xX.name, 'Sn(7) SC*bf(1)'));
    SE_P1 = find(strcmp(SPM.xX.name, 'Sn(1) SE*bf(1)'));
    SE_P2 = find(strcmp(SPM.xX.name, 'Sn(2) SE*bf(1)'));
    SE_P3 = find(strcmp(SPM.xX.name, 'Sn(3) SE*bf(1)'));
    SE_P4 = find(strcmp(SPM.xX.name, 'Sn(4) SE*bf(1)'));
    SE_P5 = find(strcmp(SPM.xX.name, 'Sn(5) SE*bf(1)'));
    SE_P6 = find(strcmp(SPM.xX.name, 'Sn(6) SE*bf(1)'));
    SE_P7 = find(strcmp(SPM.xX.name, 'Sn(7) SE*bf(1)'));
    
    NP_C1 = find(strcmp(SPM.xX.name, 'Sn(8) NP*bf(1)'));
    NP_C2 = find(strcmp(SPM.xX.name, 'Sn(9) NP*bf(1)'));
    NP_C3 = find(strcmp(SPM.xX.name, 'Sn(10) NP*bf(1)'));
    SC_C1 = find(strcmp(SPM.xX.name, 'Sn(8) SC*bf(1)'));
    SC_C2 = find(strcmp(SPM.xX.name, 'Sn(9) SC*bf(1)'));
    SC_C3 = find(strcmp(SPM.xX.name, 'Sn(10) SC*bf(1)')); 
    SE_C1 = find(strcmp(SPM.xX.name, 'Sn(8) SE*bf(1)'));
    SE_C2 = find(strcmp(SPM.xX.name, 'Sn(9) SE*bf(1)'));
    SE_C3 = find(strcmp(SPM.xX.name, 'Sn(10) SE*bf(1)'));
    nProd=7;
    nComp=3;
    
    NP_P = [NP_P1,NP_P2,NP_P3,NP_P4,NP_P5,NP_P6,NP_P7];
    SC_P = [SC_P1,SC_P2,SC_P3,SC_P4,SC_P5,SC_P6,SC_P7];
    SE_P = [SE_P1,SE_P2,SE_P3,SE_P4,SE_P5,SE_P6,SE_P7];
    NP_C = [NP_C1,NP_C2,NP_C3];
    SC_C = [SC_C1,SC_C2,SC_C3];
    SE_C = [SE_C1,SE_C2,SE_C3];
end

nBetas = size(SPM.Vbeta,2);

% % contrast Main Effect of Modality, P>C
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'ME Mod P>C';
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = zeros(1,nBetas);
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(NP_P) = 1/nProd;
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(SC_P) = 1/nProd;
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(SE_P) = 1/nProd;
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(NP_C) = -1/nComp;
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(SC_C) = -1/nComp;
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(SE_C) = -1/nComp;
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
% % contrast Main Effect of Modality, C>P
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'ME Mod C>P';
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = zeros(1,nBetas);
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(NP_P) = -1/nProd;
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(SC_P) = -1/nProd;
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(SE_P) = -1/nProd;
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(NP_C) = 1/nComp;
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(SC_C) = 1/nComp;
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(SE_C) = 1/nComp;
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
% % contrast Main Effect of Structure, SE-NP
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'ME Str SE-NP';
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights = zeros(1,nBetas);
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights(NP_P) = -1/nProd;
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights(SC_P) = 0;
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights(SE_P) = 1/nProd;
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights(NP_C) = -1/nComp;
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights(SC_C) = 0;
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights(SE_C) = 1/nComp;
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
% % contrast Main Effect of Structure, NP-SE
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = 'ME Str NP-SE';
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights = zeros(1,nBetas);
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights(NP_P) = 1/nProd;
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights(SC_P) = 0;
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights(SE_P) = -1/nProd;
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights(NP_C) = 1/nComp;
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights(SC_C) = 0;
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights(SE_C) = -1/nComp;
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
% % contrast Main Effect of Embedding, SE-SC
% matlabbatch{1}.spm.stats.con.consess{5}.tcon.name = 'ME Str SE-SC';
% matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights = zeros(1,nBetas);
% matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights(NP_P) = 0;
% matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights(SC_P) = -1/nProd;
% matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights(SE_P) = 1/nProd;
% matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights(NP_C) = 0;
% matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights(SC_C) = -1/nComp;
% matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights(SE_C) = 1/nComp;
% matlabbatch{1}.spm.stats.con.consess{5}.tcon.sessrep = 'none';
% % contrast Main Effect of Embedding, SC-SE
% matlabbatch{1}.spm.stats.con.consess{6}.tcon.name = 'ME Str SC-SE';
% matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights = zeros(1,nBetas);
% matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights(NP_P) = 0;
% matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights(SC_P) = 1/nProd;
% matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights(SE_P) = -1/nProd;
% matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights(NP_C) = 0;
% matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights(SC_C) = 1/nComp;
% matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights(SE_C) = -1/nComp;
% matlabbatch{1}.spm.stats.con.consess{6}.tcon.sessrep = 'none';
% % contrast Interaction Gradient P>C
% matlabbatch{1}.spm.stats.con.consess{7}.tcon.name = 'Int Gradient P>C';
% matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights = zeros(1,nBetas);
% matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights(NP_P) = -1/nProd;
% matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights(SC_P) = 0;
% matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights(SE_P) = 1/nProd;
% matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights(NP_C) = 1/nComp;
% matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights(SC_C) = 0;
% matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights(SE_C) = -1/nComp;
% matlabbatch{1}.spm.stats.con.consess{7}.tcon.sessrep = 'none';
% % contrast Interaction Gradient C>P
% matlabbatch{1}.spm.stats.con.consess{8}.tcon.name = 'Int Gradient C>P';
% matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights = zeros(1,nBetas);
% matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights(NP_P) = 1/nProd;
% matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights(SC_P) = 0;
% matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights(SE_P) = -1/nProd;
% matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights(NP_C) = -1/nComp;
% matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights(SC_C) = 0;
% matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights(SE_C) = 1/nComp;
% matlabbatch{1}.spm.stats.con.consess{8}.tcon.sessrep = 'none';
% % contrast Interaction Embedding P>C
% matlabbatch{1}.spm.stats.con.consess{9}.tcon.name = 'Int SE-SC P>C';
% matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights = zeros(1,nBetas);
% matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights(NP_P) = 0;
% matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights(SC_P) = -1/nProd;
% matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights(SE_P) = 1/nProd;
% matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights(NP_C) = 0;
% matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights(SC_C) = 1/nComp;
% matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights(SE_C) = -1/nComp;
% matlabbatch{1}.spm.stats.con.consess{9}.tcon.sessrep = 'none';
% % contrast Interaction Embedding C>P
% matlabbatch{1}.spm.stats.con.consess{10}.tcon.name = 'Int SE-SC C>P';
% matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights = zeros(1,nBetas);
% matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights(NP_P) = 0;
% matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights(SC_P) = 1/nProd;
% matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights(SE_P) = -1/nProd;
% matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights(NP_C) = 0;
% matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights(SC_C) = -1/nComp;
% matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights(SE_C) = 1/nComp;
% matlabbatch{1}.spm.stats.con.consess{10}.tcon.sessrep = 'none';
% matlabbatch{1}.spm.stats.con.delete = 0;
% 
% % contrast Structure Effect in Production
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'Prod Gradient';
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = zeros(1,nBetas);
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(NP_P) = -1/nProd;
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(SC_P) = 0/nProd;
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(SE_P) = 1/nProd;
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(NP_C) = 0/nComp;
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(SC_C) = 0/nComp;
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(SE_C) = 0/nComp;
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
% % contrast Structure Effect in Comprehension
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'Comp Gradient';
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = zeros(1,nBetas);
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(NP_P) = 0/nProd;
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(SC_P) = 0/nProd;
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(SE_P) = 0/nProd;
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(NP_C) = -1/nComp;
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(SC_C) = 0/nComp;
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(SE_C) = 1/nComp;
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
% % contrast Embedding in Prod
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'Emb Prod';
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights = zeros(1,nBetas);
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights(NP_P) = 0/nProd;
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights(SC_P) = -1;
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights(SE_P) = 1/nProd;
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights(NP_C) = 0/nComp;
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights(SC_C) = 0;
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights(SE_C) = 0/nComp;
% matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
% % contrast Embedding in Comp
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = 'Emb Comp';
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights = zeros(1,nBetas);
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights(NP_P) = 0/nProd;
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights(SC_P) = 0;
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights(SE_P) = 0/nProd;
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights(NP_C) = 0/nComp;
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights(SC_C) = -1;
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights(SE_C) = 1/nComp;
% matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = 'none';

% % contrast Constituent size (like in Pallier, based on actual size) Effect in Production
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'Prod C Size';
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = zeros(1,nBetas);
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(NP_P) = -4/nProd;
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(SC_P) = -1/nProd;
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(SE_P) = 5/nProd;
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(NP_C) = 0/nComp;
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(SC_C) = 0/nComp;
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(SE_C) = 0/nComp;
% matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
% % contrast Constituent size in Comprehension
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'Comp C Size';
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = zeros(1,nBetas);
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(NP_P) = 0/nProd;
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(SC_P) = 0/nProd;
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(SE_P) = 0/nProd;
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(NP_C) = -4/nComp;
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(SC_C) = -1/nComp;
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(SE_C) = 5/nComp;
% matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';

% contrast Main Effect of Structure, SE-NP
matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'ME Str Csize';
matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = zeros(1,nBetas);
matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(NP_P) = -4/nProd;
matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(SC_P) = -1/nProd;
matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(SE_P) = 5/nProd;
matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(NP_C) = -4/nComp;
matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(SC_C) = -1/nComp;
matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights(SE_C) = 5/nComp;
matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
% contrast Interaction Gradient P>C
matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'Int Csize P>C';
matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = zeros(1,nBetas);
matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(NP_P) = -4/nProd;
matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(SC_P) = -1/nProd;
matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(SE_P) = 5/nProd;
matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(NP_C) = 4/nComp;
matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(SC_C) = 1/nComp;
matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights(SE_C) = -5/nComp;
matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
% contrast Interaction Gradient C>P
matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'Int Csize C>P';
matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights = zeros(1,nBetas);
matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights(NP_P) = 4/nProd;
matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights(SC_P) = 1/nProd;
matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights(SE_P) = -5/nProd;
matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights(NP_C) = -4/nComp;
matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights(SC_C) = -1/nComp;
matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights(SE_C) = 5/nComp;
matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';

% contrast Main Effect of Modality, P>C
matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = 'ME Mod P>C';
matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights = zeros(1,nBetas);
matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights(NP_P) = 1/nProd;
matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights(SC_P) = 1/nProd;
matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights(SE_P) = 1/nProd;
matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights(NP_C) = -1/nComp;
matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights(SC_C) = -1/nComp;
matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights(SE_C) = -1/nComp;
matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
% contrast Main Effect of Modality, C>P
matlabbatch{1}.spm.stats.con.consess{5}.tcon.name = 'ME Mod C>P';
matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights = zeros(1,nBetas);
matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights(NP_P) = -1/nProd;
matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights(SC_P) = -1/nProd;
matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights(SE_P) = -1/nProd;
matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights(NP_C) = 1/nComp;
matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights(SC_C) = 1/nComp;
matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights(SE_C) = 1/nComp;
matlabbatch{1}.spm.stats.con.consess{5}.tcon.sessrep = 'none';
% contrast Constituent size (like in Pallier, based on actual size) Effect in Production
matlabbatch{1}.spm.stats.con.consess{6}.tcon.name = 'Prod C Size';
matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights = zeros(1,nBetas);
matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights(NP_P) = -4/nProd;
matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights(SC_P) = -1/nProd;
matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights(SE_P) = 5/nProd;
matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights(NP_C) = 0/nComp;
matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights(SC_C) = 0/nComp;
matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights(SE_C) = 0/nComp;
matlabbatch{1}.spm.stats.con.consess{6}.tcon.sessrep = 'none';
% contrast Constituent size in Comprehension
matlabbatch{1}.spm.stats.con.consess{7}.tcon.name = 'Comp C Size';
matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights = zeros(1,nBetas);
matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights(NP_P) = 0/nProd;
matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights(SC_P) = 0/nProd;
matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights(SE_P) = 0/nProd;
matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights(NP_C) = -4/nComp;
matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights(SC_C) = -1/nComp;
matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights(SE_C) = 5/nComp;
matlabbatch{1}.spm.stats.con.consess{7}.tcon.sessrep = 'none';
% single condition contrast for ROI analysis
matlabbatch{1}.spm.stats.con.consess{8}.tcon.name = 'NP_P';
matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights = zeros(1,nBetas);
matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights(NP_P) = 1/nProd;
matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights(SC_P) = 0/nProd;
matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights(SE_P) = 0/nProd;
matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights(NP_C) = 0/nComp;
matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights(SC_C) = 0/nComp;
matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights(SE_C) = 0/nComp;
matlabbatch{1}.spm.stats.con.consess{8}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.consess{9}.tcon.name = 'SC_P';
matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights = zeros(1,nBetas);
matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights(NP_P) = 0/nProd;
matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights(SC_P) = 1/nProd;
matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights(SE_P) = 0/nProd;
matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights(NP_C) = 0/nComp;
matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights(SC_C) = 0/nComp;
matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights(SE_C) = 0/nComp;
matlabbatch{1}.spm.stats.con.consess{9}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.consess{10}.tcon.name = 'SE_P';
matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights = zeros(1,nBetas);
matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights(NP_P) = 0/nProd;
matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights(SC_P) = 0/nProd;
matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights(SE_P) = 1/nProd;
matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights(NP_C) = 0/nComp;
matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights(SC_C) = 0/nComp;
matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights(SE_C) = 0/nComp;
matlabbatch{1}.spm.stats.con.consess{10}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.consess{11}.tcon.name = 'NP_C';
matlabbatch{1}.spm.stats.con.consess{11}.tcon.weights = zeros(1,nBetas);
matlabbatch{1}.spm.stats.con.consess{11}.tcon.weights(NP_P) = 0/nProd;
matlabbatch{1}.spm.stats.con.consess{11}.tcon.weights(SC_P) = 0/nProd;
matlabbatch{1}.spm.stats.con.consess{11}.tcon.weights(SE_P) = 0/nProd;
matlabbatch{1}.spm.stats.con.consess{11}.tcon.weights(NP_C) = 1/nComp;
matlabbatch{1}.spm.stats.con.consess{11}.tcon.weights(SC_C) = 0/nComp;
matlabbatch{1}.spm.stats.con.consess{11}.tcon.weights(SE_C) = 0/nComp;
matlabbatch{1}.spm.stats.con.consess{11}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.consess{12}.tcon.name = 'SC_C';
matlabbatch{1}.spm.stats.con.consess{12}.tcon.weights = zeros(1,nBetas);
matlabbatch{1}.spm.stats.con.consess{12}.tcon.weights(NP_P) = 0/nProd;
matlabbatch{1}.spm.stats.con.consess{12}.tcon.weights(SC_P) = 0/nProd;
matlabbatch{1}.spm.stats.con.consess{12}.tcon.weights(SE_P) = 0/nProd;
matlabbatch{1}.spm.stats.con.consess{12}.tcon.weights(NP_C) = 0/nComp;
matlabbatch{1}.spm.stats.con.consess{12}.tcon.weights(SC_C) = 1/nComp;
matlabbatch{1}.spm.stats.con.consess{12}.tcon.weights(SE_C) = 0/nComp;
matlabbatch{1}.spm.stats.con.consess{12}.tcon.sessrep = 'none';
matlabbatch{1}.spm.stats.con.consess{13}.tcon.name = 'SE_C';
matlabbatch{1}.spm.stats.con.consess{13}.tcon.weights = zeros(1,nBetas);
matlabbatch{1}.spm.stats.con.consess{13}.tcon.weights(NP_P) = 0/nProd;
matlabbatch{1}.spm.stats.con.consess{13}.tcon.weights(SC_P) = 0/nProd;
matlabbatch{1}.spm.stats.con.consess{13}.tcon.weights(SE_P) = 0/nProd;
matlabbatch{1}.spm.stats.con.consess{13}.tcon.weights(NP_C) = 0/nComp;
matlabbatch{1}.spm.stats.con.consess{13}.tcon.weights(SC_C) = 0/nComp;
matlabbatch{1}.spm.stats.con.consess{13}.tcon.weights(SE_C) = 1/nComp;
matlabbatch{1}.spm.stats.con.consess{13}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.delete = 1;


% run job
spm_jobman('run',matlabbatch);
end