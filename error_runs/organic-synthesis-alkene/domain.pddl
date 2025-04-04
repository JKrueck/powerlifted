; The variants of the Organic Synthesis domain were created by
; Dr. Russell Viirre, Hadi Qovaizi, and Prof. Mikhail Soutchanski.
;
; This work is licensed under a Creative Commons Attribution,
; NonCommercial, ShareAlike 3.0 Unported License.
;
; For further information, please access the following web page:
; https://www.cs.ryerson.ca/~mes/publications/
(define (domain Chemical)
(:requirements :strips :typing :equality :negative-preconditions)
(:types chemical_atom - object
        phosphorus calcium sulfur magnesium aluminium chromium iron manganese mercury boron copper palladium
        r_group - chemical_atom
        halogen alkalimetal hcno - r_group
        hc nitrogen oxygen - hcno
        hydrogen carbon - hc
        chlorine fluorine bromine iodine astatine - halogen
        lithium sodium potassium rubidium caesium francium - alkalimetal
        )

(:predicates
    (bond ?x - chemical_atom ?y - chemical_atom)
    (doublebond ?x - chemical_atom ?y - chemical_atom)
    (triplebond ?x - chemical_atom ?y - chemical_atom)
    (aromaticbond ?x - chemical_atom ?y - chemical_atom)
    )
    
(:action additionOfROHAcrossGemDisubstitutedAlkene
    :parameters (?c_1 - carbon ?c_2 - carbon ?h_5 - hydrogen ?o_6 - oxygen ?r1_8 - carbon ?h_4 - hydrogen ?r0_7 - hc ?h_3 - hydrogen ?r2_9 - hc)
    :precondition (and (not (= ?c_1 ?c_2)) (not (= ?h_3 ?h_4)) (not (= ?c_2 ?c_1)) (bond ?c_2 ?h_3) (bond ?c_2 ?h_4) (bond ?c_1 ?r1_8) (doublebond ?c_1 ?c_2) (bond ?r0_7 ?c_1) (bond ?o_6 ?h_5) (bond ?r2_9 ?o_6))
    :effect (and (not (doublebond ?c_1 ?c_2)) (not (doublebond ?c_2 ?c_1)) (bond ?c_1 ?c_2) (bond ?c_2 ?c_1) (bond ?c_1 ?o_6) (bond ?o_6 ?c_1) (bond ?c_2 ?h_5) (bond ?h_5 ?c_2) (not (bond ?o_6 ?h_5)) (not (bond ?h_5 ?o_6))))

(:action additionOfROHAcrossMonosubstitutedAlkene
    :parameters (?c_1 - carbon ?h_6 - hydrogen ?o_7 - oxygen ?c_2 - carbon ?r0_8 - hc ?h_4 - hydrogen ?h_5 - hydrogen ?h_3 - hydrogen ?r1_9 - hc)
    :precondition (and (not (= ?c_1 ?c_2)) (not (= ?h_3 ?h_5)) (not (= ?h_3 ?h_4)) (not (= ?h_5 ?h_4)) (bond ?c_1 ?h_3) (bond ?c_2 ?h_5) (bond ?c_2 ?h_4) (doublebond ?c_1 ?c_2) (bond ?r0_8 ?c_1) (bond ?o_7 ?h_6) (bond ?r1_9 ?o_7))
    :effect (and (not (doublebond ?c_1 ?c_2)) (not (doublebond ?c_2 ?c_1)) (bond ?c_1 ?c_2) (bond ?c_2 ?c_1) (bond ?c_1 ?o_7) (bond ?o_7 ?c_1) (bond ?c_2 ?h_6) (bond ?h_6 ?c_2) (not (bond ?o_7 ?h_6)) (not (bond ?h_6 ?o_7))))

(:action additionOfROHAcrossTetrasubstitutedAlkene
    :parameters (?c_1 - carbon ?o_4 - oxygen ?c_2 - carbon ?h_3 - hydrogen ?r1_6 - carbon ?r2_7 - carbon ?r3_8 - carbon ?r0_5 - carbon ?r4_9 - hc)
    :precondition (and (not (= ?c_1 ?c_2)) (not (= ?r3_8 ?r0_5)) (not (= ?r3_8 ?r2_7)) (not (= ?c_2 ?c_1)) (not (= ?r2_7 ?r0_5)) (not (= ?r1_6 ?r0_5)) (not (= ?r1_6 ?r2_7)) (not (= ?r3_8 ?r1_6)) (bond ?c_2 ?r3_8) (bond ?c_1 ?r1_6) (bond ?c_2 ?r2_7) (doublebond ?c_1 ?c_2) (bond ?r0_5 ?c_1) (bond ?o_4 ?h_3) (bond ?r4_9 ?o_4))
    :effect (and (not (doublebond ?c_1 ?c_2)) (not (doublebond ?c_2 ?c_1)) (bond ?c_1 ?c_2) (bond ?c_2 ?c_1) (bond ?c_1 ?o_4) (bond ?o_4 ?c_1) (bond ?c_2 ?h_3) (bond ?h_3 ?c_2) (not (bond ?o_4 ?h_3)) (not (bond ?h_3 ?o_4))))

(:action additionOfROHAcrossTrisubstitutedAlkene
    :parameters (?c_1 - carbon ?o_5 - oxygen ?h_4 - hydrogen ?c_2 - carbon ?r2_8 - carbon ?h_3 - hydrogen ?r0_6 - carbon ?r1_7 - carbon ?r3_9 - hc)
    :precondition (and (not (= ?c_1 ?c_2)) (not (= ?r0_6 ?r2_8)) (not (= ?r0_6 ?r1_7)) (not (= ?r1_7 ?r2_8)) (bond ?r0_6 ?c_1) (bond ?c_1 ?r1_7) (doublebond ?c_1 ?c_2) (bond ?c_2 ?h_3) (bond ?c_2 ?r2_8) (bond ?r3_9 ?o_5) (bond ?o_5 ?h_4))
    :effect (and (not (doublebond ?c_1 ?c_2)) (not (doublebond ?c_2 ?c_1)) (bond ?c_1 ?c_2) (bond ?c_2 ?c_1) (bond ?c_1 ?o_5) (bond ?o_5 ?c_1) (bond ?c_2 ?h_4) (bond ?h_4 ?c_2) (not (bond ?o_5 ?h_4)) (not (bond ?h_4 ?o_5))))

(:action additionOfROHAcrossVicDisubstitutedAlkene
    :parameters (?c_1 - carbon ?c_2 - carbon ?h_5 - hydrogen ?o_6 - oxygen ?r1_8 - carbon ?h_4 - hydrogen ?r0_7 - carbon ?h_3 - hydrogen ?r2_9 - hc)
    :precondition (and (not (= ?c_1 ?c_2)) (not (= ?r1_8 ?r0_7)) (not (= ?h_3 ?h_4)) (bond ?c_1 ?h_3) (bond ?c_2 ?h_4) (bond ?c_2 ?r1_8) (doublebond ?c_1 ?c_2) (bond ?r0_7 ?c_1) (bond ?o_6 ?h_5) (bond ?r2_9 ?o_6))
    :effect (and (not (doublebond ?c_1 ?c_2)) (not (doublebond ?c_2 ?c_1)) (bond ?c_1 ?c_2) (bond ?c_2 ?c_1) (bond ?c_1 ?o_6) (bond ?o_6 ?c_1) (bond ?c_2 ?h_5) (bond ?h_5 ?c_2) (not (bond ?o_6 ?h_5)) (not (bond ?h_5 ?o_6))))

(:action etherFormationBySulfonateDisplacement
    :parameters (?h_5 - hydrogen ?o_4 - oxygen ?c_2 - carbon ?o_3 - oxygen ?o_6 - oxygen ?s_7 - sulfur ?h_1 - hydrogen ?r2_11 - carbon ?o_8 - oxygen ?r1_10 - hc ?r0_9 - hc ?r3_12 - carbon)
    :precondition (and (not (= ?o_3 ?o_4)) (not (= ?o_6 ?o_3)) (not (= ?o_8 ?o_6)) (not (= ?r0_9 ?r1_10)) (not (= ?o_8 ?o_3)) (bond ?c_2 ?h_1) (doublebond ?s_7 ?o_8) (doublebond ?s_7 ?o_6) (bond ?s_7 ?r2_11) (bond ?o_3 ?s_7) (bond ?c_2 ?r0_9) (bond ?c_2 ?r1_10) (bond ?c_2 ?o_3) (bond ?r3_12 ?o_4) (bond ?h_5 ?o_4))
    :effect (and (not (bond ?c_2 ?o_3)) (not (bond ?o_3 ?c_2)) (bond ?c_2 ?o_4) (bond ?o_4 ?c_2) (bond ?o_3 ?h_5) (bond ?h_5 ?o_3) (not (bond ?h_5 ?o_4)) (not (bond ?o_4 ?h_5))))

(:action hydroborationOfDiOrTrisubstitutedAlkene
    :parameters (?c_1 - carbon ?h_4 - hydrogen ?c_2 - carbon ?b_5 - boron ?r0_6 - carbon ?r1_7 - carbon ?h_3 - hydrogen ?r2_8 - hc ?r3_9 - hc ?r3_10 - hc)
    :precondition (and (not (= ?c_1 ?c_2)) (not (= ?r1_7 ?r0_6)) (not (= ?c_2 ?c_1)) (bond ?c_2 ?h_3) (bond ?c_1 ?r2_8) (bond ?c_2 ?r1_7) (doublebond ?c_1 ?c_2) (bond ?r0_6 ?c_1) (not (= ?r3_10 ?r3_9)) (bond ?b_5 ?r3_10) (bond ?b_5 ?h_4) (bond ?r3_9 ?b_5))
    :effect (and (not (doublebond ?c_1 ?c_2)) (not (doublebond ?c_2 ?c_1)) (bond ?c_1 ?c_2) (bond ?c_2 ?c_1) (bond ?c_1 ?h_4) (bond ?h_4 ?c_1) (bond ?c_2 ?b_5) (bond ?b_5 ?c_2) (not (bond ?b_5 ?h_4)) (not (bond ?h_4 ?b_5))))

(:action hydroborationOfGemDisubstitutedAlkene
    :parameters (?c_1 - carbon ?c_2 - carbon ?b_6 - boron ?h_5 - hydrogen ?r1_8 - carbon ?h_4 - hydrogen ?r0_7 - hc ?h_3 - hydrogen ?r2_9 - hc ?r2_10 - hc)
    :precondition (and (not (= ?c_1 ?c_2)) (not (= ?h_3 ?h_4)) (not (= ?c_2 ?c_1)) (bond ?c_2 ?h_3) (bond ?c_2 ?h_4) (bond ?c_1 ?r1_8) (doublebond ?c_1 ?c_2) (bond ?r0_7 ?c_1) (not (= ?r2_10 ?r2_9)) (bond ?b_6 ?r2_10) (bond ?b_6 ?h_5) (bond ?r2_9 ?b_6))
    :effect (and (not (doublebond ?c_1 ?c_2)) (not (doublebond ?c_2 ?c_1)) (bond ?c_1 ?c_2) (bond ?c_2 ?c_1) (bond ?c_1 ?h_5) (bond ?h_5 ?c_1) (bond ?c_2 ?b_6) (bond ?b_6 ?c_2) (not (bond ?b_6 ?h_5)) (not (bond ?h_5 ?b_6))))

(:action hydroborationOfMonosubstitutedAlkene
    :parameters (?c_1 - carbon ?h_6 - hydrogen ?c_2 - carbon ?b_7 - boron ?r0_8 - hc ?h_4 - hydrogen ?h_5 - hydrogen ?h_3 - hydrogen ?r1_10 - hc ?r1_9 - hc)
    :precondition (and (not (= ?c_1 ?c_2)) (not (= ?h_3 ?h_5)) (not (= ?h_3 ?h_4)) (not (= ?h_5 ?h_4)) (bond ?c_1 ?h_3) (bond ?c_2 ?h_5) (bond ?c_2 ?h_4) (doublebond ?c_1 ?c_2) (bond ?r0_8 ?c_1) (not (= ?r1_9 ?r1_10)) (bond ?b_7 ?r1_9) (bond ?b_7 ?h_6) (bond ?r1_10 ?b_7))
    :effect (and (not (doublebond ?c_1 ?c_2)) (not (doublebond ?c_2 ?c_1)) (bond ?c_1 ?c_2) (bond ?c_2 ?c_1) (bond ?c_1 ?h_6) (bond ?h_6 ?c_1) (bond ?c_2 ?b_7) (bond ?b_7 ?c_2) (not (bond ?b_7 ?h_6)) (not (bond ?h_6 ?b_7))))

(:action hydroborationOfTetrasubstitutedAlkene
    :parameters (?c_1 - carbon ?c_2 - carbon ?b_4 - boron ?h_3 - hydrogen ?r1_6 - carbon ?r2_7 - carbon ?r3_8 - carbon ?r0_5 - carbon ?r4_10 - hc ?r4_9 - hc)
    :precondition (and (not (= ?c_1 ?c_2)) (not (= ?r3_8 ?r0_5)) (not (= ?r2_7 ?r1_6)) (not (= ?r3_8 ?r2_7)) (not (= ?c_2 ?c_1)) (not (= ?r2_7 ?r0_5)) (not (= ?r1_6 ?r0_5)) (not (= ?r3_8 ?r1_6)) (bond ?c_2 ?r3_8) (bond ?c_1 ?r2_7) (bond ?c_2 ?r1_6) (doublebond ?c_1 ?c_2) (bond ?r0_5 ?c_1) (not (= ?r4_9 ?r4_10)) (bond ?b_4 ?r4_9) (bond ?b_4 ?h_3) (bond ?r4_10 ?b_4))
    :effect (and (not (doublebond ?c_1 ?c_2)) (not (doublebond ?c_2 ?c_1)) (bond ?c_1 ?c_2) (bond ?c_2 ?c_1) (bond ?c_1 ?h_3) (bond ?h_3 ?c_1) (bond ?c_2 ?b_4) (bond ?b_4 ?c_2) (not (bond ?b_4 ?h_3)) (not (bond ?h_3 ?b_4))))

(:action oxidationOfBorane
    :parameters (?o_5 - oxygen ?o_4 - oxygen ?o_6 - oxygen ?o_1 - oxygen ?o_3 - oxygen ?o_2 - oxygen ?r2_16 - hc ?r0_14 - hc ?b_13 - boron ?r1_15 - hc ?h_7 - hydrogen ?h_8 - hydrogen ?h_10 - hydrogen ?h_9 - hydrogen ?h_11 - hydrogen ?h_12 - hydrogen)
    :precondition (and (not (= ?r0_14 ?r1_15)) (not (= ?r0_14 ?r2_16)) (not (= ?r1_15 ?r2_16)) (not (= ?o_1 ?o_2)) (not (= ?o_1 ?o_3)) (not (= ?o_1 ?o_4)) (not (= ?o_1 ?o_5)) (not (= ?o_1 ?o_6)) (not (= ?o_2 ?o_3)) (not (= ?o_2 ?o_4)) (not (= ?o_2 ?o_5)) (not (= ?o_2 ?o_6)) (not (= ?o_3 ?o_4)) (not (= ?o_3 ?o_5)) (not (= ?o_3 ?o_6)) (not (= ?o_4 ?o_5)) (not (= ?o_4 ?o_6)) (not (= ?o_5 ?o_6)) (not (= ?r1_15 ?r0_14)) (not (= ?r2_16 ?r0_14)) (bond ?b_13 ?r1_15) (bond ?b_13 ?r2_16) (bond ?r0_14 ?b_13) (not (= ?h_8 ?h_7)) (not (= ?o_2 ?o_1)) (bond ?o_2 ?h_8) (bond ?o_1 ?o_2) (bond ?h_7 ?o_1) (not (= ?o_4 ?o_3)) (not (= ?h_10 ?h_9)) (bond ?o_4 ?h_10) (bond ?o_3 ?o_4) (bond ?h_9 ?o_3) (not (= ?h_12 ?h_11)) (not (= ?o_6 ?o_5)) (bond ?o_6 ?h_12) (bond ?o_5 ?o_6) (bond ?h_11 ?o_5))
    :effect (and (not (bond ?o_1 ?o_2)) (not (bond ?o_2 ?o_1)) (bond ?r0_14 ?o_1) (bond ?o_1 ?r0_14) (bond ?o_2 ?b_13) (bond ?b_13 ?o_2) (not (bond ?o_3 ?o_4)) (not (bond ?o_4 ?o_3)) (bond ?r1_15 ?o_3) (bond ?o_3 ?r1_15) (bond ?b_13 ?o_4) (bond ?o_4 ?b_13) (not (bond ?o_5 ?o_6)) (not (bond ?o_6 ?o_5)) (bond ?r2_16 ?o_5) (bond ?o_5 ?r2_16) (bond ?b_13 ?o_6) (bond ?o_6 ?b_13) (not (bond ?r0_14 ?b_13)) (not (bond ?b_13 ?r0_14)) (not (bond ?b_13 ?r1_15)) (not (bond ?r1_15 ?b_13)) (not (bond ?b_13 ?r2_16)) (not (bond ?r2_16 ?b_13))))

(:action sulfonylationOfAlcohol
    :parameters (?h_2 - hydrogen ?o_1 - oxygen ?s_5 - sulfur ?cl_3 - chlorine ?r0_7 - carbon ?o_4 - oxygen ?r1_8 - carbon ?o_6 - oxygen)
    :precondition (and (bond ?r0_7 ?o_1) (bond ?o_1 ?h_2) (not (= ?o_6 ?o_4)) (doublebond ?s_5 ?o_6) (doublebond ?s_5 ?o_4) (bond ?s_5 ?r1_8) (bond ?cl_3 ?s_5))
    :effect (and (not (bond ?o_1 ?h_2)) (not (bond ?h_2 ?o_1)) (bond ?o_1 ?s_5) (bond ?s_5 ?o_1) (bond ?h_2 ?cl_3) (bond ?cl_3 ?h_2) (not (bond ?cl_3 ?s_5)) (not (bond ?s_5 ?cl_3))))
)
