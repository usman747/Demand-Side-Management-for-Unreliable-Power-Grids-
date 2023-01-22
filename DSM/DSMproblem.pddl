(define (problem simplevoltageprob)
(:domain simplevoltage)
(:init
    (begin)
    (p)
    (at 0.1 (not(begin)))
    (is-not-increasing)
    (is-not-decreasing)
    (=(lb)40)
    (=(ub)100)

    (=(battery-soc-bg)80)
    (=(grid)5)
    (=(var)5)
    (=(base-load)0)
    
    (at 6 (=(battery-soc-bg)80))
    (at 8 (=(battery-soc-bg)110))
    (at 12 (=(battery-soc-bg)50))
    (at 14 (=(battery-soc-bg)40))
    (at 15 (=(battery-soc-bg)90))
    (at 17 (= (var) 15))
    (at 17 (= (grid) 10))
    (at 18 (off-peak))
    ;(at 17 (=(battery-soc-bg)100))
    (at 24(horizon))
)

(:goal(and (done)
)
)

;(:metric minimize (base-load))

)