; The variants of the Organic Synthesis domain were created by
; Dr. Russell Viirre, Hadi Qovaizi, and Prof. Mikhail Soutchanski.
;
; This work is licensed under a Creative Commons Attribution,
; NonCommercial, ShareAlike 3.0 Unported License.
;
; For further information, please access the following web page:
; https://www.cs.ryerson.ca/~mes/publications/
(define (problem p9) (:domain Chemical)
(:objects
; setup for problem 9 -- benzyl-alcohol 
c1 - carbon
c2 - carbon
c3 - carbon
c4 - carbon
c5 - carbon
c6 - carbon
c7 - carbon
o1 - oxygen
h1 - hydrogen
h2 - hydrogen
h3 - hydrogen
h4 - hydrogen
h5 - hydrogen
h6 - hydrogen
h7 - hydrogen
h8 - hydrogen
; ethanol 
c8 - carbon
c9 - carbon
o2 - oxygen
h9 - hydrogen
h10 - hydrogen
h11 - hydrogen
h12 - hydrogen
h13 - hydrogen
h14 - hydrogen
; ethanol 2
c108 - carbon
c109 - carbon
o102 - oxygen
h109 - hydrogen
h50 - hydrogen
h51 - hydrogen
h52 - hydrogen
h53 - hydrogen
h54 - hydrogen
; ethanol 3
c118 - carbon
c119 - carbon
o112 - oxygen
h119 - hydrogen
h55 - hydrogen
h56 - hydrogen
h57 - hydrogen
h58 - hydrogen
h59 - hydrogen

; ethanol 4

c122 - carbon
c123 - carbon
o114 - oxygen 
h140 - hydrogen 
h60 - hydrogen 
h61 - hydrogen 
h62 - hydrogen 
h63 - hydrogen 
h64 - hydrogen 



; ethanol 5
c120 - carbon
c121 - carbon
o113 - oxygen 
h120 - hydrogen 
h65 - hydrogen 
h66 - hydrogen 
h67 - hydrogen 
h68 - hydrogen 
h69 - hydrogen 

; Na2Cr2O7 
na1 - sodium
na2 - sodium
cr1 - chromium
cr2 - chromium
o7 - oxygen
o8 - oxygen
o9 - oxygen
o10 - oxygen
o11 - oxygen
o12 - oxygen
o13 - oxygen
; second Na2Cr2O7 
na3 - sodium
na4 - sodium
cr3 - chromium
cr4 - chromium
o14 - oxygen
o15 - oxygen
o16 - oxygen
o17 - oxygen
o18 - oxygen
o19 - oxygen
o20 - oxygen
; methanol
c10 - carbon
o3 - oxygen
h24 - hydrogen
h25 - hydrogen
h26 - hydrogen
h27 - hydrogen
; second methanol 
c11 - carbon
o4 - oxygen
h28 - hydrogen
h29 - hydrogen
h30 - hydrogen
h31 - hydrogen
; strong base 
na9 - sodium
h229 - hydrogen
o36 - oxygen
; methyl iodide 
c12 - carbon
i1 - iodine
h32 - hydrogen
h33 - hydrogen
h34 - hydrogen
; second methyl iodide 
c13 - carbon
i2 - iodine
h35 - hydrogen
h36 - hydrogen
h37 - hydrogen
)
(:init
; setup for problem 9 -- benzyl-alcohol 
(aromaticbond c1 c2)
(aromaticbond c2 c1)
(aromaticbond c2 c3)
(aromaticbond c3 c2)
(aromaticbond c3 c4)
(aromaticbond c4 c3)
(aromaticbond c4 c5)
(aromaticbond c5 c4)
(aromaticbond c5 c6)
(aromaticbond c6 c5)
(aromaticbond c1 c6)
(aromaticbond c6 c1)
(bond c6 c7)
(bond c7 c6)
(bond c7 o1)
(bond o1 c7)
(bond c1 h1)
(bond h1 c1)
(bond c2 h2)
(bond h2 c2)
(bond c3 h3)
(bond h3 c3)
(bond c4 h4)
(bond h4 c4)
(bond c5 h5)
(bond h5 c5)
(bond c7 h6)
(bond h6 c7)
(bond c7 h7)
(bond h7 c7)
(bond o1 h8)
(bond h8 o1)
; ethanol 
(bond c8 c9)
(bond c9 c8)
(bond c9 o2)
(bond o2 c9)
(bond c8 h9)
(bond h9 c8)
(bond c8 h10)
(bond h10 c8)
(bond c8 h11)
(bond h11 c8)
(bond c9 h12)
(bond h12 c9)
(bond c9 h13)
(bond h13 c9)
(bond o2 h14)
(bond h14 o2)
; ethanol 2
(bond c108 c109)
(bond c109 c108)
(bond c109 o102)
(bond o102 c109)
(bond c108 h109)
(bond h109 c108)
(bond c108 h50)
(bond h50 c108)
(bond c108 h51)
(bond h51 c108)
(bond c109 h52)
(bond h52 c109)
(bond c109 h53)
(bond h53 c109)
(bond o102 h54)
(bond h54 o102)
; ethanol 3
(bond c118 c119)
(bond c119 c118)
(bond c119 o112)
(bond o112 c119)
(bond c118 h119)
(bond h119 c118)
(bond c118 h55)
(bond h55 c118)
(bond c118 h56)
(bond h56 c118)
(bond c119 h57)
(bond h57 c119)
(bond c119 h58)
(bond h58 c119)
(bond o112 h59)
(bond h59 o112)

(bond c122 c123)
(bond c123 c122)
(bond c123 o114)
(bond o114 c123)
(bond c122 h140)
(bond h140 c122)
(bond c122 h60)
(bond h60 c122)
(bond c122 h61)
(bond h61 c122)
(bond c123 h62)
(bond h62 c123)
(bond c123 h63)
(bond h63 c123)
(bond o114 h64)
(bond h64 o114)


(bond c120 c121)
(bond c121 c120)
(bond c121 o113)
(bond o113 c121)
(bond c120 h120)
(bond h120 c120)
(bond c120 h65)
(bond h65 c120)
(bond c120 h66)
(bond h66 c120)
(bond c121 h67)
(bond h67 c121)
(bond c121 h68)
(bond h68 c121)
(bond o113 h69)
(bond h69 o113)

; Na2Cr2O7 
(bond cr1 o7)
(bond cr2 o7)
(bond o7 cr1)
(bond o7 cr2)
(bond cr2 o8)
(doublebond cr2 o9)
(doublebond cr2 o10)
(bond o8 cr2)
(doublebond o9 cr2)
(doublebond o10 cr2)
(bond cr1 o11)
(doublebond cr1 o12)
(doublebond cr1 o13)
(bond o11 cr1)
(doublebond o12 cr1)
(doublebond o13 cr1)
(bond na1 o8)
(bond o8 na1)
(bond o11 na2)
(bond na2 o11)
; second Na2Cr2O7 
(bond cr3 o14)
(bond cr4 o14)
(bond o14 cr3)
(bond o14 cr4)
(bond cr3 o15)
(doublebond cr3 o16)
(doublebond cr3 o17)
(bond o15 cr3)
(doublebond o16 cr3)
(doublebond o17 cr3)
(bond cr4 o18)
(doublebond cr4 o19)
(doublebond cr4 o20)
(bond o18 cr4)
(doublebond o19 cr4)
(doublebond o20 cr4)
(bond na3 o15)
(bond na4 o18)
(bond o15 na3)
(bond o18 na4)
; methanol
(bond c10 o3)
(bond o3 c10)
(bond c10 h24)
(bond h24 c10)
(bond c10 h25)
(bond h25 c10)
(bond c10 h26)
(bond h26 c10)
(bond o3 h27)
(bond h27 o3)
; second methanol 
(bond c11 o4)
(bond o4 c11)
(bond c11 h28)
(bond h28 c11)
(bond c11 h29)
(bond h29 c11)
(bond c11 h30)
(bond h30 c11)
(bond o4 h31)
(bond h31 o4)
; strong base 
(bond o36 h229)
(bond h229 o36)
(bond na9 o36)
(bond o36 na9)
; methyl iodide 
(bond c12 i1)
(bond i1 c12)
(bond c12 h32)
(bond h32 c12)
(bond c12 h33)
(bond h33 c12)
(bond c12 h34)
(bond h34 c12)
; second methyl iodide 
(bond c13 i2)
(bond i2 c13)
(bond c13 h35)
(bond h35 c13)
(bond c13 h36)
(bond h36 c13)
(bond c13 h37)
(bond h37 c13)
)
(:goal
(and
(aromaticbond c6 c1)
(aromaticbond c1 c2)
(aromaticbond c2 c3)
(aromaticbond c3 c4)
(aromaticbond c4 c5)
(aromaticbond c5 c6)
(bond c6 c7)
(bond c1 h1)
(bond c2 h2)
(bond c3 h3)
(bond c4 h4)
(bond c5 h5)
(doublebond c7 o1)
(bond c7 c108)
(bond c108 c12)
(bond c108 c13)
(bond c108 c109)
(bond c12 h32)
(bond c12 h33)
(bond c12 h34)
(bond c13 h35)
(bond c13 h36)
(bond c13 h37)
(doublebond c109 o102)
(bond c109 o4)
(bond o4 c11)
(bond c11 h28)
(bond c11 h29)
(bond c11 h30)
)
)
)
