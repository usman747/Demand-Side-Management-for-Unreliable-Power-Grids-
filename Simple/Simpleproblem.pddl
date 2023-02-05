(define (problem SimpleWithBattery)
(:domain SimpleWithBattery)
(:init
    (begin)
    (at 0.1 (not(begin)))
    
    (=(lower_limit)40)
    (=(upper_limit)100)
    (=(battery_soc)70)

    (at 1.0 (= (battery_soc) 70))
    (at 2.0 (= (battery_soc) 70))
    (at 3.0 (= (battery_soc) 70))
    (at 4.0 (= (battery_soc) 70))
    (at 5.0 (= (battery_soc) 70))
    (at 6.0 (= (battery_soc) 70))
    (at 7.0 (= (battery_soc) 70))
    (at 8.0 (= (battery_soc) 70))
    (at 9.0 (= (battery_soc) 70))
    (at 10.0 (= (battery_soc) 70))
    (at 11.0 (= (battery_soc) 70))
    (at 12.0 (= (battery_soc) 70))
    (at 13.0 (= (battery_soc) 70))
    (at 14.0 (= (battery_soc) 70))
    (at 15.0 (= (battery_soc) 70))
    (at 16.0 (= (battery_soc) 70))
    (at 17.0 (= (battery_soc) 70))
    (at 18.0 (= (battery_soc) 70))

    (at 19.0 (= (battery_soc) 63.95))
    (at 20.0 (= (battery_soc) 53.47))
    (at 21.0 (= (battery_soc) 34.68))
    (at 22.0 (= (battery_soc) 21.19))
    (at 23.0 (= (battery_soc) 10.36))

    (at 24(day_ended))
)

(:goal(and (complete)
)
)


)
