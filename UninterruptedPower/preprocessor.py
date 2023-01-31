import pandas as pd 
import math
import numpy as np


df = pd.read_excel('TotalLoadperHour.xlsx')


column = df['PowerUsage']
column.index = np.arange(1,len(column)+1)


soc_decrement_per_hour = (column / 20)* 100




print(soc_decrement_per_hour)
