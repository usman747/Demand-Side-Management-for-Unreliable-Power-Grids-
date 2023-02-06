import pandas as pd 
import math
import numpy as np

battery_size = 20
blackout_case = 1
soc_at_start = 70
priority_value = 6
charging_rate = 10


soc_at1, soc_at2, soc_at3, soc_at4, soc_at5, soc_at6, soc_at7, soc_at8 = 0,0,0,0,0,0,0,0
soc_at9, soc_at10, soc_at11, soc_at12, soc_at13, soc_at14, soc_at15, soc_at16 = 0,0,0,0,0,0,0,0
soc_at17, soc_at18, soc_at19, soc_at20, soc_at21, soc_at22, soc_at23, soc_at24 = 0,0,0,0,0,0,0,0


df = pd.read_excel('TotalLoadperHour.xlsx')


column = df['PowerUsage']
column.index = np.arange(1,len(column)+1)

soc_decrement_per_hour = (column / battery_size)* 100
# soc_decrement_per_hour = round(soc_decrement_per_hour,2)
#print(soc_decrement_per_hour)



def socUpdate_case1():

    global soc_at1, soc_at2, soc_at3, soc_at4, soc_at5, soc_at6, soc_at7, soc_at8
    global soc_at9, soc_at10, soc_at11, soc_at12, soc_at13, soc_at14, soc_at15, soc_at16
    global soc_at17, soc_at18, soc_at19, soc_at20, soc_at21, soc_at22, soc_at23, soc_at24
    soc_at1 = soc_at_start
    soc_at2 = soc_at_start
    soc_at3 = soc_at_start
    soc_at4 = soc_at_start
    soc_at5 = soc_at_start - soc_decrement_per_hour[4]
    soc_at6 = soc_at5
    soc_at7 = soc_at5
    soc_at8 = soc_at5
    soc_at9 = soc_at5
    soc_at10 = soc_at9 - soc_decrement_per_hour[9]
    soc_at11 = soc_at10
    soc_at12 = soc_at10
    soc_at13 = soc_at10
    soc_at14 = soc_at10
    soc_at15 = soc_at14 - soc_decrement_per_hour[14]
    soc_at16 = soc_at15
    soc_at17 = soc_at15
    soc_at18 = soc_at15
    soc_at19 = soc_at18 - soc_decrement_per_hour[18]
    soc_at20 = soc_at19 - soc_decrement_per_hour[19]
    soc_at21 = soc_at20 - soc_decrement_per_hour[20]
    soc_at22 = soc_at21 - soc_decrement_per_hour[21]
    soc_at23 = soc_at22 - soc_decrement_per_hour[22]







socUpdate_case1()
# print(soc_at22)





def write_pddl_problem_file(problem_name, init, goal):
    problem_file = open(problem_name + ".pddl", "w")
    problem_file.write("(define (problem " + problem_name + ")\n")
    problem_file.write("(:domain UnInterruptedPower)\n")
    problem_file.write("(:init\n")
    for fact in init:
        problem_file.write("  " + fact + "\n")
    problem_file.write(")\n")
    problem_file.write("(:goal\n")
    problem_file.write("  (and\n")
    for cond in goal:
        problem_file.write("    " + cond + "\n")
    problem_file.write("  )\n")
    problem_file.write(")\n")
    problem_file.write(")\n")
    problem_file.close()

# Example usage:
problem_name = "UnInterruptedPowerProblem"
init = ["(begin)", 
        "(at 0.1 (not(begin)))", 
        "(is-not-increasing)", 
        "(is-not-decreasing)", 
        "(charging_now)",
        "(=(lower_limit)40)", 
        "(=(upper_limit)100)",
        "(=(battery_soc)70)", 
        "(=(charging_rate)"+ str(charging_rate) + ")",
        "(=(cheap_priority_level)0)",
        "(=(priority_value)"+ str(priority_value) + ")",
        " ",
        "(at 0.1 (off_peak))",
        "(at 0.1 (is_not_blackout))", 
        "(at 1.0 (= (battery_soc)" + str(soc_at1) + "))", 
        "(at 2.0 (= (battery_soc)" + str(soc_at2) + "))", 
        "(at 3.0 (= (battery_soc)" + str(soc_at3) + "))", 
        "(at 4.0 (= (battery_soc)" + str(soc_at4) + "))", 
         " ",       
        "(at 4.0 (not(is_not_blackout))) ;POWER OUTAGE", 
        "(at 5.0 (is_not_blackout))",
        "(at 5.0 (= (battery_soc)" + str(soc_at5) + "))", 
        " ",
        "(at 6.0 (= (battery_soc) " + str(soc_at6) + "))", 
        "(at 7.0 (= (battery_soc) " + str(soc_at7) + "))", 
        "(at 8.0 (= (battery_soc) " + str(soc_at8) + "))", 
        "(at 9.0 (= (battery_soc) " + str(soc_at9) + "))", 
        " ",
        "(at 9.0 (not(is_not_blackout))) ;POWER OUTAGE",
        "(at 10.0 (is_not_blackout))", 
        "(at 10.0 (= (battery_soc)" + str(soc_at10) + "))", 
        " ",
        "(at 11.0 (= (battery_soc) " + str(soc_at11) + "))", 
        "(at 12.0 (= (battery_soc) " + str(soc_at12) + "))", 
        "(at 13.0 (= (battery_soc) " + str(soc_at13) + "))",
        "(at 14.0 (= (battery_soc) " + str(soc_at14) + "))", 
        " ",
        "(at 14.0 (not(is_not_blackout))) ;POWER OUTAGE", 
        "(at 15.0 (is_not_blackout))", 
        "(at 15.0 (= (battery_soc) " + str(soc_at15) + "))", 
        " ",
        "(at 16.0 (= (battery_soc) " + str(soc_at16) + "))", 
        "(at 17.0 (= (battery_soc) " + str(soc_at17) + "))",
        "(at 18.0 (= (battery_soc) " + str(soc_at18) + "))", 
        " ",
        "(at 17.98 (not(off_peak)))",
        "(at 17.99 (peak))", 
        "(at 19.0 (= (battery_soc)" + str(soc_at19) + "))",
        "(at 20.0 (= (battery_soc)" + str(soc_at20) + "))",
        "(at 21.0 (= (battery_soc)" + str(soc_at21) + "))",
        "(at 22.0 (= (battery_soc)" + str(soc_at22) + "))",
        "(at 23.0 (= (battery_soc)" + str(soc_at23) + "))",
        "(at 23.01 (not(peak)))",
        "(at 23.02 (off_peak))",
        " ",
        "(at 24 (day_ended))"    ]


goal = ["(complete)"]


write_pddl_problem_file(problem_name, init, goal)