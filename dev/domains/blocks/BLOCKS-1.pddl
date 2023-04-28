(define (problem BLOCKS-1)
	(:domain BLOCKS)
	(:objects 	b1 b2 b3 b4 b5 b6 b7
 			b8 b9 b10 b11
			b12 b13 b14
			b15 b16 b17 
			b18 b19 b20 b21)
	(:INIT 	(ONTABLE b1) (ONTABLE b2) (ONTABLE b3) (ONTABLE b4) (ONTABLE b5) (ONTABLE b6) (ONTABLE b7)
			(ON b8 b1) (ON b9 b3) (ON b10 b5) (ON b11 b7)
			(ON b12 b2) (ON b13 b4) (ON b14 b6)
			(ON b15 b8) (ON b16 b13) (ON b17 b11)
			(CLEAR b15) (CLEAR b16) (CLEAR b17)
			(ON b18 b12) (ON b19 b9) (ON b20 b10) (ON b21 b14)
			(CLEAR b18) (CLEAR b19) (CLEAR b20) (CLEAR b21)

	)
	(:goal	(AND (ONTABLE b1) (ON b2 b1) (ON b3 b2) (ON b3 b4) (ON b5 b4) (ON b5 b6) (ON b6 b7) (CLEAR b7)
			(ONTABLE b8) (ON b9 b12) (ON b15 b10) (ON b14 b11) (CLEAR b11)
			(ON b8 b12) (ON b9 b13) (ON b10 b14)
			(ONTABLE b15) (ON b18 b16) (ON b16 b17)
			(ON b15 b18) (ON b17 b19) (ON b19 b20) (ON b20 b21) (CLEAR b21))  


	)




)