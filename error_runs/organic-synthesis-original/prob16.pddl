; The variants of the Organic Synthesis domain were created by
; Dr. Russell Viirre, Hadi Qovaizi, and Prof. Mikhail Soutchanski.
;
; This work is licensed under a Creative Commons Attribution,
; NonCommercial, ShareAlike 3.0 Unported License.
;
; For further information, please access the following web page:
; https://www.cs.ryerson.ca/~mes/publications/
(define (problem initialBonds16) (:domain Chemical)
(:objects
; water
o50 - oxygen
h50 - hydrogen
h51 - hydrogen
; acetone 
c1 - carbon
c2 - carbon
c3 - carbon
o1 - oxygen
h1 - hydrogen
h2 - hydrogen
h3 - hydrogen
h4 - hydrogen
h5 - hydrogen
h6 - hydrogen
;  diethyl malonate 
c4 - carbon
c5 - carbon
c6 - carbon
c7 - carbon
c8 - carbon
c9 - carbon
c10 - carbon
o2 - oxygen
o3 - oxygen
o4 - oxygen
o5 - oxygen
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
h17 - hydrogen
h18 - hydrogen
; second acetone 
c11 - carbon
c12 - carbon
c13 - carbon
o6 - oxygen
h19 - hydrogen
h20 - hydrogen
h21 - hydrogen
h22 - hydrogen
h23 - hydrogen
h24 - hydrogen
; NaOCH3 
na1 - sodium
h52 - hydrogen
c14 - carbon
o7 - oxygen
h25 - hydrogen
h26 - hydrogen
h27 - hydrogen
)
(:init
; water
(bond o50 h50)
(bond h50 o50)
(bond o50 h51)
(bond h51 o50)
; acetone 
(bond c1 c2)
(bond c2 c1)
(bond c3 c2)
(bond c2 c3)
(doublebond c2 o1)
(doublebond o1 c2)
(bond c1 h1)
(bond c1 h2)
(bond c1 h3)
(bond h1 c1)
(bond h2 c1)
(bond h3 c1)
(bond c3 h4)
(bond c3 h5)
(bond c3 h6)
(bond h4 c3)
(bond h5 c3)
(bond h6 c3)
;  diethyl malonate 
(bond c4 c5)
(bond c5 c4)
(bond c5 o2)
(bond o2 c5)
(bond o2 c6)
(bond c6 o2)
(doublebond c6 o3)
(doublebond o3 c6)
(bond c6 c7)
(bond c7 c6)
(bond c7 c8)
(bond c8 c7)
(doublebond c8 o4)
(doublebond o4 c8)
(bond c8 o5)
(bond o5 c8)
(bond o5 c9)
(bond c9 o5)
(bond c10 c9)
(bond c9 c10)
(bond c4 h7)
(bond c4 h8)
(bond c4 h9)
(bond h7 c4)
(bond h8 c4)
(bond h9 c4)
(bond c5 h10)
(bond c5 h11)
(bond h10 c5)
(bond h11 c5)
(bond c7 h12)
(bond c7 h13)
(bond h12 c7)
(bond h13 c7)
(bond c9 h14)
(bond c9 h15)
(bond h14 c9)
(bond h15 c9)
(bond c10 h16)
(bond c10 h17)
(bond c10 h18)
(bond h16 c10)
(bond h17 c10)
(bond h18 c10)
; second acetone 
(bond c11 c12)
(bond c12 c11)
(bond c13 c12)
(bond c12 c13)
(doublebond c12 o6)
(doublebond o6 c12)
(bond c11 h19)
(bond c11 h20)
(bond c11 h21)
(bond h19 c11)
(bond h20 c11)
(bond h21 c11)
(bond c13 h22)
(bond c13 h23)
(bond c13 h24)
(bond h22 c13)
(bond h23 c13)
(bond h24 c13)
; NaOCH3 
(bond na1 o7)
(bond o7 na1)
(bond o7 h52)
(bond h52 o7)
(bond c14 h25)
(bond c14 h26)
(bond c14 h27)
(bond h25 c14)
(bond h26 c14)
(bond h27 c14)
)
(:goal
(and
(bond c2 c1)
(bond c2 c3)
(bond c2 c7)
(bond c7 c8)
(doublebond c8 o4)
(bond c8 c13)
(bond c13 c12)
(doublebond c12 o6)
(bond c12 c11)
(bond c2 c11)
(bond c1 h1)
(bond c1 h2)
(bond c1 h3)
(bond c3 h4)
(bond c3 h5)
(bond c3 h6)
(bond c7 h51)
(bond c7 h19)
(bond c13 h23)
(bond c13 h24)
(bond c11 h20)
(bond c11 h21)
)
)
)
