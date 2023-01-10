(define (domain simplevoltage)
(:requirements
   :strips
   :fluents
   :durative-actions
   :timed-initial-literals
   :constraints
   :duration-inequalities
)

(:predicates(done)(p)(r)(begin)
(enable) (horizon) 
(is-decreasing)(is-increasing)
(is-not-decreasing)(is-not-increasing)
)



(:functions
(bgvoltage)
(voltage-adj)
(lb)
(ub)
(var)
)

; (:action finish
; :parameters()
; :precondition(r)
; :effect(done))

(:durative-action increasevoltage
:parameters()
:duration (=?duration 0.1)
:condition(and (at start(p))
         (at start(enable))
         (at start (is-not-decreasing))
)
:effect(and
(at end(increase (voltage-adj) 1))
(at start(not(p)))
(at end(p))
(at start (not(is-not-increasing)))
(at end (is-increasing))

))

(:durative-action decreasevoltage
:parameters()
:duration (=?duration 0.1)
:condition(and (at start(p))
        (at start(enable))
        (at start (is-not-increasing))
        ;(at start (>= (+ (bgvoltage) (voltage-adj)) (ub)))
        ;(over all (<= (+ (bgvoltage) (voltage-adj)) (lb)))
)
:effect(and
(at end(decrease (voltage-adj) 1))
(at start(not(p)))
(at end(p))
(at start (not(is-not-decreasing)))
(at end (is-decreasing))
))


(:durative-action releaseDecreasing
:parameters()
:duration (=?duration 3)
:condition(and 
   (at start(p))
   (at start(enable))
   (at start(is-decreasing))
)
:effect(and
(at start(not (is-decreasing)))
(at end(is-not-decreasing))
(at start(not(p)))
(at end(p))
(at end(done))
))


(:durative-action releaseIncreasing
:parameters()
:duration (=?duration 3)
:condition(and 
   (at start(is-increasing))
   (at start(p))
   (at start(enable))
)
:effect(and
(at end(is-not-increasing))
(at start(not (is-increasing)))
(at start(not(p)))
(at end(p))
(at end(done))
))

; (:durative-action voltageSame
; :parameters()
; :duration (=?duration 0.01)
; :condition(and (at start(p))
;         (at start(enable))
;         (over all (>= (+ (bgvoltage) (voltage-adj)) (lb)))
;         (over all (<= (+ (bgvoltage) (voltage-adj)) (ub)))
; )
; :effect(and
; (at end(increase (var) 1))
; (at start(not(p)))
; (at end(p))
; ))


(:durative-action check
:parameters()
:duration (<= ?duration 100)
:condition(and
   (at start(begin))
   (at end (horizon))
   (over all (and   
   (<= (+ (bgvoltage) (voltage-adj)) (ub))
   (>= (+ (bgvoltage) (voltage-adj)) (lb))
   ))
)
   ;(over all (>= (+ (bgvoltage) (voltage-adj)) (lb)))
   ;(over all (<= (+ (bgvoltage) (voltage-adj)) (ub)))
   ;)

:effect(and
(at start(enable))
(at start (not (begin)))
(at end(done)))
)
)