;; original sequence 1: (1 2 3 4 5 6 7 8 9 10 49 50 51 52 53 28 29 30 31 32 33 34 35 -40 -39 -38 -37 -60 -59 -58 -57 -56 11 12 13 14 15 -76 -75 -74 -73 -72 -71 -70 -69 -68 -67 -66 -65 -64 -63 -62 -61 -27 -26 -44 -43 -42 -41 45 46 47 48 -36 54 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -90 -89 -88 -87 -86 -85 77 78 79 80 81 82 83 84 91 92 93 94 95 96 -55 -105 -104 -103 -102 -101 -100 -99 -98 -97)
;; original sequence 2: (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 -76 -75 -74 -73 -72 -71 -70 -69 -68 -67 -66 -65 -64 -63 -62 -61 -60 -59 -58 -57 -56 -53 -52 -51 -50 -49 37 38 39 40 -35 -34 -33 -32 -31 -30 -29 -28 -27 -26 -44 -43 -42 -41 45 46 47 48 -36 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -90 -89 -88 -87 -86 -85 -84 77 78 79 80 81 82 83 91 92 93 94 95 96 -55 -54 -105 -104 -103 -102 -101 -100 -99 -98 -97)
;; simplified sequence 1: (110 115 108 114 106 109 54 107 113 84 112 111)
;; simplified sequence 2: (110 106 114 -115 -108 109 107 -84 113 112 -54 111)
;; common subsequences: (((11 12 13 14 15 -76 -75 -74 -73 -72 -71 -70 -69 -68 -67 -66 -65 -64 -63 -62 -61) . 106) ((-25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -90 -89 -88 -87 -86 -85) . 107) ((28 29 30 31 32 33 34 35 -40 -39 -38 -37) . 108) ((-27 -26 -44 -43 -42 -41 45 46 47 48 -36) . 109) ((1 2 3 4 5 6 7 8 9 10) . 110) ((-105 -104 -103 -102 -101 -100 -99 -98 -97) . 111) ((91 92 93 94 95 96 -55) . 112) ((77 78 79 80 81 82 83) . 113) ((-60 -59 -58 -57 -56) . 114) ((49 50 51 52 53) . 115))
;; #safe insertions/deletions: 0
;; sequence 1 (names): ((normal sub5) (normal sub10) (normal sub3) (normal sub9) (normal sub1) (normal sub4) (normal g54) (normal sub2) (normal sub8) (normal g84) (normal sub7) (normal sub6))
;; sequence 2 (names): ((normal sub5) (normal sub1) (normal sub9) (inverted sub10) (inverted sub3) (normal sub4) (normal sub2) (inverted g84) (normal sub8) (normal sub7) (inverted g54) (normal sub6))

(define (problem merciera-to-trachelium) (:domain genome-edit-distance)
        (:objects sub10 sub9 sub8 sub7 sub6 sub5 sub4 sub3 sub2 sub1
            g84 g54)
        (:init (normal sub5) (normal sub10) (normal sub3) (normal sub9)
               (normal sub1) (normal sub4) (normal g54) (normal sub2)
               (normal sub8) (normal g84) (normal sub7) (normal sub6)
               (present sub5) (present sub10) (present sub3)
               (present sub9) (present sub1) (present sub4)
               (present g54) (present sub2) (present sub8)
               (present g84) (present sub7) (present sub6)
               (cw sub6 sub5) (cw sub7 sub6) (cw g84 sub7)
               (cw sub8 g84) (cw sub2 sub8) (cw g54 sub2) (cw sub4 g54)
               (cw sub1 sub4) (cw sub9 sub1) (cw sub3 sub9)
               (cw sub10 sub3) (cw sub5 sub10) (idle)
               (= (total-cost) 0))
        (:goal (and (normal sub5) (normal sub1) (normal sub9)
                    (inverted sub10) (inverted sub3) (normal sub4)
                    (normal sub2) (inverted g84) (normal sub8)
                    (normal sub7) (inverted g54) (normal sub6)
                    (cw sub6 sub5) (cw g54 sub6) (cw sub7 g54)
                    (cw sub8 sub7) (cw g84 sub8) (cw sub2 g84)
                    (cw sub4 sub2) (cw sub3 sub4) (cw sub10 sub3)
                    (cw sub9 sub10) (cw sub1 sub9) (cw sub5 sub1)))
        (:metric minimize (total-cost)))