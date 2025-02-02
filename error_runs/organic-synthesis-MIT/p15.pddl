; The variants of the Organic Synthesis domain were created by
; Dr. Russell Viirre, Hadi Qovaizi, and Prof. Mikhail Soutchanski.
;
; This work is licensed under a Creative Commons Attribution,
; NonCommercial, ShareAlike 3.0 Unported License.
;
; For further information, please access the following web page:
; https://www.cs.ryerson.ca/~mes/publications/
(define (problem MIT_P15) (:domain Chemical)
(:objects
li2 - lithium
al2 - aluminium
c1 - carbon
c2 - carbon
c22 - carbon
c23 - carbon
c3 - carbon
c4 - carbon
h1 - hydrogen
h2 - hydrogen
h26 - hydrogen
h27 - hydrogen
h28 - hydrogen
h3 - hydrogen
h30 - hydrogen
h31 - hydrogen
h35 - hydrogen
h36 - hydrogen
h37 - hydrogen
h38 - hydrogen
h4 - hydrogen
h5 - hydrogen
h50 - hydrogen
h52 - hydrogen
h6 - hydrogen
h7 - hydrogen
h8 - hydrogen
n6 - nitrogen
o3 - oxygen
)
(:init
(bond al2 h35)
(bond h35 al2)

(bond al2 h36)
(bond h36 al2)

(bond al2 h37)
(bond h37 al2)

(bond al2 h38)
(bond h38 al2)

(bond c1 h1)
(bond h1 c1)

(bond c1 h2)
(bond h2 c1)

(bond c1 h3)
(bond h3 c1)

(bond c1 c4)
(bond c4 c1)

(bond c2 h4)
(bond h4 c2)

(bond c2 h5)
(bond h5 c2)

(bond c2 h6)
(bond h6 c2)

(bond c2 c3)
(bond c3 c2)

(bond c22 h26)
(bond h26 c22)

(bond c22 h27)
(bond h27 c22)

(bond c22 h28)
(bond h28 c22)

(bond c22 c23)
(bond c23 c22)

(bond c23 h30)
(bond h30 c23)

(bond c23 h31)
(bond h31 c23)

(bond c23 n6)
(bond n6 c23)

(bond c3 h7)
(bond h7 c3)

(bond c3 h8)
(bond h8 c3)

(bond c3 c4)
(bond c4 c3)

(doublebond c4 o3)
(doublebond o3 c4)

(bond h50 n6)
(bond n6 h50)

(bond h52 n6)
(bond n6 h52)
)
(:goal
(and
(bond c1 c4)
(bond c4 c1)

(bond c1 h1)
(bond h1 c1)

(bond c1 h2)
(bond h2 c1)

(bond c1 h3)
(bond h3 c1)

(bond c2 c3)
(bond c3 c2)

(bond c2 h4)
(bond h4 c2)

(bond c2 h5)
(bond h5 c2)

(bond c2 h6)
(bond h6 c2)

(bond c22 c23)
(bond c23 c22)

(bond c22 h26)
(bond h26 c22)

(bond c22 h27)
(bond h27 c22)

(bond c22 h28)
(bond h28 c22)

(bond c23 n6)
(bond n6 c23)

(bond c23 h30)
(bond h30 c23)

(bond c23 h31)
(bond h31 c23)

(bond c3 c4)
(bond c4 c3)

(bond c3 h7)
(bond h7 c3)

(bond c3 h8)
(bond h8 c3)

(bond c4 n6)
(bond n6 c4)

(bond c4 h35)
(bond h35 c4)

(bond h50 n6)
(bond n6 h50)
)
)
)