%% ROI analysis IFG and MTG
cd /project/3011226.01/bids/derivatives/SPM/ROI/
addpath('/home/common/matlab/spm12/')
spm fmir
%open marsbar

subjectlist = [1 2 4 7 8 9 10 11 12 14 15 16 17 18 19 20 21 22 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 46];

for s = subjectlist
    
    subj = ['sub-0' sprintf('%02d', s)];
    
    %load first-level design file
    spm_name = strcat('/project/3011226.01/bids/derivatives/SPM/firstlevel/', subj, '/prod_comp/SPM.mat');
    IFG_file = '/project/3011226.01/bids/derivatives/SPM/ROI/LIFG_roi.mat'
    MTG_file = '/project/3011226.01/bids/derivatives/SPM/ROI/LMTG_roi.mat'
%% IFG    
    % Make marsbar design object
    D  = mardo(spm_name);
    D = autocorr(D, 'fmristat', 2);

    % Make marsbar ROI object for IFG
    R  = maroi(IFG_file);
    % Fetch data into marsbar data object
    Y  = get_marsy(R, D, 'mean');
    % Get contrasts from original design
    xCon = get_contrasts(D);
    xCon = xCon(8:13)
    % Estimate design on ROI data
    E = estimate(D, Y);
    % Put contrasts from original design back into design object
    E = set_contrasts(E, xCon);
    % get design betas
    %b = betas(E);
    % get stats and stuff for all contrasts into statistics structure
    marsS_IFG = compute_contrasts(E, 1:length(xCon));

    %mkdir(['/project/3011226.01/bids/derivatives/SPM/ROI/' subj])
    save(['/project/3011226.01/bids/derivatives/SPM/ROI/' subj '/marsS_IFG_comp_corrected.mat'], 'marsS_IFG')
    clear D
    clear R
    clear Y
    clear E
    clear marsS_IFG
    clear xCon
    
    %% MTG
    % Make marsbar design object
    D  = mardo(spm_name);
    D = autocorr(D, 'fmristat', 2);

    % Make marsbar ROI object for MTG
    MTG_R  = maroi(MTG_file);
    % Fetch data into marsbar data object
    Y  = get_marsy(MTG_R, D, 'mean');
    % Get contrasts from original design
    xCon = get_contrasts(D);
    xCon = xCon(8:13)

    % Estimate design on ROI data
    E = estimate(D, Y);
    % Put contrasts from original design back into design object
    E = set_contrasts(E, xCon);
    % get design betas
    %b = betas(E);
    % get stats and stuff for all contrasts into statistics structure
    marsS_MTG = compute_contrasts(E, 1:length(xCon));

    save(['/project/3011226.01/bids/derivatives/SPM/ROI/' subj '/marsS_MTG_comp_corrected.mat'], 'marsS_MTG')
    clear D
    clear MTG_R
    clear Y
    clear E
    clear marsS_MTG
    clear xCon
    
    
%% MTG    
    
    spm_name = strcat('/project/3011226.01/bids/derivatives/SPM/firstlevel/', subj, '/prod_comp/SPM.mat');
    aMTG_file = '/project/3011226.01/bids/derivatives/SPM/ROI/ant-postMTG/aMTG_roi.mat';
    pMTG_file = '/project/3011226.01/bids/derivatives/SPM/ROI/ant-postMTG/pMTG_roi.mat';
%% aMTG    
    % Make marsbar design object
    D  = mardo(spm_name);
    D = autocorr(D, 'fmristat', 2);
    % Make marsbar ROI object for IFG
    aMTG_R  = maroi(aMTG_file);
    % Fetch data into marsbar data object
    Y  = get_marsy(aMTG_R, D, 'mean');
    % Get contrasts from original design
    xCon = get_contrasts(D);
    xCon = xCon(8:13)

    % Estimate design on ROI data
    E = estimate(D, Y);
    % Put contrasts from original design back into design object
    E = set_contrasts(E, xCon);
    % get design betas
    %b = betas(E);
    % get stats and stuff for all contrasts into statistics structure
    marsS_aMTG = compute_contrasts(E, 1:length(xCon));

    save(['/project/3011226.01/bids/derivatives/SPM/ROI/' subj '/marsS_aMTG_comp_corrected.mat'], 'marsS_aMTG')
    clear D
    clear aMTG_R
    clear Y
    clear E
    clear marsS_aMTG
    clear xCon
    
    %% pMTG
    % Make marsbar design object
    D  = mardo(spm_name);
    D = autocorr(D, 'fmristat', 2);

    % Make marsbar ROI object for MTG
    pMTG_R  = maroi(pMTG_file);
    % Fetch data into marsbar data object
    Y  = get_marsy(pMTG_R, D, 'mean');
    % Get contrasts from original design
    xCon = get_contrasts(D);
    xCon = xCon(8:13)

    % Estimate design on ROI data
    E = estimate(D, Y);
    % Put contrasts from original design back into design object
    E = set_contrasts(E, xCon);
    % get design betas
    %b = betas(E);
    % get stats and stuff for all contrasts into statistics structure
    marsS_pMTG = compute_contrasts(E, 1:length(xCon));

    save(['/project/3011226.01/bids/derivatives/SPM/ROI/' subj '/marsS_pMTG_comp_corrected.mat'], 'marsS_pMTG')
    clear D
    clear pMTG_R
    clear Y
    clear E
    clear marsS_pMTG
    clear xCon
    
