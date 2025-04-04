; The variants of the Organic Synthesis domain were created by
; Dr. Russell Viirre, Hadi Qovaizi, and Prof. Mikhail Soutchanski.
;
; This work is licensed under a Creative Commons Attribution,
; NonCommercial, ShareAlike 3.0 Unported License.
;
; For further information, please access the following web page:
; https://www.cs.ryerson.ca/~mes/publications/
(define (problem Alkene_P01) (:domain Chemical)
(:objects
b071 - boron
c001 - carbon
c002 - carbon
c003 - carbon
c004 - carbon
c005 - carbon
c006 - carbon
c019 - carbon
c020 - carbon
c021 - carbon
c022 - carbon
c023 - carbon
c024 - carbon
c046 - carbon
c047 - carbon
c048 - carbon
c049 - carbon
c050 - carbon
h058 - hydrogen
h059 - hydrogen
h060 - hydrogen
h157 - hydrogen
h158 - hydrogen
h159 - hydrogen
h160 - hydrogen
h161 - hydrogen
h162 - hydrogen
h163 - hydrogen
h164 - hydrogen
h165 - hydrogen
h179 - hydrogen
h180 - hydrogen
h183 - hydrogen
h184 - hydrogen
o064 - oxygen
o065 - oxygen
o068 - oxygen
o069 - oxygen
o070 - oxygen
o177 - oxygen
o178 - oxygen
o181 - oxygen
o182 - oxygen
s072 - sulfur
)
(:init
(bond b071 c002)
(bond c002 b071)

(bond b071 c005)
(bond c005 b071)

(bond b071 c046)
(bond c046 b071)

(bond c001 c002)
(bond c002 c001)

(bond c002 c003)
(bond c003 c002)

(bond c004 c005)
(bond c005 c004)

(bond c005 c006)
(bond c006 c005)

(doublebond c019 c024)
(doublebond c024 c019)

(bond c019 c020)
(bond c020 c019)

(doublebond c020 c021)
(doublebond c021 c020)

(bond c021 c022)
(bond c022 c021)

(bond c021 s072)
(bond s072 c021)

(doublebond c022 c023)
(doublebond c023 c022)

(bond c023 c024)
(bond c024 c023)

(bond c046 h157)
(bond h157 c046)

(bond c046 h158)
(bond h158 c046)

(bond c046 c047)
(bond c047 c046)

(bond c047 h159)
(bond h159 c047)

(bond c047 h060)
(bond h060 c047)

(bond c047 c048)
(bond c048 c047)

(bond c048 h160)
(bond h160 c048)

(bond c048 h161)
(bond h161 c048)

(bond c048 c049)
(bond c049 c048)

(bond c049 h162)
(bond h162 c049)

(bond c049 h163)
(bond h163 c049)

(bond c049 c050)
(bond c050 c049)

(bond c050 o070)
(bond o070 c050)

(bond c050 h164)
(bond h164 c050)

(bond c050 h165)
(bond h165 c050)

(bond h058 o064)
(bond o064 h058)

(bond h059 o065)
(bond o065 h059)

(bond h179 o177)
(bond o177 h179)

(bond h180 o178)
(bond o178 h180)

(bond h183 o181)
(bond o181 h183)

(bond h184 o182)
(bond o182 h184)

(bond o064 o065)
(bond o065 o064)

(doublebond o068 s072)
(doublebond s072 o068)

(doublebond o069 s072)
(doublebond s072 o069)

(bond o070 s072)
(bond s072 o070)

(bond o177 o178)
(bond o178 o177)

(bond o181 o182)
(bond o182 o181)
)
(:goal
(and
(bond c046 o065)
(bond o065 c046)

(bond c046 c047)
(bond c047 c046)

(bond c046 h157)
(bond h157 c046)

(bond c046 h158)
(bond h158 c046)

(bond c047 c048)
(bond c048 c047)

(bond c047 h060)
(bond h060 c047)

(bond c047 h159)
(bond h159 c047)

(bond c048 c049)
(bond c049 c048)

(bond c048 h161)
(bond h161 c048)

(bond c048 h160)
(bond h160 c048)

(bond c049 c050)
(bond c050 c049)

(bond c049 h162)
(bond h162 c049)

(bond c049 h163)
(bond h163 c049)

(bond c050 o065)
(bond o065 c050)

(bond c050 h164)
(bond h164 c050)

(bond c050 h165)
(bond h165 c050)
)
)
)