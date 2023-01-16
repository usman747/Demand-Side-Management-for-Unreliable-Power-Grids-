(define (domain simplevoltage)
(:requirements
   :strips
   :fluents
   :durative-actions
   :timed-initial-literals
   :constraints
   :duration-inequalities

   :universal-preconditions
   :disjunctive-preconditions
   :conditional-effects
   :preferences
)

(:predicates(done)(p)(begin)
(enable) (horizon) 
(is-decreasing)(is-increasing)
(is-not-decreasing)(is-not-increasing)
)



(:functions
(battery-soc-bg)
(battery-soc-adj)
(lb)
(ub)
(var)
)

; (:action finish
; :parameters()
; :precondition(r)
; :effect(done))

(:durative-action chargeBattery
:parameters()
:duration (=?duration 0.1)
:condition(and (at start(p))
         (at start(enable))
         (at start (is-not-decreasing))
         ;(at start (< (battery-soc) (lb)))
         ;(at start (< (+ (bgvoltage) (voltage-adj)) (ub)))
)
:effect(and
(at end(increase (battery-soc-adj) 10))
(at start(not(p)))
(at end(p))
(at start (not(is-not-increasing)))
(at end (is-increasing))

))

(:durative-action dischargeBattery
:parameters()
:duration (=?duration 0.1)
:condition(and (at start(p))
        (at start(enable))
        (at start (is-not-increasing))
        ;(at start (> (voltage-adj) (lb)))
       ; (at start (> (+ (bgvoltage) (voltage-adj)) (lb)))
)
:effect(and
(at end(decrease (battery-soc-adj) 10))
(at start(not(p)))
(at end(p))
(at start (not(is-not-decreasing)))
(at end (is-decreasing))
))


(:durative-action releaseDischarging
:parameters()
:duration (=?duration 3)
:condition(and 
   (at start(enable))
   (at start(is-decreasing))
)
:effect(and
(at start(not (is-decreasing)))
(at end(is-not-decreasing))
))


(:durative-action releaseCharging
:parameters()
:duration (=?duration 3)
:condition(and 
   (at start(is-increasing))
   (at start(enable))
)
:effect(and
(at end(is-not-increasing))
(at start(not (is-increasing)))
))

; (:action action_name
;     :parameters ()
;     :precondition (and    
;     (enable)
;     (horizon)
;     )
;     :effect (and 
;        (increase (var) 10)
; )
; )



(:durative-action check
:parameters()
:duration (<= ?duration 100)
:condition(and
   (at start(begin))
   (at end (horizon))
   (over all (and   
   (<= (+ (battery-soc-bg) (battery-soc-adj)) (ub))
   (>= (+ (battery-soc-bg) (battery-soc-adj)) (lb))
   ))
)

:effect(and
(at start(enable))
;(at start (not (begin)))
(at end(done)))
)
)