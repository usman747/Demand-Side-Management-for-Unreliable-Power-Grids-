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
(is_decreasing)(is_increasing)
(is-not-decreasing)(is-not-increasing)
(peak) (off_peak)
)



(:functions
(battery_soc)
(battery-soc-fix)
(lb)(ub)
)


(:durative-action chargeBattery
:parameters()
:duration (=?duration 1)
:condition(and 
         (at start(enable))
         (at start (is-not-decreasing))
         (over all (off_peak))
)
:effect(and
(at end (increase (battery-soc-fix) 10))
(at start (not(is-not-increasing)))
(at end (is_increasing))

))

(:durative-action dischargeBattery
:parameters()
:duration (=?duration 0.5)
:condition(and 
        (at start(enable))
        (at start (is-not-increasing))
)
:effect(and
(at end(decrease (battery-soc-fix) 10))
(at start (not(is-not-decreasing)))
(at end (is_decreasing))
))


(:durative-action releaseDischarging
:parameters()
:duration (=?duration 0.1)
:condition(and 
   (at start(enable))
   (at start(is_decreasing))
)
:effect(and
(at start(not (is_decreasing)))
(at end(is-not-decreasing))
))


(:durative-action releaseCharging
:parameters()
:duration (=?duration 0.1)
:condition(and 
   (at start(is_increasing))
   (at start(enable))
)
:effect(and
(at end(is-not-increasing))
(at start(not (is_increasing)))
))




(:durative-action DayAheadPlan 
:parameters()
:duration (<= ?duration 100)
:condition(and
   (at start(begin))
   (at end (day_ended))
   (over all (and   
   (<= (+ (battery_soc) (battery-soc-fix)) (ub))
   (>= (+ (battery_soc) (battery-soc-fix)) (lb))
   ))
)

:effect(and
(at start(enable))
(at end(complete)))
)







)