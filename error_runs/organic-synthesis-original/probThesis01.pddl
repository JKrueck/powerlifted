(define (problem initialBonds1) (:domain Chemical)
	(:objects
	;solution thing
	AL - aluminium
	C1 - carbon 
	H1 - hydrogen
	H2 - hydrogen
	O1 - oxygen 
	H3 - hydrogen 
	H4 - hydrogen 
	LI - lithium 
	C2 - carbon 
	H5 - hydrogen
	
	H6 - hydrogen
	H7 - hydrogen
	O2 - oxygen 
	)
	(:init
		;solution
		(bond LI AL)
		(bond H1 AL)
		(bond H2 AL)
		(bond H3 AL)
		(bond H4 AL)
		
		(bond H6 AL)
		(bond H7 AL)
		
		(bond C1 C2)
		(bond H5 C1)
		(doublebond O1 C1)
		(doublebond O2 C1)

	)
	(:goal
		(and
			   (bond H2 O1)(bond O1 H2) (bond O1 C1)(bond C1 O1) (bond H1 C1)(bond C1 H1)
			   (bond H7 O2)(bond O2 H7) (bond O2 C1)(bond C1 O2) (bond H6 C1)(bond C1 H6)
		)
	)
)
