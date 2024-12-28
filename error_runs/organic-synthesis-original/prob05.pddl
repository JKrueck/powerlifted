; The variants of the Organic Synthesis domain were created by
; Dr. Russell Viirre, Hadi Qovaizi, and Prof. Mikhail Soutchanski.
;
; This work is licensed under a Creative Commons Attribution,
; NonCommercial, ShareAlike 3.0 Unported License.
;
; For further information, please access the following web page:
; https://www.cs.ryerson.ca/~mes/publications/
(define (problem P5AromModi2) (:domain Chemical)
(:objects
; setup for problem 5 
na - sodium
; to make sodium hydroxide Na-OH 
o50 - oxygen
h50 - hydrogen
; to make water H-OH for aldol condensation reaction 
o51 - oxygen
h51 - hydrogen
h52 - hydrogen
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
h7 - hydrogen
h8 - hydrogen
; second starting molecule 
o2 - oxygen
c4 - carbon
c5 - carbon
c6 - carbon
c7 - carbon
c8 - carbon
c9 - carbon
c10 - carbon
h9 - hydrogen
h10 - hydrogen
h11 - hydrogen
h12 - hydrogen
h13 - hydrogen
h14 - hydrogen
h15 - hydrogen
h16 - hydrogen
;  PCC 
c17 - carbon
c18 - carbon
c19 - carbon
c20 - carbon
c21 - carbon
n5 - nitrogen
h17 - hydrogen
h18 - hydrogen
h19 - hydrogen
h20 - hydrogen
h21 - hydrogen
h22 - hydrogen
cr2 - chromium
o7 - oxygen
o8 - oxygen
o9 - oxygen
cl2 - chlorine
; second PCC 
c22 - carbon
c23 - carbon
c24 - carbon
c25 - carbon
c26 - carbon
n6 - nitrogen
h23 - hydrogen
h24 - hydrogen
h25 - hydrogen
h26 - hydrogen
h27 - hydrogen
h28 - hydrogen
cr3 - chromium
o10 - oxygen
o11 - oxygen
o12 - oxygen
cl3 - chlorine
)
(:init
; setup for problem 5 
; to make sodium hydroxide Na-OH 
(bond na o50)
(bond o50 na)
(bond h50 o50)
(bond o50 h50)
; to make water H-OH for aldol condensation reaction 
(bond h51 o51)
(bond o51 h51)
(bond h52 o51)
(bond o51 h52)
(bond c1 c2)
(bond c2 c1)
(bond c2 c3)
(bond c3 c2)
(bond c2 o1)
(bond o1 c2)
(bond c1 h1)
(bond h1 c1)
(bond c1 h2)
(bond h2 c1)
(bond c1 h3)
(bond h3 c1)
(bond c2 h4)
(bond h4 c2)
(bond c3 h5)
(bond h5 c3)
(bond c3 h6)
(bond h6 c3)
(bond c3 h7)
(bond h7 c3)
(bond o1 h8)
(bond h8 o1)
; second starting molecule 
(bond o2 c4)
(bond c4 o2)
(bond c4 c5)
(bond c5 c4)
(aromaticbond c5 c6)
(aromaticbond c6 c5)
(aromaticbond c6 c7)
(aromaticbond c7 c6)
(aromaticbond c7 c8)
(aromaticbond c8 c7)
(aromaticbond c8 c9)
(aromaticbond c9 c8)
(aromaticbond c9 c10)
(aromaticbond c10 c9)
(aromaticbond c5 c10)
(aromaticbond c10 c5)
(bond o2 h9)
(bond h9 o2)
(bond c4 h10)
(bond h10 c4)
(bond c4 h11)
(bond h11 c4)
(bond c6 h12)
(bond h12 c6)
(bond c7 h13)
(bond h13 c7)
(bond c8 h14)
(bond h14 c8)
(bond c9 h15)
(bond h15 c9)
(bond c10 h16)
(bond h16 c10)
;  PCC 
(bond n5 h19)
(bond h19 n5)
(aromaticbond c17 n5)
(aromaticbond c17 c18)
(aromaticbond c18 c19)
(aromaticbond c19 c20)
(aromaticbond c20 c21)
(aromaticbond c21 n5)
(aromaticbond n5 c17)
(aromaticbond c18 c17)
(aromaticbond c19 c18)
(aromaticbond c20 c19)
(aromaticbond c21 c20)
(aromaticbond n5 c21)
(bond h18 c17)
(bond h17 c18)
(bond h20 c19)
(bond h21 c20)
(bond h22 c21)
(bond c17 h18)
(bond c18 h17)
(bond c19 h20)
(bond c20 h21)
(bond c21 h22)
(bond o7 cr2)
(doublebond cr2 o8)
(doublebond cr2 o9)
(bond cr2 cl2)
(bond cr2 o7)
(doublebond o8 cr2)
(doublebond o9 cr2)
(bond cl2 cr2)
(bond n5 o7)
(bond o7 n5)
; second PCC 
(bond n6 h25)
(bond h25 n6)
(aromaticbond c22 n6)
(bond c22 c23)
(aromaticbond c23 c24)
(bond c24 c25)
(aromaticbond c25 c26)
(bond c26 n6)
(aromaticbond n6 c22)
(bond c23 c22)
(aromaticbond c24 c23)
(bond c25 c24)
(aromaticbond c26 c25)
(bond n6 c26)
(bond h24 c22)
(bond h23 c23)
(bond h26 c24)
(bond h27 c25)
(bond h28 c26)
(bond c22 h24)
(bond c23 h23)
(bond c24 h26)
(bond c25 h27)
(bond c26 h28)
(bond o10 cr3)
(doublebond cr3 o11)
(doublebond cr3 o12)
(bond cr3 cl3)
(bond cr3 o10)
(doublebond o11 cr3)
(doublebond o12 cr3)
(bond cl3 cr3)
(bond n6 o10)
(bond o10 n6)
)
(:goal
(and
(aromaticbond c6 c7)
(aromaticbond c7 c8)
(aromaticbond c8 c9)
(aromaticbond c9 c10)
(aromaticbond c10 c5)
(aromaticbond c6 c5)
(bond c5 c4)
(doublebond c4 c1)
(bond c1 c2)
(doublebond c2 o1)
(bond c2 c3)
(bond c6 h12)
(bond c7 h13)
(bond c8 h14)
(bond c9 h15)
(bond c10 h16)
(bond c4 h11)
(bond c1 h3)
(bond c3 h5)
(bond c3 h6)
(bond c3 h7)
)
)
)