end

%% save contrast values per part cond and ROI in csv file for analysis in R
IFG_NP_P = zeros(40,1);
IFG_SC_P = zeros(40,1);
IFG_SE_P = zeros(40,1);
IFG_NP_C = zeros(40,1);
IFG_SC_C = zeros(40,1);
IFG_SE_C = zeros(40,1);
MTG_NP_P = zeros(40,1);
MTG_SC_P = zeros(40,1);
MTG_SE_P = zeros(40,1);
MTG_NP_C = zeros(40,1);
MTG_SC_C = zeros(40,1);
MTG_SE_C = zeros(40,1);

for i=1:40
    s=subjectlist(i);
    subj = ['sub-0' sprintf('%02d', s)];
    load(['/project/3011226.01/bids/derivatives/SPM/ROI/' subj '/marsS_MTG_comp_corrected.mat'])
    load(['/project/3011226.01/bids/derivatives/SPM/ROI/' subj '/marsS_IFG_comp_corrected.mat'])
    IFG_NP_P(i,1) = marsS_IFG.con(1);
    IFG_SC_P(i,1) = marsS_IFG.con(2);
    IFG_SE_P(i,1) = marsS_IFG.con(3);
    IFG_NP_C(i,1) = marsS_IFG.con(4);
    IFG_SC_C(i,1) = marsS_IFG.con(5);
    IFG_SE_C(i,1) = marsS_IFG.con(6);
    MTG_NP_P(i,1) = marsS_MTG.con(1);
    MTG_SC_P(i,1) = marsS_MTG.con(2);
    MTG_SE_P(i,1) = marsS_MTG.con(3);
    MTG_NP_C(i,1) = marsS_MTG.con(4);
    MTG_SC_C(i,1) = marsS_MTG.con(5);
    MTG_SE_C(i,1) = marsS_MTG.con(6);
end
    
participant = [1:40]';

ROIresults = table(participant,IFG_NP_P,IFG_SC_P,IFG_SE_P,IFG_NP_C,IFG_SC_C,IFG_SE_C,MTG_NP_P,MTG_SC_P,MTG_SE_P,MTG_NP_C,MTG_SC_C,MTG_SE_C)

writetable(ROIresults, 'ROIresults_scaled_comp_corrected.csv')



%% save contrast values per part cond and ROI in csv file for analysis in R
aMTG_NP_P = zeros(40,1);
aMTG_SC_P = zeros(40,1);
aMTG_SE_P = zeros(40,1);
aMTG_NP_C = zeros(40,1);
aMTG_SC_C = zeros(40,1);
aMTG_SE_C = zeros(40,1);
pMTG_NP_P = zeros(40,1);
pMTG_SC_P = zeros(40,1);
pMTG_SE_P = zeros(40,1);
pMTG_NP_C = zeros(40,1);
pMTG_SC_C = zeros(40,1);
pMTG_SE_C = zeros(40,1);

for i=1:40
    s=subjectlist(i);
    subj = ['sub-0' sprintf('%02d', s)];
    load(['/project/3011226.01/bids/derivatives/SPM/ROI/' subj '/marsS_aMTG_comp_corrected.mat'])
    load(['/project/3011226.01/bids/derivatives/SPM/ROI/' subj '/marsS_pMTG_comp_corrected.mat'])
    aMTG_NP_P(i,1) = marsS_aMTG.con(1);
    aMTG_SC_P(i,1) = marsS_aMTG.con(2);
    aMTG_SE_P(i,1) = marsS_aMTG.con(3);
    aMTG_NP_C(i,1) = marsS_aMTG.con(4);
    aMTG_SC_C(i,1) = marsS_aMTG.con(5);
    aMTG_SE_C(i,1) = marsS_aMTG.con(6);
    pMTG_NP_P(i,1) = marsS_pMTG.con(1);
    pMTG_SC_P(i,1) = marsS_pMTG.con(2);
    pMTG_SE_P(i,1) = marsS_pMTG.con(3);
    pMTG_NP_C(i,1) = marsS_pMTG.con(4);
    pMTG_SC_C(i,1) = marsS_pMTG.con(5);
    pMTG_SE_C(i,1) = marsS_pMTG.con(6);
end
    
participant = [1:40]';

ROIresults = table(participant,aMTG_NP_P,aMTG_SC_P,aMTG_SE_P,aMTG_NP_C,aMTG_SC_C,aMTG_SE_C,pMTG_NP_P,pMTG_SC_P,pMTG_SE_P,pMTG_NP_C,pMTG_SC_C,pMTG_SE_C)

writetable(ROIresults, 'MTGresults_scaled_comp_corrected.csv')
