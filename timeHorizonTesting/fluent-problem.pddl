(define (problem simplevoltageprob)
(:domain simplevoltage)
(:init
    (begin)
    (p)
    ;(not (horizon))
    (at 0.1 (not(begin)))
    
    (is-not-increasing)
    (is-not-decreasing)

    (=(bgvoltage)15)
    (=(voltage-adj)0)
    (=(var)0)
    (=(lb)10)
    (=(ub)20)
    
    ;(at 3 (is-decreasing))

    
    (at 2 (=(bgvoltage)22))
    ;(at 5 ( =(bgvoltage)14)) ;does not work on less than 14 
    (at 8 ( =(bgvoltage)14))

    (at 12 ( =(bgvoltage)10))
    ;(at 15 ( =(bgvoltage)20))
   ; (at 9 ( =(bgvoltage)18))  ;24-2-2 is ok, but 25-2-2-2will take time to 7
    ;(at 8 ( =(bgvoltage)8))
    ;(at 7( =(bgvoltage)24))
    ;(at 8( =(bgvoltage)21))
    ;(at 9( =(bgvoltage)17))
    ;(at 8 (=(bgvoltage)10))
   (at 20(horizon))
)

(:goal(and (done)
;(=(voltage-adj)4)
)
)
)