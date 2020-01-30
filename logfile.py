#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 24 13:18:37 2019
Script to make presentation generated .log file compatible with previous participants
@author: laugig
"""
import pandas as pd
import os
os.chdir('/project/3011226.01/behavioural/')

# subjects 4-40 (excluding 5, 23)
for n in range(46,47):
    #convert to string    
    subj = str(n).zfill(2)
    behavdir = '/project/3011226.01/behavioural/'
    
    #COMPREHENSION
    for i in range(1,5):
        run = str(i)
        # open Presentation generated logfile
        logfile = open(f'./s{subj}/{subj}_{run}_C.log', 'r').read().splitlines() # read the file, split by line, and remove extraneous whitespace.
        log = logfile[5:378] # get rid of extra lines
        
        # split each line by spaces
        logtable = [line.split('\t') for line in log]
        
        df = pd.DataFrame(logtable)
        df.columns = logfile[3].split('\t')
        
        # open Presentation logfile created by me
        logfile2 = open(f'./s{subj}/{subj}_{run}_C_logfile.txt', 'r').read().splitlines() # read the file, split by line, and remove extraneous whitespace.
        logtable2 = [line.split('\t') for line in logfile2[1:]]
        
        df2 = pd.DataFrame(logtable2)
        df2.columns = logfile2[0].split('\t')
        
        #create time onset column
        df2['PictureOnset'] = 0
        # find times at which picture presented
        for n in range(0,len(df2)):
            df2['PictureOnset'][n] = df.Time[df.Code == 'picture'].iloc[n]
            df2['PictureOnset'][n] = df2['PictureOnset'][n] - int(df['Time'][7]) # time - time of first pulse(i.e. 5th)
            df2['PictureOnset'][n] = df2['PictureOnset'][n]/10
        
        #df.to_csv('/project/3011226.01/raw/sub-005/ses-mri01/behavioural/{subj}_{run}_C.txt', sep='\t', mode='a')
        df2.to_csv(f'{behavdir}s{subj}/{subj}_{run}_C.csv', index=False)
    
    
    # PRODUCTION
    for i in range(1,9):
        run = str(i)
        # open Presentation generated logfile
        logfile = open(f'./s{subj}/{subj}_{run}_P.log', 'r').read().splitlines() # read the file, split by line, and remove extraneous whitespace.
        log = logfile[5:378] # get rid extra lines
        
        # split each line by spaces
        logtable = [line.split('\t') for line in log]
        
        df = pd.DataFrame(logtable)
        df.columns = logfile[3].split('\t')
        
        # open Presentation logfile created by me
        logfile2 = open(f'./s{subj}/{subj}_{run}_P_logfile.txt', 'r').read().splitlines() # read the file, split by line, and remove extraneous whitespace.
        logtable2 = [line.split('\t') for line in logfile2[1:]]
        
        df2 = pd.DataFrame(logtable2)
        df2.columns = logfile2[0].split('\t')
        
        #create time onset column
        df2['PictureOnset'] = 0
        # find times at which picture presented
        for n in range(0,len(df2)):
            df2['PictureOnset'][n] = df.Time[df.Code == 'picture'].iloc[n]
            df2['PictureOnset'][n] = df2['PictureOnset'][n] - int(df['Time'][7]) # time - time of first pulse(i.e. 5th)
            df2['PictureOnset'][n] = df2['PictureOnset'][n]/10
        
        #df.to_csv('/project/3011226.01/raw/sub-005/ses-mri01/behavioural/{subj}_{run}_C.txt', sep='\t', mode='a')
        df2.to_csv(f'{behavdir}s{subj}/{subj}_{run}_P.csv', index=False)
        


