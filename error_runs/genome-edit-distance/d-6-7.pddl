;; original sequence 1: (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 -76 -75 -74 -73 -72 -71 -70 -69 -68 -67 -66 -65 -64 -63 -62 -61 -56 -55 -54 -53 -60 -59 -58 -57 -27 -26 -44 -43 -42 -41 45 46 47 48 -36 -35 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -89 -88 -87 -86 -85 -84 77 78 79 80 81 82 83 90 91 92 93 94 95 96 -105 -104 -103 -102 -101 -100 -99 -98 28 29 30 31 32 33 34 -40 -39 -38 -37 49 50 51 52 -97)
;; original sequence 2: (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 -76 -75 -74 -73 -72 -71 -70 -69 -68 -67 -66 -65 -64 -63 -62 -61 -60 -59 -58 -57 -56 -27 -26 -44 -43 -42 -41 45 46 47 48 -36 -35 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -89 -88 -87 -86 -85 -84 77 78 79 80 81 82 83 90 91 92 93 94 95 96 -55 -54 -53 -105 -104 -103 -102 -101 -100 -99 -98 28 29 30 31 32 33 34 -40 -39 -38 -37 49 50 51 52 -97)
;; simplified sequence 1: (107 -56 110 109 106 108)
;; simplified sequence 2: (107 109 -56 106 110 108)
;; common subsequences: (((-27 -26 -44 -43 -42 -41 45 46 47 48 -36 -35 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -89 -88 -87 -86 -85 -84 77 78 79 80 81 82 83 90 91 92 93 94 95 96) . 106) ((1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 -76 -75 -74 -73 -72 -71 -70 -69 -68 -67 -66 -65 -64 -63 -62 -61) . 107) ((-105 -104 -103 -102 -101 -100 -99 -98 28 29 30 31 32 33 34 -40 -39 -38 -37 49 50 51 52 -97) . 108) ((-60 -59 -58 -57) . 109) ((-55 -54 -53) . 110))
;; #safe insertions/deletions: 0
;; sequence 1 (names): ((normal sub2) (inverted g56) (normal sub5) (normal sub4) (normal sub1) (normal sub3))
;; sequence 2 (names): ((normal sub2) (normal sub4) (inverted g56) (normal sub1) (normal sub5) (normal sub3))

(define (problem asyneuma-to-triodanus) (:domain genome-edit-distance)
        (:objects sub5 sub4 sub3 sub2 sub1 g56)
        (:init (normal sub2) (inverted g56) (normal sub5) (normal sub4)
               (normal sub1) (normal sub3) (present sub2) (present g56)
               (present sub5) (present sub4) (present sub1)
               (present sub3) (cw sub3 sub2) (cw sub1 sub3)
               (cw sub4 sub1) (cw sub5 sub4) (cw g56 sub5)
               (cw sub2 g56) (idle) (= (total-cost) 0))
        (:goal (and (normal sub2) (normal sub4) (inverted g56)
                    (normal sub1) (normal sub5) (normal sub3)
                    (cw sub3 sub2) (cw sub5 sub3) (cw sub1 sub5)
                    (cw g56 sub1) (cw sub4 g56) (cw sub2 sub4)))
        (:metric minimize (total-cost)))