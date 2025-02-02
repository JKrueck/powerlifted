; The variants of the Organic Synthesis domain were created by
; Dr. Russell Viirre, Hadi Qovaizi, and Prof. Mikhail Soutchanski.
;
; This work is licensed under a Creative Commons Attribution,
; NonCommercial, ShareAlike 3.0 Unported License.
;
; For further information, please access the following web page:
; https://www.cs.ryerson.ca/~mes/publications/
(define (problem MIT_P10) (:domain Chemical)
(:objects
al1 - aluminium
b1 - boron
c1 - carbon
c10 - carbon
c11 - carbon
c12 - carbon
c13 - carbon
c14 - carbon
c2 - carbon
c3 - carbon
c4 - carbon
c5 - carbon
c6 - carbon
c7 - carbon
c8 - carbon
c9 - carbon
h1 - hydrogen
h10 - hydrogen
h11 - hydrogen
h12 - hydrogen
h13 - hydrogen
h14 - hydrogen
h2 - hydrogen
h21 - hydrogen
h22 - hydrogen
h23 - hydrogen
h24 - hydrogen
h29 - hydrogen
h3 - hydrogen
h30 - hydrogen
h31 - hydrogen
h4 - hydrogen
h5 - hydrogen
h50 - hydrogen
h51 - hydrogen
h52 - hydrogen
h53 - hydrogen
h54 - hydrogen
h6 - hydrogen
h7 - hydrogen
h9 - hydrogen
hg1 - mercury
li1 - lithium
o1 - oxygen
o2 - oxygen
o3 - oxygen
o4 - oxygen
o5 - oxygen
o50 - oxygen
o51 - oxygen
o52 - oxygen
o6 - oxygen
o7 - oxygen
)
(:init
(bond al1 h11)
(bond h11 al1)

(bond al1 h12)
(bond h12 al1)

(bond al1 h13)
(bond h13 al1)

(bond al1 h14)
(bond h14 al1)

(bond b1 h21)
(bond h21 b1)

(bond b1 h22)
(bond h22 b1)

(bond b1 h23)
(bond h23 b1)

(bond b1 h24)
(bond h24 b1)

(bond c1 o1)
(bond o1 c1)

(bond c1 c3)
(bond c3 c1)

(doublebond c1 o2)
(doublebond o2 c1)

(bond c10 c11)
(bond c11 c10)

(bond c11 o5)
(bond o5 c11)

(doublebond c11 o4)
(doublebond o4 c11)

(bond c12 c13)
(bond c13 c12)

(bond c13 o7)
(bond o7 c13)

(doublebond c13 o6)
(doublebond o6 c13)

(bond c14 h29)
(bond h29 c14)

(bond c14 h30)
(bond h30 c14)

(bond c14 h31)
(bond h31 c14)

(bond c14 c8)
(bond c8 c14)

(bond c2 o1)
(bond o1 c2)

(bond c2 c4)
(bond c4 c2)

(doublebond c2 o3)
(doublebond o3 c2)

(bond c3 h1)
(bond h1 c3)

(bond c3 c6)
(bond c6 c3)

(bond c3 c4)
(bond c4 c3)

(bond c4 h2)
(bond h2 c4)

(bond c4 c9)
(bond c9 c4)

(bond c5 h3)
(bond h3 c5)

(bond c5 h4)
(bond h4 c5)

(bond c5 h5)
(bond h5 c5)

(bond c5 c6)
(bond c6 c5)

(bond c6 h6)
(bond h6 c6)

(bond c6 c7)
(bond c7 c6)

(bond c7 h7)
(bond h7 c7)

(doublebond c7 c8)
(doublebond c8 c7)

(bond c8 c9)
(bond c9 c8)

(bond c9 h9)
(bond h9 c9)

(bond c9 h10)
(bond h10 c9)

(bond h50 o50)
(bond o50 h50)

(bond h51 o50)
(bond o50 h51)

(bond h52 o51)
(bond o51 h52)

(bond h53 o51)
(bond o51 h53)

(bond h54 o3)
(bond o3 h54)

(bond hg1 o5)
(bond o5 hg1)

(bond hg1 o7)
(bond o7 hg1)
)
(:goal
(and
(bond c1 c3)
(bond c3 c1)

(bond c1 o2)
(bond o2 c1)

(bond c1 h13)
(bond h13 c1)

(bond c1 h14)
(bond h14 c1)

(bond c14 c8)
(bond c8 c14)

(bond c14 h29)
(bond h29 c14)

(bond c14 h30)
(bond h30 c14)

(bond c14 h31)
(bond h31 c14)

(bond c2 o3)
(bond o3 c2)

(bond c2 c4)
(bond c4 c2)

(bond c2 h11)
(bond h11 c2)

(bond c2 h12)
(bond h12 c2)

(bond c3 c6)
(bond c6 c3)

(bond c3 c4)
(bond c4 c3)

(bond c3 h1)
(bond h1 c3)

(bond c4 c9)
(bond c9 c4)

(bond c4 h2)
(bond h2 c4)

(bond c5 c6)
(bond c6 c5)

(bond c5 h3)
(bond h3 c5)

(bond c5 h4)
(bond h4 c5)

(bond c5 h5)
(bond h5 c5)

(bond c6 c7)
(bond c7 c6)

(bond c6 h6)
(bond h6 c6)

(bond c7 c8)
(bond c8 c7)

(bond c7 h7)
(bond h7 c7)

(bond c7 h21)
(bond h21 c7)

(bond c8 o3)
(bond o3 c8)

(bond c8 c9)
(bond c9 c8)

(bond c9 h9)
(bond h9 c9)

(bond c9 h10)
(bond h10 c9)

(bond h51 o2)
(bond o2 h51)
)
)
)