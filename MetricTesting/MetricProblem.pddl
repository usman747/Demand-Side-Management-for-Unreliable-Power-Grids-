(define (problem simplevoltageprob)
(:domain simplevoltage)
(:init
    (=(temperature)20)
    (=(totalcost)0.0)
    (=(max)30)
    (=(min)10)
    (at 3.0 (off-peak))
    (at 4.0 (= (temperature) 35))
)

(:goal(and 
(< (temperature)(max))
(>(temperature)(min))
)
)

(:metric minimize 
(totalcost)
 ;(total-time)
 )

)