%% Improve ICA-AROMA with task regressors
% Martin Johansson - adapated version by LG
% Script to compare AROMA component time series with task regressors
% Outputs a useful index of which components might be linked to the task
% and should be checked for noise vs signal
function [] = improve_aroma_taskreg(s)
%% My specified directories
%clear all
addpath('/home/common/matlab/spm12');
spm('defaults', 'FMRI');
Root	 = '/project/3011226.01';
behavdir = fullfile(Root, 'behavioural/');
BIDSDir  = fullfile(Root, 'bids');
FMRIPrep = fullfile(BIDSDir, 'derivatives/fmriprep/');
SPMder   = fullfile(BIDSDir, 'derivatives/SPM/firstlevel/');
BIDS     = spm_BIDS(BIDSDir);
AllSub      = spm_BIDS(BIDS, 'subjects', 'ses','mri01');
Session  = ['ses-mri01'];

% Generate task-regressors: I use a batch script of SPM's first-level
% analysis that runs from start to model specification without smoothing.
% This me a SPM.mat file. I load this file and extract task-regressors from variable SPM.xX.X

%subject number
%s = 2 %define
subj = ['sub-0' sprintf('%02d', s)];

% Multiple regression of task-regressors on motion IC time series
n_run = 8;
for n = 1:n_run
    run = int2str(n);
    if s==29 && run == '1'%not running for run 1 because of missing condition due to errors
    elseif s==46 && run== '5'
    else    
        % Load necessary data
        SPMmatPath          = [behavdir 's' sprintf('%02d', s) '/' run '/SPM.mat'];
        SPMvar              = load(SPMmatPath);
        if s == 1 && n == 1 || s == 10 && n == 1 || s==31 && n==1
            MixingMatrixFile    = [FMRIPrep subj '/ses-mri01/func/' subj '_ses-mri01_task-Production' run '_acq-epi_run-2_desc-MELODIC_mixing.tsv'];
            NoiseCompFile       = [FMRIPrep subj '/ses-mri01/func/' subj '_ses-mri01_task-Production' run '_acq-epi_run-2_AROMAnoiseICs.csv'];
        else
            MixingMatrixFile    = [FMRIPrep subj '/ses-mri01/func/' subj '_ses-mri01_task-Production' run '_acq-epi_run-1_desc-MELODIC_mixing.tsv'];
            NoiseCompFile       = [FMRIPrep subj '/ses-mri01/func/' subj '_ses-mri01_task-Production' run '_acq-epi_run-1_AROMAnoiseICs.csv'];
        end
        
        nreg = size(SPMvar.SPM.xX.X,2) - 1;
        TaskRegs        = SPMvar.SPM.xX.X(:,1:nreg);
        MixingMatrix    = spm_load(MixingMatrixFile);
        CompMotionClass = csvread(NoiseCompFile);
        
        % Extract motion-classified components from mixing matrix
        for t = 1:numel(CompMotionClass)
            
            RegNr               = CompMotionClass(t);
            RegTS               = MixingMatrix(:,RegNr);
            CompMotionTS(:,t)   = RegTS;
            
        end
        
        % Multiple regression of task regressors on motion comp tss
        for r = 1:numel(CompMotionClass)
            
            Corrmat(r,1) = corr(TaskRegs(:,1),CompMotionTS(6:210,r));
            Corrmat(r,2) = corr(TaskRegs(:,2),CompMotionTS(6:210,r));
            Corrmat(r,3) = corr(TaskRegs(:,3),CompMotionTS(6:210,r));
            Corrmat(r,4) = corr(TaskRegs(:,4),CompMotionTS(6:210,r));
            Corrmat(r,5) = corr(TaskRegs(:,5),CompMotionTS(6:210,r));
            Corrmat(r,6) = corr(TaskRegs(:,6),CompMotionTS(6:210,r));
            Corrmat(r,7) = corr(TaskRegs(:,7),CompMotionTS(6:210,r));
            Corrmat(r,8) = corr(TaskRegs(:,8),CompMotionTS(6:210,r));
            if nreg == 9
                Corrmat(r,9) = corr(TaskRegs(:,9),CompMotionTS(6:210,r));
            end
            CorrmatMax(r,:) = max(Corrmat(r,:));
            
            Fitted        = fitlm(TaskRegs, CompMotionTS(6:210,r));
            CorrmatRSquared(r,:)  = Fitted.Rsquared.Adjusted;
            
        end
        
        % Plots: Correlations, Adj. R2, Max correlation. I only used Adj. R2,
        % probably removing the others.
        FigFileName = fullfile(SPMder, subj, [subj '_' Session '_' run '_taskregAROMA.png']);
        Figure = figure('visible','off','Position',[10 10 1000 800]);
        subplot(1,3,1);
        imagesc(abs(Corrmat));
        set(gca, 'XTick', 1:nreg);
        if nreg == 5
            xnames = {'NP';'SC';'SE';'FIL';'ERR'};
        else
            xnames = {'NP';'SC';'SE';'FIL'};
        end
        set(gca, 'XTickLabel', xnames);
        title('r');
        xlabel('Condition');
        ylabel('Component classified as noise')
        colormap('hot');
        colorbar;
        subplot(1,3,2);
        imagesc(abs(CorrmatRSquared));              % Display absolute values
        set(gca, 'XTick', 0);
        title('Adj. R²');
        ylabel('Component classified as noise')
        colormap('hot');
        colorbar;
        saveas(Figure, FigFileName);
        subplot(1,3,3);
        imagesc(abs(CorrmatMax));              % Display absolute values
        set(gca, 'XTick', 0);
        title('Maximum r');
        ylabel('Component classified as noise')
        colormap('hot');
        colorbar;
        saveas(Figure, FigFileName);
        
        % Make a table of above-threshold ICs
        TableFileName = fullfile(SPMder, subj, [subj '_' Session '_' run '_taskregAROMA_table']);
        Thr = 0.05;
        Component = CompMotionClass(CorrmatRSquared > Thr)';
        AdjRSquared = CorrmatRSquared(CorrmatRSquared > Thr);
        RnCompAboveThr = table(Component,AdjRSquared);
        writetable(RnCompAboveThr,TableFileName);
        clear vars CompMotionTS Corrmat CorrmatRSquared CorrmatMax
    end 
end
end