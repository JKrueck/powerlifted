(define (domain ChemicalMod)
(:requirements :strips :typing :equality)
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
    (unnessecary1 ?x - chemical_atom)
    (unnessecary2 ?x - chemical_atom)
    (unnessecary3 ?x - chemical_atom)
    (unnessecary4 ?x - chemical_atom)
    (unnessecary5 ?x - chemical_atom)
    (unnessecary6 ?x - chemical_atom)
    (unnessecary7 ?x - chemical_atom)
    (unnessecary8 ?x - chemical_atom)
    (unnessecary9 ?x - chemical_atom)
    (unnessecary10 ?x - chemical_atom)
    (unnessecary11 ?x - chemical_atom ?y - chemical_atom)
    (removedDoubleBond ?x - chemical_atom ?y  - chemical_atom)
)
(:action RemoveDoubleBond
	:parameters (?h1 - hydrogen ?h2 - hydrogen)
	:precondition (and (not(= ?h1 ?h2)) (doublebond ?h1 ?h2)
                        (unnessecary1 ?h1)(unnessecary2 ?h1)(unnessecary3 ?h1)(unnessecary4 ?h1)(unnessecary5 ?h1)(unnessecary6 ?h1)(unnessecary7 ?h1)(unnessecary8 ?h1)(unnessecary9 ?h1)(unnessecary10 ?h1)
                        (unnessecary1 ?h2)(unnessecary2 ?h2)(unnessecary3 ?h2)(unnessecary4 ?h2)(unnessecary5 ?h2)(unnessecary6 ?h2)(unnessecary7 ?h2)(unnessecary8 ?h2)(unnessecary9 ?h2)(unnessecary10 ?h2)
                        (unnessecary11 ?h1 ?h2))
	:effect (and (not(doublebond ?h1 ?h2)) (removedDoubleBond ?h1 ?h2))

)
(:action AddBond
	:parameters(?h1 - hydrogen ?h2 - hydrogen)
	:precondition (and (not(= ?h1 ?h2))
                        (unnessecary1 ?h1)(unnessecary2 ?h1)(unnessecary3 ?h1)(unnessecary4 ?h1)(unnessecary5 ?h1)(unnessecary6 ?h1)(unnessecary7 ?h1)(unnessecary8 ?h1)(unnessecary9 ?h1)(unnessecary10 ?h1)
                        (unnessecary1 ?h2)(unnessecary2 ?h2)(unnessecary3 ?h2)(unnessecary4 ?h2)(unnessecary5 ?h2)(unnessecary6 ?h2)(unnessecary7 ?h2)(unnessecary8 ?h2)(unnessecary9 ?h2)(unnessecary10 ?h2)
                        (unnessecary11 ?h1 ?h2))
	:effect (and (bond ?h1 ?h2))
)
)

