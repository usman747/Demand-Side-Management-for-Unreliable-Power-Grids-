(define (domain simplevoltage)
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

(:predicates(done)(p)(begin)
(enable) (horizon) 
(is-decreasing)(is-increasing)
(is-not-decreasing)(is-not-increasing)
(peak) (off-peak) (s-action)
(MUCH)
(LESS)

)



(:functions
(battery-soc-bg)
(battery-soc-adj)
(lb)
(ub)
(var)
(grid) (base-load)
(temp)
(controlled-load)
(off-peak-rate)
(totalcost)
(peak-rate)
(min)
(max)
(temperature)
)




; (:durative-action peakAction
;     :parameters ()
;     :duration (= ?duration 0.2)
;     :condition (and 
;         (at start (enable))
;         (at start (off-peak))
;     )
; :effect(and
; ;(at start  (assign (temp) (* (controlled-load) 20)))  
; ;(at end  (assign (cost) (+ (cost) (temp))))
; (at start (increase (cost) 20))
; (at end (done))

; ))


; (:durative-action OffPeakAction
;     :parameters ()
;     :duration (= ?duration 0.2)
;     :condition (and 
;         (at start (enable))
;         (at start (off-peak))
;     )
; :effect(and
; ;(at start  (assign (temp) (* (controlled-load) 10)))  
; ;(at end  (assign (cost) (+ (cost) (temp))))
; (at start (increase (cost) 10))
; (at end (done))
; ))





(:action HIGH
    :parameters ()
    :precondition (and
        (off-peak)
     )
    :effect (and 
        (increase (totalcost) 40)
        (increase (temperature) 5)
        (LESS)
    )
)


(:action LOW
    :parameters ()
    :precondition (and 
        (off-peak)
    )
    :effect (and 
        (increase (totalcost) 20)
        (decrease (temperature) 5)
        (MUCH)
 
    )
)

(:action LOWEST
    :parameters ()
    :precondition (and 
        (off-peak)
    )
    :effect (and 
        (increase (totalcost) 5)
        (decrease (temperature) 5)
        (MUCH)
 
    )
)


; (:durative-action LOW1
;     :parameters ()
;     :duration (= ?duration 1)
;     :condition (and 
;         (at start 
;             (off-peak)
;         )
;     )
;     :effect (and 
;         (at end (and 
;         (increase (totalcost) 20)
;         (decrease (temperature) 5)
;         ))
;     )
; )

; (:durative-action LOWEST1
;     :parameters ()
;     :duration (= ?duration 1)
;     :condition (and 
;         (at start (and 
;              (off-peak)
;         ))
;     )
;     :effect 
;         (at end (and 
;         (increase (totalcost) 5)
;         (decrease (temperature) 5)
;         ))
    
; )



)