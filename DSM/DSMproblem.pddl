(define (problem simplevoltageprob)
(:domain simplevoltage)
(:init
    (begin)
    (p)
    (at 0.1 (not(begin)))
    (is-not-increasing)
    (is-not-decreasing)
    (peak)
    (=(lb)40)
    (=(ub)100)
    (=(battery-soc-adj)70)
    (=(grid)0)
    (=(base_load)0)
    (=(controlled_load)0)
    (=(uncontrolled_load)0)
    
    (at 1 (bl))
    (at 1 (= (base_load) 40))

    ;(at 3.0 (= (battery-soc-bg) 32))


    (at 3 (bl))
    (at 3 (= (base_load) 40))

    (at 6 (bl))
    (at 6 (= (base_load) 40))

    (at 24(horizon))
)

(:goal(and (done)

)
)



)