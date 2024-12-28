; The variants of the Organic Synthesis domain were created by
; Dr. Russell Viirre, Hadi Qovaizi, and Prof. Mikhail Soutchanski.
;
; This work is licensed under a Creative Commons Attribution,
; NonCommercial, ShareAlike 3.0 Unported License.
;
; For further information, please access the following web page:
; https://www.cs.ryerson.ca/~mes/publications/
(define (problem p13) (:domain Chemical)
(:objects
; setup for problem 13 
h100 - hydrogen
h101 - hydrogen
h102 - hydrogen
h103 - hydrogen
h104 - hydrogen
h105 - hydrogen
h106 - hydrogen
h107 - hydrogen
h108 - hydrogen
h109 - hydrogen
h110 - hydrogen
h111 - hydrogen
c100 - carbon
c101 - carbon
c102 - carbon
c103 - carbon
c104 - carbon
c105 - carbon
li - lithium
n - nitrogen
h1 - hydrogen
h2 - hydrogen
h3 - hydrogen
h4 - hydrogen
h5 - hydrogen
h6 - hydrogen
h7 - hydrogen
h8 - hydrogen
o1 - oxygen
o2 - oxygen
c1 - carbon
c2 - carbon
c3 - carbon
c4 - carbon
; The second starting material 
h9 - hydrogen
h10 - hydrogen
h11 - hydrogen
h12 - hydrogen
h13 - hydrogen
h14 - hydrogen
h15 - hydrogen
h16 - hydrogen
o3 - oxygen
o4 - oxygen
c5 - carbon
c6 - carbon
c7 - carbon
c8 - carbon
; The next compound 
c9 - carbon
c10 - carbon
c11 - carbon
c12 - carbon
c13 - carbon
h17 - hydrogen
h18 - hydrogen
h19 - hydrogen
h20 - hydrogen
h21 - hydrogen
h22 - hydrogen
h23 - hydrogen
h24 - hydrogen
h25 - hydrogen
h26 - hydrogen
br1 - bromine
br2 - bromine
h27 - hydrogen
na2 - sodium
o5 - oxygen
; strong base 
na1 - sodium
h29 - hydrogen
)
(:init
; setup for problem 13 
(bond h100 c100)
(bond h101 c100)
(bond h102 c100)
(bond c100 h100)
(bond c100 h101)
(bond c100 h102)
(bond h103 c101)
(bond h104 c101)
(bond h105 c101)
(bond c101 h103)
(bond c101 h104)
(bond c101 h105)
(bond c100 c104)
(bond c104 c100)
(bond c101 c104)
(bond c104 c101)
(bond n c104)
(bond c104 n)
(bond n li)
(bond li n)
(bond n c105)
(bond c105 n)
(bond h109 c102)
(bond h110 c102)
(bond h111 c102)
(bond c102 h109)
(bond c102 h110)
(bond c102 h111)
(bond h106 c103)
(bond h107 c103)
(bond h108 c103)
(bond c103 h106)
(bond c103 h107)
(bond c103 h108)
(bond c103 c105)
(bond c105 c103)
(bond c102 c105)
(bond c105 c102)

(bond c1 c2)
(bond c2 c1)
(bond c2 o1)
(bond o1 c2)
(bond o1 c3)
(bond c3 o1)
(doublebond c3 o2)
(doublebond o2 c3)
(bond c3 c4)
(bond c3 c4)
(bond c1 h1)
(bond c1 h2)
(bond c1 h3)
(bond h1 c1)
(bond h2 c1)
(bond h3 c1)
(bond c2 h4)
(bond c2 h5)
(bond h4 c2)
(bond h5 c2)
(bond c4 h6)
(bond c4 h7)
(bond c4 h8)
(bond h6 c4)
(bond h7 c4)
(bond h8 c4)
; The second starting material 
(bond c5 c6)
(bond c6 c5)
(bond c6 o3)
(bond o3 c6)
(bond o3 c7)
(bond c7 o3)
(doublebond c7 o4)
(doublebond o4 c7)
(bond c7 c8)
(bond c8 c7)
(bond c5 h9)
(bond c5 h10)
(bond c5 h11)
(bond h9 c5)
(bond h10 c5)
(bond h11 c5)
(bond c6 h12)
(bond c6 h13)
(bond h12 c6)
(bond h13 c6)
(bond c8 h14)
(bond c8 h15)
(bond c8 h16)
(bond h14 c8)
(bond h15 c8)
(bond h16 c8)
; The next compound 
(bond br1 c9)
(bond c9 c10)
(bond c10 c11)
(bond c11 c12)
(bond c12 c13)
(bond c13 br2)
(bond c9 br1)
(bond c10 c9)
(bond c11 c10)
(bond c12 c11)
(bond c13 c12)
(bond br2 c13)
(bond c9 h17)
(bond c9 h18)
(bond c10 h19)
(bond c10 h20)
(bond c11 h21)
(bond c11 h22)
(bond c12 h23)
(bond c12 h24)
(bond c13 h25)
(bond c13 h26)
(bond h17 c9)
(bond h18 c9)
(bond h19 c10)
(bond h20 c10)
(bond h21 c11)
(bond h22 c11)
(bond h23 c12)
(bond h24 c12)
(bond h25 c13)
(bond h26 c13)
(bond o5 h27)
(bond o5 na2)
(bond h27 o5)
(bond na2 o5)
; strong base 
(bond na1 h29)
(bond h29 na1)
)
(:goal
(and
(bond c4 h6)
(bond c4 c7)
(bond c4 c9)
(bond c4 c13)
(bond c13 h25)
(bond c13 h26)
(bond c13 c12)
(bond c12 h23)
(bond c12 h24)
(bond c12 c11)
(bond c11 h21)
(bond c11 h22)
(bond c11 c10)
(bond c10 h19)
(bond c10 h20)
(bond c10 c9)
(bond c9 h17)
(bond c9 h18)
(doublebond c7 o4)
(bond c7 c8)
(bond c8 h14)
(bond c8 h15)
(bond c8 h16)
)
)
)
