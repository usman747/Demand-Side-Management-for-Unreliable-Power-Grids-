(define (domain DSM)
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
(peak) (off_peak) (charging_now)
)



(:functions
(battery_soc)
(battery-soc-fix)
(lower_limit)(upper_limit)

)


(:durative-action chargeBattery
:parameters()
:duration (=?duration 1)
:condition(and 
         (at start(enable))
         (over all (off_peak))
         (at start (charging_now))
)
:effect(and
(at end (increase (battery-soc-fix) 10))
(at start (not(charging_now)))
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