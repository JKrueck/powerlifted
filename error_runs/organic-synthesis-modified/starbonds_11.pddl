(define (problem starbonds_11) (:domain ChemicalMod)
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
h11 - hydrogen
l1 - large
l2 - large
l3 - large
l4 - large
l5 - large
l6 - large
l7 - large
l8 - large
l9 - large
l10 - large
l11 - large
l12 - large
l13 - large
l14 - large
l15 - large
)
(:init
(doublebond h1 h11)
(doublebond h2 h11)
(doublebond h3 h11)
(doublebond h4 h11)
(doublebond h5 h11)
(doublebond h6 h11)
(doublebond h7 h11)
(doublebond h8 h11)
(doublebond h9 h11)
(doublebond h10 h11)
(unnessecary1 l1 l2)
(unnessecary2 l2 l3)
(unnessecary3 l3 l4)
(unnessecary4 l4 l5)
(unnessecary5 l5 l6)
(unnessecary6 l6 l7)
(unnessecary7 l7 l8)
(unnessecary8 l8 l9)
(unnessecary9 l9 l10)
(unnessecary10 l10 l11)
(unnessecary11 l11 l12)
)
(:goal
(and
(removedDoubleBond h1 h11)
(bond h1 h11)
(removedDoubleBond h2 h11)
(bond h2 h11)
(removedDoubleBond h3 h11)
(bond h3 h11)
(removedDoubleBond h4 h11)
(bond h4 h11)
(removedDoubleBond h5 h11)
(bond h5 h11)
(removedDoubleBond h6 h11)
(bond h6 h11)
(removedDoubleBond h7 h11)
(bond h7 h11)
(removedDoubleBond h8 h11)
(bond h8 h11)
(removedDoubleBond h9 h11)
(bond h9 h11)
(removedDoubleBond h10 h11)
(bond h10 h11)
))
)
