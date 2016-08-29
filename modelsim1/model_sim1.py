# -*- coding: utf-8 -*-
"""
Created on Sun Aug 28 17:13:56 2016

@author: Charlie
"""

import numpy as np

print 'Running model...'

print 'Importing data...'
data = np.genfromtxt('many_numbers.csv', delimiter=',') #read in the data

print 'Calculating statistics...'
average_of_data = np.mean(data) #calculate average
stdev_of_data = np.std(data) #calculate standard deviation
median_of_data = np.median(data) #calculate median

print 'Writing statistics to file...'
with open("model_output.txt", "a") as f: 
                
    f.write('AVG: ' + str(average_of_data) + '\n' ) 
    f.write('STDEV: ' + str(stdev_of_data) + '\n' ) 
    f.write('MED: ' + str(median_of_data) + '\n' ) 

print 'Model complete.'