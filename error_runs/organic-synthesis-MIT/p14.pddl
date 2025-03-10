; The variants of the Organic Synthesis domain were created by
; Dr. Russell Viirre, Hadi Qovaizi, and Prof. Mikhail Soutchanski.
;
; This work is licensed under a Creative Commons Attribution,
; NonCommercial, ShareAlike 3.0 Unported License.
;
; For further information, please access the following web page:
; https://www.cs.ryerson.ca/~mes/publications/
(define (problem MIT_P14) (:domain Chemical)
(:objects
al2 - aluminium
br1 - bromine
c1 - carbon
c2 - carbon
c3 - carbon
c4 - carbon
c5 - carbon
c6 - carbon
h15 - hydrogen
h16 - hydrogen
h17 - hydrogen
h18 - hydrogen
h2 - hydrogen
h20 - hydrogen
h21 - hydrogen
h22 - hydrogen
h3 - hydrogen
h37 - hydrogen
h38 - hydrogen
h39 - hydrogen
h40 - hydrogen
h50 - hydrogen
h51 - hydrogen
h6 - hydrogen
h7 - hydrogen
h8 - hydrogen
li1 - lithium
o1 - oxygen
o10 - oxygen
)
(:init
(bond al2 h37)
(bond h37 al2)

(bond al2 h38)
(bond h38 al2)

(bond al2 h39)
(bond h39 al2)

(bond al2 h40)
(bond h40 al2)

(bond br1 c5)
(bond c5 br1)

(bond c1 h2)
(bond h2 c1)

(bond c1 h3)
(bond h3 c1)

(doublebond c1 c2)
(doublebond c2 c1)

(bond c2 o1)
(bond o1 c2)

(bond c2 c3)
(bond c3 c2)

(bond c3 h6)
(bond h6 c3)

(bond c3 h7)
(bond h7 c3)

(bond c3 h8)
(bond h8 c3)

(bond c4 h15)
(bond h15 c4)

(bond c4 h16)
(bond h16 c4)

(bond c4 h17)
(bond h17 c4)

(bond c4 c5)
(bond c5 c4)

(bond c5 h18)
(bond h18 c5)

(bond c5 c6)
(bond c6 c5)

(bond c6 h20)
(bond h20 c6)

(bond c6 h21)
(bond h21 c6)

(bond c6 h22)
(bond h22 c6)

(bond h50 o10)
(bond o10 h50)

(bond h51 o10)
(bond o10 h51)

(bond li1 o1)
(bond o1 li1)
)
(:goal
(and
(bond c1 c2)
(bond c2 c1)

(bond c1 c5)
(bond c5 c1)

(bond c1 h2)
(bond h2 c1)

(bond c1 h3)
(bond h3 c1)

(bond c2 c3)
(bond c3 c2)

(bond c2 h37)
(bond h37 c2)

(bond c2 o1)
(bond o1 c2)

(bond c3 h6)
(bond h6 c3)

(bond c3 h7)
(bond h7 c3)

(bond c3 h8)
(bond h8 c3)

(bond c4 c5)
(bond c5 c4)

(bond c4 h15)
(bond h15 c4)

(bond c4 h16)
(bond h16 c4)

(bond c4 h17)
(bond h17 c4)

(bond c5 c6)
(bond c6 c5)

(bond c5 h18)
(bond h18 c5)

(bond c6 h20)
(bond h20 c6)

(bond c6 h21)
(bond h21 c6)

(bond c6 h22)
(bond h22 c6)

(bond h50 o1)
(bond o1 h50)
)
)
)