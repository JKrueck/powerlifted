; The variants of the Organic Synthesis domain were created by
; Dr. Russell Viirre, Hadi Qovaizi, and Prof. Mikhail Soutchanski.
;
; This work is licensed under a Creative Commons Attribution,
; NonCommercial, ShareAlike 3.0 Unported License.
;
; For further information, please access the following web page:
; https://www.cs.ryerson.ca/~mes/publications/
(define (problem Alkene_P09) (:domain Chemical)
(:objects
b071 - boron
c001 - carbon
c002 - carbon
c003 - carbon
c004 - carbon
c005 - carbon
c006 - carbon
c039 - carbon
c040 - carbon
c041 - carbon
c042 - carbon
c043 - carbon
c044 - carbon
c045 - carbon
h058 - hydrogen
h059 - hydrogen
h060 - hydrogen
h145 - hydrogen
h146 - hydrogen
h147 - hydrogen
h148 - hydrogen
h149 - hydrogen
h150 - hydrogen
h151 - hydrogen
h152 - hydrogen
h153 - hydrogen
h154 - hydrogen
h155 - hydrogen
h156 - hydrogen
h179 - hydrogen
h180 - hydrogen
h183 - hydrogen
h184 - hydrogen
o064 - oxygen
o065 - oxygen
o177 - oxygen
o178 - oxygen
o181 - oxygen
o182 - oxygen
)
(:init
(bond b071 c002)
(bond c002 b071)

(bond b071 c005)
(bond c005 b071)

(bond b071 h060)
(bond h060 b071)

(bond c001 c002)
(bond c002 c001)

(bond c002 c003)
(bond c003 c002)

(bond c004 c005)
(bond c005 c004)

(bond c005 c006)
(bond c006 c005)

(bond c039 c040)
(bond c040 c039)

(bond c039 h147)
(bond h147 c039)

(bond c039 h146)
(bond h146 c039)

(bond c039 h145)
(bond h145 c039)

(doublebond c040 c041)
(doublebond c041 c040)

(bond c040 c045)
(bond c045 c040)

(bond c041 c042)
(bond c042 c041)

(bond c041 h148)
(bond h148 c041)

(bond c042 h150)
(bond h150 c042)

(bond c042 h149)
(bond h149 c042)

(bond c042 c043)
(bond c043 c042)

(bond c043 c044)
(bond c044 c043)

(bond c043 h152)
(bond h152 c043)

(bond c043 h151)
(bond h151 c043)

(bond c044 h154)
(bond h154 c044)

(bond c044 h153)
(bond h153 c044)

(bond c044 c045)
(bond c045 c044)

(bond c045 h156)
(bond h156 c045)

(bond c045 h155)
(bond h155 c045)

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

(bond o177 o178)
(bond o178 o177)

(bond o181 o182)
(bond o182 o181)
)
(:goal
(and
(bond c039 c040)
(bond c040 c039)

(bond c039 h146)
(bond h146 c039)

(bond c039 h145)
(bond h145 c039)

(bond c039 h147)
(bond h147 c039)

(bond c040 c045)
(bond c045 c040)

(bond c040 c041)
(bond c041 c040)

(bond c040 h060)
(bond h060 c040)

(bond c041 c042)
(bond c042 c041)

(bond c041 o065)
(bond o065 c041)

(bond c041 h148)
(bond h148 c041)

(bond c042 c043)
(bond c043 c042)

(bond c042 h150)
(bond h150 c042)

(bond c042 h149)
(bond h149 c042)

(bond c043 c044)
(bond c044 c043)

(bond c043 h152)
(bond h152 c043)

(bond c043 h151)
(bond h151 c043)

(bond c044 c045)
(bond c045 c044)

(bond c044 h154)
(bond h154 c044)

(bond c044 h153)
(bond h153 c044)

(bond c045 h156)
(bond h156 c045)

(bond c045 h155)
(bond h155 c045)

(bond h059 o065)
(bond o065 h059)
)
)
)