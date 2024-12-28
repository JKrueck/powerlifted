(define (problem starbonds1) (:domain ChemicalMod)
(:objects
h1 - hydrogen
h2 - hydrogen
h3 - hydrogen
h4 - hydrogen
h5 - hydrogen
)
(:init
(doublebond h1 h5)
(doublebond h2 h5)
(doublebond h3 h5)
(doublebond h4 h5)
(doublebond h5 h1)
(doublebond h5 h2)
(doublebond h5 h3)
(doublebond h5 h4)
)
(:goal
(and
(not(doublebond h1 h5))
(not(doublebond h2 h5))
(not(doublebond h3 h5))
(not(doublebond h4 h5))
(not(doublebond h5 h1))
(not(doublebond h5 h2))
(not(doublebond h5 h3))
(not(doublebond h5 h4))


(bond h1 h5)
(bond h2 h5)
(bond h3 h5)
(bond h4 h5)
(bond h5 h1)
(bond h5 h2)
(bond h5 h3)
(bond h5 h4)
))
)
