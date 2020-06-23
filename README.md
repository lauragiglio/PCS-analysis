# PCS-analysis
Analysis scripts

Pipeline:

1. Convert data to BIDS: $bidscoiner.py raw bids

2. Run fmriprep(version 1.2.6-1): $fmriprep_sub.py bids -a "--use-aroma --output-space template"

3. Run smoothing in SPM: ./scripts/smooth.m 

4. Do behavioural coding: accuracy and onset+offset

5. Create task regressors:
	5.1 if s>3, SPYDER: run logfile.py to make logfile compatible to .m script
	5.2 MATLAB task_regressors_corrected.m -> to create task regressor .mat files for each prod and comp run: Px.mat etc
	(unzip smoothed files)
	
6. Create nuisance regressors: SPYDER nuisance_regressors.py 
	6.1 check motion: motion_plot.py
	6.2 check framewise displacement: framewise_displacement.py

7. Run first-level analysis: first_level_analysis_pipeline.m 
	7.1 specify_first_level_combined_FAST.m
	7.2 estimate_first_level_combined.m
	7.3 contrast_weights.m

8. Run second-level analysis: one_sample_job.m (including specify second level and estimate second level)
	8.1 contrasts: contrasts_onesample_group.m

(9. Instead of 7 and 8 can run: SPM_full_pipeline.m)

10. ROI analysis in marsbar: ROIanalysis_marsbar.m

11. Behavioural analysis in R: Behav_analysis.Rmd

12. ROI analysis lmem in R: fMRI_ROI_analysis.Rmd
