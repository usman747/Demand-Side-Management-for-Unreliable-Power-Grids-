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
(is_decreasing)(is_increasing)
(is-not-decreasing)(is-not-increasing)
(peak) (off_peak) (s_action) (cost)
(end) (bl) (cl) (ucl)
)



(:functions
(battery-soc-bg)
(battery-soc-adj)
(lb)(ub)
(temp) (var) (cost) (grid) 
(peak_rate) (off_peak_rate)
(base_load) (controlled_load) (uncontrolled_load)
)


(:durative-action chargeBattery
:parameters()
:duration (=?duration 0.5)
:condition(and 
         (at start(enable))
         (at start (is-not-decreasing))
         ;(at start (off_peak))
         ;(at start (< (battery-soc) (lb)))
         ;(at start (< (+ (bgvoltage) (voltage-adj)) (ub)))
)
:effect(and
(at end(increase (battery-soc-adj) 10))
(at start (not(is-not-increasing)))
(at end (is_increasing))

))

; (:durative-action dischargeBattery
; :parameters()
; :duration (=?duration 0.1)
; :condition(and (at start(p))
;         (at start(enable))
;         (at start (is-not-increasing))
;         ;(at start (> (voltage-adj) (lb)))
;        ; (at start (> (+ (bgvoltage) (voltage-adj)) (lb)))
; )
; :effect(and
; (at end(decrease (battery-soc-adj) 10))
; (at start(not(p)))
; (at end(p))
; (at start (not(is-not-decreasing)))
; (at end (is-decreasing))
; ))


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

; (:action action_name
;     :parameters ()
;     :precondition (and    
;     (enable)
;     ;(s-action)
;     (>= (base-load) 10)
;     ;(>= (base-load) 25)
;     )
;     :effect (and 
;        (increase (var) 10)
;        (done)
; )
; )

(:durative-action runBaseLoad-OffPeak
    :parameters ()
    :duration (= ?duration 0.5)
    :condition (and 
        (at start (enable))
        ;(at start (off_peak))
        (at start (is-not-increasing))
        (at start (bl))
    )
:effect(and
(at end (decrease (battery-soc-adj) (base_load)))
(at start (not(is-not-decreasing)))
(at end (is_decreasing))
(at end (not(bl)))

;(at end (done))
;(at end (s-action))
))


; (:durative-action runControlledLoad-OffPeak
;     :parameters ()
;     :duration (= ?duration 0.5)
;     :condition (and 
;         (at start (enable))
;         (at start (off_peak))
;         (at start (is-not-increasing))
;     )
; :effect(and
; (at end (increase (grid) (controlled_load)))
; (at start (not(is-not-decreasing)))
; (at end (is_decreasing))

; ;(at end (done))
; ))


; (:durative-action runUnControlledLoad-OffPeak
;     :parameters ()
;     :duration (= ?duration 0.5)
;     :condition (and 
;         (at start (enable))
;         (at start (off_peak))
;         (at start (is-not-increasing))
;     )
; :effect(and
; (at end (increase (grid) (uncontrolled_load)))
; (at start (not(is-not-decreasing)))
; (at end (is_decreasing))

; ;(at end (done))
; ))


(:durative-action check
:parameters()
:duration (<= ?duration 100)
:condition(and
   (at start(begin))
   (at end (horizon))
   (over all (and   
   ;(<= (+ (battery-soc-bg) (battery-soc-adj)) (ub))
   ;(>= (+ (battery-soc-bg) (battery-soc-adj)) (lb))
   (<=  (battery-soc-adj) (ub))
   (>=  (battery-soc-adj) (lb))
   ))
)

:effect(and
(at start(enable))
(at end(done)))
)






; (:durative-action runBaseLoad-Peak
;     :parameters ()
;     :duration (= ?duration 0.5)
;     :condition (and 
;         (at start (enable))
;         (at start (peak))
;         (at start (is-not-increasing))
;         (at start (bl))
;     )
; :effect(and
; (at end (decrease (battery-soc-adj) 5))
; (at start (not(is-not-decreasing)))
; (at end (is_decreasing))
; (at end (not(bl)))
; ;In future -> (at end (decrease (battery-soc-adj) (base_load)))
; ))


; (:durative-action runControlledLoad-Peak
;     :parameters ()
;     :duration (= ?duration 0.5)
;     :condition (and 
;         (at start (enable))
;         (at start (peak))
;         (at start (is-not-increasing))
;         (at start (cl))
;     )
; :effect(and
; (at end (decrease (battery-soc-adj) 10))
; (at end (increase (grid) 10))
; (at start (not(is-not-decreasing)))
; (at end (is_decreasing))
; (at end (not(cl)))
; ;(at end (decrease (battery-soc-adj) (controlled_load * 0.5)))
; ;(at end (increase (grid) (controlled_load * 0.5)))
; ))


; (:durative-action runUnControlledLoad-Peak
;     :parameters ()
;     :duration (= ?duration 0.5)
;     :condition (and 
;         (at start (enable))
;         (at start (peak))
;         (at start (is-not-increasing))
;         (at start (ucl))
;     )
; :effect(and
; (at end (increase (grid) (uncontrolled_load)))
; (at start (not(is-not-decreasing)))
; (at end (is_decreasing))
; (at end (not(ucl)))
; ;(at end (decrease (battery-soc-adj) (controlled_load )))
; ))





)