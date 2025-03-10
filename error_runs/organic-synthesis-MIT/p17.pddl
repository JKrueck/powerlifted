; The variants of the Organic Synthesis domain were created by
; Dr. Russell Viirre, Hadi Qovaizi, and Prof. Mikhail Soutchanski.
;
; This work is licensed under a Creative Commons Attribution,
; NonCommercial, ShareAlike 3.0 Unported License.
;
; For further information, please access the following web page:
; https://www.cs.ryerson.ca/~mes/publications/
(define (problem MIT_P17) (:domain Chemical)
(:objects
c1 - carbon
c10 - carbon
c11 - carbon
c2 - carbon
c27 - carbon
c3 - carbon
c4 - carbon
c5 - carbon
c6 - carbon
c7 - carbon
c8 - carbon
c9 - carbon
h2 - hydrogen
h27 - hydrogen
h28 - hydrogen
h29 - hydrogen
h3 - hydrogen
h31 - hydrogen
h32 - hydrogen
h33 - hydrogen
h34 - hydrogen
h35 - hydrogen
h36 - hydrogen
h39 - hydrogen
h4 - hydrogen
h40 - hydrogen
h41 - hydrogen
h42 - hydrogen
h43 - hydrogen
h45 - hydrogen
h5 - hydrogen
h50 - hydrogen
h51 - hydrogen
h52 - hydrogen
h6 - hydrogen
h7 - hydrogen
h8 - hydrogen
na - sodium
o1 - oxygen
o2 - oxygen
o3 - oxygen
o50 - oxygen
o51 - oxygen
)
(:init
(bond c1 c2)
(bond c2 c1)

(bond c1 c6)
(bond c6 c1)

(doublebond c1 o1)
(doublebond o1 c1)

(bond c10 h39)
(bond h39 c10)

(bond c10 h40)
(bond h40 c10)

(bond c10 h41)
(bond h41 c10)

(bond c10 c11)
(bond c11 c10)

(bond c11 h42)
(bond h42 c11)

(bond c11 h43)
(bond h43 c11)

(bond c11 c27)
(bond c27 c11)

(bond c2 h2)
(bond h2 c2)

(bond c2 h3)
(bond h3 c2)

(bond c2 c3)
(bond c3 c2)

(bond c27 h45)
(bond h45 c27)

(doublebond c27 o3)
(doublebond o3 c27)

(bond c3 h4)
(bond h4 c3)

(bond c3 h5)
(bond h5 c3)

(bond c3 c4)
(bond c4 c3)

(bond c4 h6)
(bond h6 c4)

(bond c4 h7)
(bond h7 c4)

(bond c4 c5)
(bond c5 c4)

(bond c5 h8)
(bond h8 c5)

(bond c5 h27)
(bond h27 c5)

(bond c5 c6)
(bond c6 c5)

(bond c6 h28)
(bond h28 c6)

(bond c6 h29)
(bond h29 c6)

(bond c7 h31)
(bond h31 c7)

(bond c7 h32)
(bond h32 c7)

(bond c7 h33)
(bond h33 c7)

(bond c7 c8)
(bond c8 c7)

(bond c8 c9)
(bond c9 c8)

(doublebond c8 o2)
(doublebond o2 c8)

(bond c9 h34)
(bond h34 c9)

(bond c9 h35)
(bond h35 c9)

(bond c9 h36)
(bond h36 c9)

(bond h50 o50)
(bond o50 h50)

(bond h51 o51)
(bond o51 h51)

(bond h52 o51)
(bond o51 h52)

(bond na o50)
(bond o50 na)
)
(:goal
(and
(bond c1 c6)
(bond c6 c1)

(bond c1 c2)
(bond c2 c1)

(doublebond c1 o1)
(doublebond o1 c1)

(bond c10 c11)
(bond c11 c10)

(bond c10 h39)
(bond h39 c10)

(bond c10 h40)
(bond h40 c10)

(bond c10 h41)
(bond h41 c10)

(bond c11 c27)
(bond c27 c11)

(bond c11 h42)
(bond h42 c11)

(bond c11 h43)
(bond h43 c11)

(bond c2 c3)
(bond c3 c2)

(bond c2 h2)
(bond h2 c2)

(bond c2 h3)
(bond h3 c2)

(bond c27 c6)
(bond c6 c27)

(bond c27 c7)
(bond c7 c27)

(bond c27 h45)
(bond h45 c27)

(bond c3 c4)
(bond c4 c3)

(bond c3 h4)
(bond h4 c3)

(bond c3 h5)
(bond h5 c3)

(bond c4 c5)
(bond c5 c4)

(bond c4 h6)
(bond h6 c4)

(bond c4 h7)
(bond h7 c4)

(bond c5 c6)
(bond c6 c5)

(bond c5 h8)
(bond h8 c5)

(bond c5 h27)
(bond h27 c5)

(bond c6 h29)
(bond h29 c6)

(bond c7 c8)
(bond c8 c7)

(bond c7 h28)
(bond h28 c7)

(bond c7 h33)
(bond h33 c7)

(bond c8 c9)
(bond c9 c8)

(doublebond c8 o2)
(doublebond o2 c8)

(bond c9 h34)
(bond h34 c9)

(bond c9 h35)
(bond h35 c9)

(bond c9 h36)
(bond h36 c9)
)
)
)