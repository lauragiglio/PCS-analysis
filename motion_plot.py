#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Aug  7 16:00:44 2019

@author: laugig
"""

from pandas import DataFrame

from pandas import Series
import matplotlib.pyplot as plt
import os
os.chdir('/project/3011226.01/bids/derivatives/')
fmriprepdir = '/project/3011226.01/bids/derivatives/fmriprep/'
firstleveldir = '/project/3011226.01/bids/derivatives/SPM/firstlevel/'


# range 1-40, excluding 5, 23
for s in range(46,47):
    #convert to string    
    subj = str(s).zfill(2)
    # PRODUCTION
    for n in range(1,9):   
        run = str(n)
        if subj == '01' and n == 1 or subj == '10' and n == 1 or subj == '31' and n == 1:
            df = DataFrame.from_csv(f'{fmriprepdir}sub-0{subj}/ses-mri01/func/sub-0{subj}_ses-mri01_task-Production{run}_acq-epi_run-2_desc-confounds_regressors.tsv', sep="\t") 
        else:            
            df = DataFrame.from_csv(f'{fmriprepdir}sub-0{subj}/ses-mri01/func/sub-0{subj}_ses-mri01_task-Production{run}_acq-epi_run-1_desc-confounds_regressors.tsv', sep="\t")
        
        df.index = range(1,len(df)+1)
            
        fig, ((ax1, ax2), (ax3, ax4), (ax5, ax6)) = plt.subplots(3, 2)
        fig.set_figheight(10)
        fig.set_figwidth(10)
        fig.suptitle(f'Motion for sub-0{subj}, run {run}')
        ax1.plot(df.trans_x)
        ax1.set_title('Trans_x')
        ax3.plot(df.trans_y)
        ax3.set_title('Trans_y')
        ax5.plot(df.trans_z)
        ax5.set_title('Trans_z')
        ax2.plot(df.rot_x)
        ax2.set_title('Rot_x')
        ax4.plot(df.rot_y)
        ax4.set_title('Rot_y')
        ax6.plot(df.rot_z)
        ax6.set_title('Rot_z')
        fig.tight_layout()
        #plt.show()    
        plt.savefig(f'{firstleveldir}sub-0{subj}/motion_P{run}.png')

        
    
    # COMPREHENSION
    for n in range(1,5):   
        run = str(n)
               
        df = DataFrame.from_csv(f'{fmriprepdir}sub-0{subj}/ses-mri01/func/sub-0{subj}_ses-mri01_task-Comprehension{run}_acq-epi_run-1_desc-confounds_regressors.tsv', sep="\t")
        
        df.index = range(1,len(df)+1)
            
        fig, ((ax1, ax2), (ax3, ax4), (ax5, ax6)) = plt.subplots(3, 2)
        fig.set_figheight(10)
        fig.set_figwidth(10)
        fig.suptitle(f'Motion for sub-0{subj}, run {run}')
        ax1.plot(df.trans_x)
        ax1.set_title('Trans_x')
        ax3.plot(df.trans_y)
        ax3.set_title('Trans_y')
        ax5.plot(df.trans_z)
        ax5.set_title('Trans_z')
        ax2.plot(df.rot_x)
        ax2.set_title('Rot_x')
        ax4.plot(df.rot_y)
        ax4.set_title('Rot_y')
        ax6.plot(df.rot_z)
        ax6.set_title('Rot_z')
        fig.tight_layout()
        #plt.show()    
        plt.savefig(f'{firstleveldir}sub-0{subj}/motion_C{run}.png')
    
