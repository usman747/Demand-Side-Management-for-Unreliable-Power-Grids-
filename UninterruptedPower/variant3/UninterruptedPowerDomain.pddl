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
(is_decreasing)(is_increasing)
(is-not-decreasing)(is-not-increasing)
(peak) (off_peak) (blackout)
(is_not_blackout)
)



(:functions
(battery_soc)
(battery-soc-fix)
(lb)(ub)
(charging_rate)
(cheap_priority_provider)
(blackouts_in_a_day)
)


(:durative-action chargeBatteryCheaply
:parameters()
:duration (=?duration 1)
:condition(and 
         (at start(enable))
         (at start (is-not-decreasing))
         (over all (off_peak))
         (over all (is_not_blackout))
         (at end (<= (+ (battery_soc) (battery-soc-fix)) (ub)))
         ;IMP line above, other wise charges above 100,
         ;then discharges

         ;(at start (< (battery-soc) (lb)))  
         ) 
:effect(and
(at end (increase (battery-soc-fix) 10))
;(increase (battery-soc-fix) (* #t (charging_rate)) )
(at end (increase (cheap_priority_provider) 1))


;COMMENTED below, otherwise it runs releaseCharging,
;and tries to go towards discharging
(at start (not(is-not-increasing)))
(at end (is_increasing))
))


(:durative-action chargeBatteryExpensively
:parameters()
:duration (=?duration 1)
:condition(and 
         (at start(enable))
         (at start (is-not-decreasing))
         (over all (peak))
         (over all (is_not_blackout))
         (at start (>= (cheap_priority_provider) 7))
         
         ;(at start (< (battery-soc) (lb)))
         ;(at end (< (+ (battery_soc) (battery-soc-fix)) (ub)))
)
:effect(and
(at end (increase (battery-soc-fix) 10))
;(increase (battery-soc-fix) (* #t (charging_rate)) )
(at start (not(is-not-increasing)))
;(at start (assign (battery-soc-fix) 0))
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
