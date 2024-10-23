(define (problem starbonds_large) (:domain ChemicalMod)
(:objects
h1 - hydrogen
h2 - hydrogen
h3 - hydrogen
h4 - hydrogen
h5 - hydrogen
h6 - hydrogen
h7 - hydrogen
h8 - hydrogen
h9 - hydrogen
h10 - hydrogen
)
(:init
(doublebond h1 h10)
(doublebond h10 h1)
(doublebond h2 h10)
(doublebond h10 h2)
(doublebond h3 h10)
(doublebond h10 h3)
(doublebond h4 h10)
(doublebond h10 h4)
(doublebond h5 h10)
(doublebond h10 h5)
(doublebond h6 h10)
(doublebond h10 h6)
(doublebond h7 h10)
(doublebond h10 h7)
(doublebond h8 h10)
(doublebond h10 h8)
(doublebond h9 h10)
(doublebond h10 h9)
)
(:goal
(and
(not(doublebond h1 h10))
(not(doublebond h10 h1))
(bond h1 h10)
(bond h10 h1)
(not(doublebond h2 h10))
(not(doublebond h10 h2))
(bond h2 h10)
(bond h10 h2)
(not(doublebond h3 h10))
(not(doublebond h10 h3))
(bond h3 h10)
(bond h10 h3)
(not(doublebond h4 h10))
(not(doublebond h10 h4))
(bond h4 h10)
(bond h10 h4)
(not(doublebond h5 h10))
(not(doublebond h10 h5))
(bond h5 h10)
(bond h10 h5)
(not(doublebond h6 h10))
(not(doublebond h10 h6))
(bond h6 h10)
(bond h10 h6)
(not(doublebond h7 h10))
(not(doublebond h10 h7))
(bond h7 h10)
(bond h10 h7)
(not(doublebond h8 h10))
(not(doublebond h10 h8))
(bond h8 h10)
(bond h10 h8)
(not(doublebond h9 h10))
(not(doublebond h10 h9))
(bond h9 h10)
(bond h10 h9)
))
)
