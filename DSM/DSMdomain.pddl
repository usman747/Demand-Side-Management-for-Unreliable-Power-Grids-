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
 (off_peak) (charging_now)
)



(:functions
(battery_soc)
(battery-soc-fix)
(lower_limit)(upper_limit)
(charging_rate)
)


(:durative-action chargeBattery
:parameters()
:duration (=?duration 0.33)
:condition(and 
         (at start(enable))
         (over all (off_peak))
         (at start (charging_now))
)
:effect(and
(at end (increase (battery-soc-fix) charging_rate))
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