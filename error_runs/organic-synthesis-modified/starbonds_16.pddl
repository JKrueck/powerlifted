(define (problem starbonds_16) (:domain ChemicalMod)
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
h12 - hydrogen
h13 - hydrogen
h14 - hydrogen
h15 - hydrogen
h16 - hydrogen
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
(doublebond h1 h16)
(doublebond h2 h16)
(doublebond h3 h16)
(doublebond h4 h16)
(doublebond h5 h16)
(doublebond h6 h16)
(doublebond h7 h16)
(doublebond h8 h16)
(doublebond h9 h16)
(doublebond h10 h16)
(doublebond h11 h16)
(doublebond h12 h16)
(doublebond h13 h16)
(doublebond h14 h16)
(doublebond h15 h16)
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
(removedDoubleBond h1 h16)
(bond h1 h16)
(removedDoubleBond h2 h16)
(bond h2 h16)
(removedDoubleBond h3 h16)
(bond h3 h16)
(removedDoubleBond h4 h16)
(bond h4 h16)
(removedDoubleBond h5 h16)
(bond h5 h16)
(removedDoubleBond h6 h16)
(bond h6 h16)
(removedDoubleBond h7 h16)
(bond h7 h16)
(removedDoubleBond h8 h16)
(bond h8 h16)
(removedDoubleBond h9 h16)
(bond h9 h16)
(removedDoubleBond h10 h16)
(bond h10 h16)
(removedDoubleBond h11 h16)
(bond h11 h16)
(removedDoubleBond h12 h16)
(bond h12 h16)
(removedDoubleBond h13 h16)
(bond h13 h16)
(removedDoubleBond h14 h16)
(bond h14 h16)
(removedDoubleBond h15 h16)
(bond h15 h16)
))
)
