; The variants of the Organic Synthesis domain were created by
; Dr. Russell Viirre, Hadi Qovaizi, and Prof. Mikhail Soutchanski.
;
; This work is licensed under a Creative Commons Attribution,
; NonCommercial, ShareAlike 3.0 Unported License.
;
; For further information, please access the following web page:
; https://www.cs.ryerson.ca/~mes/publications/
(define (problem Alkene_P11) (:domain Chemical)
(:objects
b071 - boron
c001 - carbon
c002 - carbon
c003 - carbon
c004 - carbon
c005 - carbon
c006 - carbon
c032 - carbon
c033 - carbon
c034 - carbon
c035 - carbon
c036 - carbon
c037 - carbon
c038 - carbon
c051 - carbon
c052 - carbon
c053 - carbon
c054 - carbon
c055 - carbon
h058 - hydrogen
h059 - hydrogen
h060 - hydrogen
h133 - hydrogen
h134 - hydrogen
h135 - hydrogen
h136 - hydrogen
h137 - hydrogen
h138 - hydrogen
h139 - hydrogen
h140 - hydrogen
h141 - hydrogen
h142 - hydrogen
h143 - hydrogen
h144 - hydrogen
h166 - hydrogen
h167 - hydrogen
h168 - hydrogen
h169 - hydrogen
h170 - hydrogen
h171 - hydrogen
h172 - hydrogen
h173 - hydrogen
h174 - hydrogen
h175 - hydrogen
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
(bond b071 c051)
(bond c051 b071)

(bond b071 c005)
(bond c005 b071)

(bond b071 c002)
(bond c002 b071)

(bond c001 c002)
(bond c002 c001)

(bond c002 c003)
(bond c003 c002)

(bond c004 c005)
(bond c005 c004)

(bond c005 c006)
(bond c006 c005)

(doublebond c032 c033)
(doublebond c033 c032)

(bond c032 h134)
(bond h134 c032)

(bond c032 h133)
(bond h133 c032)

(bond c033 c034)
(bond c034 c033)

(bond c033 c038)
(bond c038 c033)

(bond c034 h136)
(bond h136 c034)

(bond c034 h135)
(bond h135 c034)

(bond c034 c035)
(bond c035 c034)

(bond c035 c036)
(bond c036 c035)

(bond c035 h138)
(bond h138 c035)

(bond c035 h137)
(bond h137 c035)

(bond c036 h140)
(bond h140 c036)

(bond c036 h139)
(bond h139 c036)

(bond c036 c037)
(bond c037 c036)

(bond c037 h142)
(bond h142 c037)

(bond c037 h141)
(bond h141 c037)

(bond c037 c038)
(bond c038 c037)

(bond c038 h144)
(bond h144 c038)

(bond c038 h143)
(bond h143 c038)

(bond c051 h166)
(bond h166 c051)

(bond c051 h167)
(bond h167 c051)

(bond c051 c052)
(bond c052 c051)

(bond c052 c053)
(bond c053 c052)

(bond c052 h060)
(bond h060 c052)

(bond c052 h168)
(bond h168 c052)

(bond c053 h170)
(bond h170 c053)

(bond c053 h169)
(bond h169 c053)

(bond c053 c054)
(bond c054 c053)

(bond c054 h172)
(bond h172 c054)

(bond c054 h171)
(bond h171 c054)

(bond c054 c055)
(bond c055 c054)

(bond c055 h175)
(bond h175 c055)

(bond c055 h174)
(bond h174 c055)

(bond c055 h173)
(bond h173 c055)

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
(bond c032 c033)
(bond c033 c032)

(bond c032 h059)
(bond h059 c032)

(bond c032 h134)
(bond h134 c032)

(bond c032 h133)
(bond h133 c032)

(bond c033 c034)
(bond c034 c033)

(bond c033 c038)
(bond c038 c033)

(bond c033 o065)
(bond o065 c033)

(bond c034 c035)
(bond c035 c034)

(bond c034 h136)
(bond h136 c034)

(bond c034 h135)
(bond h135 c034)

(bond c035 c036)
(bond c036 c035)

(bond c035 h137)
(bond h137 c035)

(bond c035 h138)
(bond h138 c035)

(bond c036 c037)
(bond c037 c036)

(bond c036 h139)
(bond h139 c036)

(bond c036 h140)
(bond h140 c036)

(bond c037 c038)
(bond c038 c037)

(bond c037 h141)
(bond h141 c037)

(bond c037 h142)
(bond h142 c037)

(bond c038 h143)
(bond h143 c038)

(bond c038 h144)
(bond h144 c038)

(bond c051 o065)
(bond o065 c051)

(bond c051 c052)
(bond c052 c051)

(bond c051 h167)
(bond h167 c051)

(bond c051 h166)
(bond h166 c051)

(bond c052 c053)
(bond c053 c052)

(bond c052 h060)
(bond h060 c052)

(bond c052 h168)
(bond h168 c052)

(bond c053 c054)
(bond c054 c053)

(bond c053 h169)
(bond h169 c053)

(bond c053 h170)
(bond h170 c053)

(bond c054 c055)
(bond c055 c054)

(bond c054 h171)
(bond h171 c054)

(bond c054 h172)
(bond h172 c054)

(bond c055 h174)
(bond h174 c055)

(bond c055 h173)
(bond h173 c055)

(bond c055 h175)
(bond h175 c055)
)
)
)