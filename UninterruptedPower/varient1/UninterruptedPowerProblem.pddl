(define (problem UnInterruptedPowerProblem)
(:domain UnInterruptedPower)
(:init
    (begin)
    (at 0.1 (not(begin)))
    (is-not-increasing)
    (is-not-decreasing)
    
    (=(lb)40)
    (=(ub)100)
    (=(battery_soc)70)
    (=(charging_rate)20)
    (=(cheap_priority_provider)0)

    (at 0.1 (off_peak))
    (at 0.1 (is_not_blackout))

    (at 1.0 (= (battery_soc) 70))
    (at 2.0 (= (battery_soc) 70))
    (at 3.0 (= (battery_soc) 70))
    
    (at 4.0 (not(is_not_blackout))); POWER OUTAGE 
    (at 5.0 (is_not_blackout))
    (at 5.01 (= (battery_soc) 56.85))    

    (at 6.0 (= (battery_soc) 56.85))
    (at 7.0 (= (battery_soc) 56.85))
    (at 8.0 (= (battery_soc) 56.85))


    (at 9.0 (not(is_not_blackout))); POWER OUTAGE 
    (at 10.0 (is_not_blackout))
    (at 10.01 (= (battery_soc) 50.40))   
    

    (at 11.0 (= (battery_soc) 50.40))
    (at 12.0 (= (battery_soc) 50.40))
    (at 13.0 (= (battery_soc) 50.40))


    (at 14.0 (not(is_not_blackout))); POWER OUTAGE 
    (at 15.0 (is_not_blackout))
    (at 15.01 (= (battery_soc) 39.58))  


    (at 16.0 (= (battery_soc) 39.58))
    (at 17.0 (= (battery_soc) 39.58))


    (at 17.99 (not(off_peak)))
    (at 18.0 (peak))
    (at 18.0 (= (battery_soc) 33.53))
    (at 19.0 (= (battery_soc) 23.05))
    (at 20.0 (= (battery_soc) 4.26))
    (at 21.0 (= (battery_soc) -10.3))
    (at 22.0 (= (battery_soc) -20.66))
    (at 23.00 (not(peak)))
    (at 23.01 (off_peak))


    (at 24(day_ended))
)

(:goal(and (complete)
)
)


)
