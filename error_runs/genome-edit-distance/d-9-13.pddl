;; original sequence 1: (1 2 3 4 5 6 7 8 9 10 49 50 51 52 53 28 29 30 31 32 33 34 35 -40 -39 -38 -37 -60 -59 -58 -57 -56 11 12 13 14 15 -76 -75 -74 -73 -72 -71 -70 -69 -68 -67 -66 -65 -64 -63 -62 -61 -27 -26 -44 -43 -42 -41 45 46 47 48 -36 54 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -90 -89 -88 -87 -86 -85 77 78 79 80 81 82 83 84 91 92 93 94 95 96 -55 -105 -104 -103 -102 -101 -100 -99 -98 -97)
;; original sequence 2: (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105)
;; simplified sequence 1: (107 115 111 119 116 114 106 120 118 117 -36 54 108 113 110 112 -55 109)
;; simplified sequence 2: (107 114 -108 -120 111 36 -119 -118 117 115 54 55 -116 -106 110 -113 112 -109)
;; common subsequences: (((-76 -75 -74 -73 -72 -71 -70 -69 -68 -67 -66 -65 -64 -63 -62 -61) . 106) ((1 2 3 4 5 6 7 8 9 10) . 107) ((-25 -24 -23 -22 -21 -20 -19 -18 -17 -16) . 108) ((-105 -104 -103 -102 -101 -100 -99 -98 -97) . 109) ((77 78 79 80 81 82 83 84) . 110) ((28 29 30 31 32 33 34 35) . 111) ((91 92 93 94 95 96) . 112) ((-90 -89 -88 -87 -86 -85) . 113) ((11 12 13 14 15) . 114) ((49 50 51 52 53) . 115) ((-60 -59 -58 -57 -56) . 116) ((45 46 47 48) . 117) ((-44 -43 -42 -41) . 118) ((-40 -39 -38 -37) . 119) ((-27 -26) . 120))
;; #safe insertions/deletions: 0
;; sequence 1 (names): ((normal sub2) (normal sub10) (normal sub6) (normal sub14) (normal sub11) (normal sub9) (normal sub1) (normal sub15) (normal sub13) (normal sub12) (inverted g36) (normal g54) (normal sub3) (normal sub8) (normal sub5) (normal sub7) (inverted g55) (normal sub4))
;; sequence 2 (names): ((normal sub2) (normal sub9) (inverted sub3) (inverted sub15) (normal sub6) (normal g36) (inverted sub14) (inverted sub13) (normal sub12) (normal sub10) (normal g54) (normal g55) (inverted sub11) (inverted sub1) (normal sub5) (inverted sub8) (normal sub7) (inverted sub4))

(define (problem merciera-to-tobacco) (:domain genome-edit-distance)
        (:objects sub15 sub14 sub13 sub12 sub11 sub10 sub9 sub8 sub7
            sub6 sub5 sub4 sub3 sub2 sub1 g55 g54 g36)
        (:init (normal sub2) (normal sub10) (normal sub6)
               (normal sub14) (normal sub11) (normal sub9)
               (normal sub1) (normal sub15) (normal sub13)
               (normal sub12) (inverted g36) (normal g54) (normal sub3)
               (normal sub8) (normal sub5) (normal sub7) (inverted g55)
               (normal sub4) (present sub2) (present sub10)
               (present sub6) (present sub14) (present sub11)
               (present sub9) (present sub1) (present sub15)
               (present sub13) (present sub12) (present g36)
               (present g54) (present sub3) (present sub8)
               (present sub5) (present sub7) (present g55)
               (present sub4) (cw sub4 sub2) (cw g55 sub4)
               (cw sub7 g55) (cw sub5 sub7) (cw sub8 sub5)
               (cw sub3 sub8) (cw g54 sub3) (cw g36 g54) (cw sub12 g36)
               (cw sub13 sub12) (cw sub15 sub13) (cw sub1 sub15)
               (cw sub9 sub1) (cw sub11 sub9) (cw sub14 sub11)
               (cw sub6 sub14) (cw sub10 sub6) (cw sub2 sub10) (idle)
               (= (total-cost) 0))
        (:goal (and (normal sub2) (normal sub9) (inverted sub3)
                    (inverted sub15) (normal sub6) (normal g36)
                    (inverted sub14) (inverted sub13) (normal sub12)
                    (normal sub10) (normal g54) (normal g55)
                    (inverted sub11) (inverted sub1) (normal sub5)
                    (inverted sub8) (normal sub7) (inverted sub4)
                    (cw sub4 sub2) (cw sub7 sub4) (cw sub8 sub7)
                    (cw sub5 sub8) (cw sub1 sub5) (cw sub11 sub1)
                    (cw g55 sub11) (cw g54 g55) (cw sub10 g54)
                    (cw sub12 sub10) (cw sub13 sub12) (cw sub14 sub13)
                    (cw g36 sub14) (cw sub6 g36) (cw sub15 sub6)
                    (cw sub3 sub15) (cw sub9 sub3) (cw sub2 sub9)))
        (:metric minimize (total-cost)))