(define (domain ChemicalMod)
(:requirements :strips :typing :equality)
(:types chemical_atom - object
        hydrogen - chemical_atom
        large - object
)

(:predicates
    (bond ?x - chemical_atom ?y - chemical_atom)
    (doublebond ?x - chemical_atom ?y - chemical_atom)
    (unnessecary1 ?x - large ?y - large)
    (unnessecary2 ?x - large ?y - large)
    (unnessecary3 ?x - large ?y - large)
    (unnessecary4 ?x - large ?y - large)
    (unnessecary5 ?x - large ?y - large)
    (unnessecary6 ?x - large ?y - large)
    (unnessecary7 ?x - large ?y - large)
    (unnessecary8 ?x - large ?y - large)
    (unnessecary9 ?x - large ?y - large)
    (unnessecary10 ?x - large ?y - large)
    (unnessecary11 ?x - large ?y - large)
    (unnessecary12 ?x - large ?y - large)
    (unnessecary13 ?x - large ?y - large)
    (unnessecary14 ?x - large ?y - large)
    (unnessecary15 ?x - large ?y - large)
    (removedDoubleBond ?x - chemical_atom ?y  - chemical_atom)
)
(:action RemoveDoubleBond
	:parameters (?h1 - hydrogen ?h2 - hydrogen
                ?l1 - large ?l2 - large ?l3 - large ?l4 - large ?l5 - large ?l6 - large ?l7 - large ?l8 - large ?l9 - large ?l10 - large ?l11 - large ?l12 - large ?l13 - large ?l14 - large)
	:precondition (and (not(= ?h1 ?h2)) (doublebond ?h1 ?h2)
                        (unnessecary1 ?l1 ?l2)(unnessecary2 ?l2 ?l3)(unnessecary3 ?l3 ?l4)(unnessecary4 ?l4 ?l5)(unnessecary5 ?l5 ?l6)(unnessecary6 ?l6 ?l7)
                        (unnessecary7 ?l7 ?l8)(unnessecary8 ?l8 ?l9)(unnessecary9 ?l9 ?l10)(unnessecary10 ?l10 ?l11)
                        (unnessecary11 ?l11 ?l12))
	:effect (and    (not(doublebond ?h1 ?h2)) (removedDoubleBond ?h1 ?h2)
                    (unnessecary12 ?l12 ?l13)(unnessecary13 ?l13 ?l14))

)
(:action AddBond
	:parameters(?h1 - hydrogen ?h2 - hydrogen
                ?l1 - large ?l2 - large ?l3 - large ?l4 - large ?l5 - large ?l6 - large ?l7 - large ?l8 - large ?l9 - large ?l10 - large ?l11 - large ?l12 - large ?l13 - large ?l14 - large)
	:precondition (and (not(= ?h1 ?h2))
                        (unnessecary1 ?l1 ?l2)(unnessecary2 ?l2 ?l3)(unnessecary3 ?l3 ?l4)(unnessecary4 ?l4 ?l5)(unnessecary5 ?l5 ?l6)(unnessecary6 ?l6 ?l7)
                        (unnessecary7 ?l7 ?l8)(unnessecary8 ?l8 ?l9)(unnessecary9 ?l9 ?l10)(unnessecary10 ?l10 ?l11)
                        (unnessecary11 ?l11 ?l12))
	:effect (and    (bond ?h1 ?h2)
                    (unnessecary12 ?l12 ?l13) (unnessecary13 ?l13 ?l14))
)
)

