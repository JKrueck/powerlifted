; The variants of the Organic Synthesis domain were created by
; Dr. Russell Viirre, Hadi Qovaizi, and Prof. Mikhail Soutchanski.
;
; This work is licensed under a Creative Commons Attribution,
; NonCommercial, ShareAlike 3.0 Unported License.
;
; For further information, please access the following web page:
; https://www.cs.ryerson.ca/~mes/publications/
(define (problem initialBonds10Arom) (:domain Chemical)
(:objects
; setup for problem 10 
c1 - carbon
c2 - carbon
c3 - carbon
c4 - carbon
h1 - hydrogen
h2 - hydrogen
o1 - oxygen
o2 - oxygen
o3 - oxygen
; the Diene 
c5 - carbon
c6 - carbon
c7 - carbon
c8 - carbon
c9 - carbon
c14 - carbon
h3 - hydrogen
h4 - hydrogen
h5 - hydrogen
h6 - hydrogen
h7 - hydrogen
h8 - hydrogen
h9 - hydrogen
h10 - hydrogen
h29 - hydrogen
h30 - hydrogen
h31 - hydrogen
; water_1
o50 - oxygen
h50 - hydrogen
h51 - hydrogen
; water_2
o51 - oxygen
h52 - hydrogen
h53 - hydrogen
; free oxygen
o52 - oxygen
; LiAlH4
li1 - lithium
al1 - aluminium
h25 - hydrogen
h11 - hydrogen
h12 - hydrogen
h13 - hydrogen
h14 - hydrogen
; Mercury(II) acetate 
c10 - carbon
c11 - carbon
c12 - carbon
c13 - carbon
o4 - oxygen
o5 - oxygen
o6 - oxygen
o7 - oxygen
hg1 - mercury
h15 - hydrogen
h16 - hydrogen
h17 - hydrogen
h18 - hydrogen
h19 - hydrogen
h20 - hydrogen
; Sodium borohydride 
na1 - sodium
b1 - boron
h21 - hydrogen
h22 - hydrogen
h23 - hydrogen
h24 - hydrogen
; second LiAlH4
li2 - lithium
al2 - aluminium
h26 - hydrogen
h27 - hydrogen
h28 - hydrogen
)
(:init
; setup for problem 10 
(bond o1 c1)
(bond o1 c2)
(bond c1 o1)
(bond c2 o1)
(doublebond o2 c1)
(doublebond o3 c2)
(doublebond c1 o2)
(doublebond c2 o3)
(bond c1 c3)
(bond c2 c4)
(bond c3 c1)
(bond c4 c2)
(doublebond c3 c4)
(doublebond c4 c3)
(bond h1 c3)
(bond h2 c4)
(bond c3 h1)
(bond c4 h2)
; the Diene 
(bond c5 c6)
(doublebond c6 c7)
(bond c7 c8)
(doublebond c8 c9)
(bond c6 c5)
(doublebond c7 c6)
(bond c8 c7)
(doublebond c9 c8)
(bond c8 c14)
(bond c14 c8)
(bond h3 c5)
(bond h4 c5)
(bond h5 c5)
(bond c5 h3)
(bond c5 h4)
(bond c5 h5)
(bond h6 c6)
(bond c6 h6)
(bond h7 c7)
(bond c7 h7)
(bond c9 h9)
(bond c9 h10)
(bond h9 c9)
(bond h10 c9)
(bond c14 h29)
(bond c14 h30)
(bond c14 h31)
(bond h29 c14)
(bond h30 c14)
(bond h31 c14)
; water_1
(bond o50 h50)
(bond h50 o50)
(bond o50 h51)
(bond h51 o50)
; water_2
(bond o51 h52)
(bond h52 o51)
(bond o51 h53)
(bond h53 o51)
; LiAlH4
(bond al1 h11)
(bond al1 h12)
(bond al1 h13)
(bond al1 h14)
(bond h11 al1)
(bond h12 al1)
(bond h13 al1)
(bond h14 al1)
; Mercury(II) acetate 
(bond c10 c11)
(bond c11 c10)
(bond h15 c10)
(bond h16 c10)
(bond h17 c10)
(bond c10 h15)
(bond c10 h16)
(bond c10 h17)
(doublebond c11 o4)
(doublebond o4 c11)
(bond c11 o5)
(bond o5 c11)
(bond o5 hg1)
(bond hg1 o5)
(bond c12 c13)
(bond c13 c12)
(bond h18 c12)
(bond h19 c12)
(bond h20 c12)
(bond c12 h18)
(bond c12 h19)
(bond c12 h20)
(doublebond c13 o6)
(doublebond o6 c13)
(bond c13 o7)
(bond o7 c13)
(bond o7 hg1)
(bond hg1 o7)
; Sodium borohydride 
(bond b1 h21)
(bond b1 h22)
(bond b1 h23)
(bond b1 h24)
(bond h21 b1)
(bond h22 b1)
(bond h23 b1)
(bond h24 b1)
; second LiAlH4
(bond al2 h25)
(bond al2 h26)
(bond al2 h27)
(bond al2 h28)
(bond h25 al2)
(bond h26 al2)
(bond h27 al2)
(bond h28 al2)
)
(:goal
(and
(bond c3 c1)
(bond c1 o2)
(bond c3 c6)
(bond c6 c5)
(bond c6 c7)
(bond c7 c8)
(bond c8 c14)
(bond c8 o3)
(bond o3 c2)
(bond c8 c9)
(bond c9 c4)
(bond c3 c4)
(bond c2 c4)
(bond c3 h1)
(bond c1 h14)
(bond c1 h13)
(bond o2 h51)
(bond c6 h6)
(bond c5 h3)
(bond c5 h4)
(bond c5 h5)
(bond c7 h7)
(bond c7 h21)
(bond c14 h29)
(bond c14 h30)
(bond c14 h31)
(bond c2 h11)
(bond c2 h12)
(bond c9 h9)
(bond c9 h10)
(bond c4 h2)
)
)
)
