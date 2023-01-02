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
(enable) (horizon))



(:functions
(bgvoltage)
(voltage-adj)
(lb)
(ub)
)

; (:action finish
; :parameters()
; :precondition(r)
; :effect(done))

(:durative-action increasevoltage
:parameters()
:duration (=?duration 1)
:condition(and (at start(p))
         (at start(enable))
)
:effect(and
(at end(increase (voltage-adj) 2))
(at start(not(p)))
(at end(p))

))

(:durative-action decreasevoltage
:parameters()
:duration (=?duration 1)
:condition(and (at start(p))
        (at start(enable))
        ;(at start (>= (+ (bgvoltage) (voltage-adj)) (ub)))
        ;(over all (<= (+ (bgvoltage) (voltage-adj)) (lb)))
)
:effect(and
(at end(decrease (voltage-adj) 2))
(at start(not(p)))
(at end(p))
))


(:durative-action check
:parameters()
:duration (<= ?duration 101)
:condition(and
    (at start(begin))
    (over all (>= (+ (bgvoltage) (voltage-adj)) (lb)))
    (over all  (<= (+ (bgvoltage) (voltage-adj))(ub)))
   (at end (horizon))
   
   )

:effect(and
(at start(enable))
(at start (not (begin)))
(at end(done)))
)
)