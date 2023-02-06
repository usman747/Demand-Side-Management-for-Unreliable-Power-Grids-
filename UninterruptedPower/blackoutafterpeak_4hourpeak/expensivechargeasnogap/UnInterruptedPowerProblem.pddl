(define (problem UnInterruptedPowerProblem)
(:domain UnInterruptedPower)
(:init
  (begin)
  (at 0.1 (not(begin)))
  (is-not-increasing)
  (is-not-decreasing)
  (charging_now)
  (=(lower_limit)40)
  (=(upper_limit)100)
  (=(battery_soc)70)
  (=(charging_rate)10)
  (=(cheap_priority_level)0)
  (=(priority_value)6)
   
  (at 0.1 (off_peak))
  (at 0.1 (is_not_blackout))
  (at 1.0 (= (battery_soc)70))
  (at 2.0 (= (battery_soc)70))
  (at 3.0 (= (battery_soc)70))
  (at 4.0 (= (battery_soc)70))
   
  (at 4.0 (not(is_not_blackout))) ;POWER OUTAGE
  (at 5.0 (is_not_blackout))
  (at 5.0 (= (battery_soc)56.852175))
   
  (at 6.0 (= (battery_soc) 56.852175))
  (at 7.0 (= (battery_soc) 56.852175))
  (at 8.0 (= (battery_soc) 56.852175))
  (at 9.0 (= (battery_soc) 56.852175))
   
  (at 9.0 (not(is_not_blackout))) ;POWER OUTAGE
  (at 10.0 (is_not_blackout))
  (at 10.0 (= (battery_soc)50.4043333333))
   
  (at 11.0 (= (battery_soc) 50.4043333333))
  (at 12.0 (= (battery_soc) 50.4043333333))
  (at 13.0 (= (battery_soc) 50.4043333333))
  (at 14.0 (= (battery_soc) 50.4043333333))
   
  (at 14.0 (not(is_not_blackout))) ;POWER OUTAGE
  (at 15.0 (is_not_blackout))
  (at 15.0 (= (battery_soc) 39.5825666667))
   
  (at 16.0 (= (battery_soc) 39.5825666667))
  (at 17.0 (= (battery_soc) 39.5825666667))
  (at 18.0 (= (battery_soc) 39.5825666667))
   
  (at 17.98 (not(off_peak)))
  (at 17.99 (peak))
  (at 19.0 (= (battery_soc)33.5301083333))
  (at 20.0 (= (battery_soc)23.054725))
  (at 21.0 (= (battery_soc)4.26168333333))
  (at 22.0 (= (battery_soc)-10.2939583333))

  (at 22.01 (not(peak)))
  (at 22.02 (off_peak))
   
  (at 22.0 (not(is_not_blackout))) ;POWER OUTAGE
  (at 23.0 (is_not_blackout))
  (at 23.0 (= (battery_soc)-21.1253166667))


  (at 25 (day_ended))
)
(:goal
  (and
    (complete)
  )
)
)
