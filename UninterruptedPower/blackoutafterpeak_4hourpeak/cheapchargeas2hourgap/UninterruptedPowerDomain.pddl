(define (domain UnInterruptedPower)
(:requirements
   :strips
   :fluents
   :numeric-fluents
   :durative-actions
   :timed-initial-literals
   :constraints
   :duration-inequalities

   :universal-preconditions
   :disjunctive-preconditions
   :conditional-effects
   :preferences
)

(:predicates(complete)(begin)
(enable) (day_ended) 
(peak) (off_peak) (blackout)
(is_not_blackout) (charging_now)
)



(:functions
(battery_soc)
(battery-soc-fix)
(lower_limit)(upper_limit)
(charging_rate)
(cheap_priority_level)
(priority_value)
)


(:durative-action chargeBatteryCheaply
:parameters()
:duration (=?duration 0.33)
:condition(and 
         (at start(enable))
         (at start (charging_now))
         (over all (off_peak))
         (over all (is_not_blackout))
         (at end (<= (+ (battery_soc) (battery-soc-fix)) (upper_limit)))
         ;IMP line above, other wise charges above 100,
         ;then discharges
         ) 
:effect(and
(at end (increase (battery-soc-fix) charging_rate))
(at end (increase (cheap_priority_level) 1))
(at start (not (charging_now)))
(at end (charging_now))
))


(:durative-action chargeBatteryExpensively
:parameters()
:duration (=?duration 1)
:condition(and 
         (at start(enable))
         (at start (charging_now))
         (over all (peak))
         (over all (is_not_blackout))
         (at start (>= (cheap_priority_level) priority_value))
         ;(at end (< (+ (battery_soc) (battery-soc-fix)) (upper_limit)))
)
:effect(and
(at end (increase (battery-soc-fix) charging_rate))
(at start (not (charging_now)))
(at end (charging_now))

))



(:durative-action DayAheadPlan 
:parameters()
:duration (<= ?duration 100)
:condition(and
   (at start(begin))
   (at end (day_ended))
   (over all (and   
   (<= (+ (battery_soc) (battery-soc-fix)) (upper_limit))
   (>= (+ (battery_soc) (battery-soc-fix)) (lower_limit))
   ))
)

:effect(and
(at start(enable))
(at end(complete)))
)








)
