(define (problem powerplant_instance_3_transfomer_40_houses) (:domain Powerplant)
    (:objects
    p1 - powerplant
    t1 - transformer
    t2 - transformer
    t3 - transformer
    h1_1 - house
    lp1_1 - low_voltage_line
    h1_2 - house
    lp1_2 - low_voltage_line
    h1_3 - house
    lp1_3 - low_voltage_line
    h1_4 - house
    lp1_4 - low_voltage_line
    h1_5 - house
    lp1_5 - low_voltage_line
    h1_6 - house
    lp1_6 - low_voltage_line
    h1_7 - house
    lp1_7 - low_voltage_line
    h1_8 - house
    lp1_8 - low_voltage_line
    h1_9 - house
    lp1_9 - low_voltage_line
    h1_10 - house
    lp1_10 - low_voltage_line
    h1_11 - house
    lp1_11 - low_voltage_line
    h1_12 - house
    lp1_12 - low_voltage_line
    h1_13 - house
    lp1_13 - low_voltage_line
    h1_14 - house
    lp1_14 - low_voltage_line
    h1_15 - house
    lp1_15 - low_voltage_line
    h1_16 - house
    lp1_16 - low_voltage_line
    h1_17 - house
    lp1_17 - low_voltage_line
    h1_18 - house
    lp1_18 - low_voltage_line
    h1_19 - house
    lp1_19 - low_voltage_line
    h1_20 - house
    lp1_20 - low_voltage_line
    h1_21 - house
    lp1_21 - low_voltage_line
    h1_22 - house
    lp1_22 - low_voltage_line
    h1_23 - house
    lp1_23 - low_voltage_line
    h1_24 - house
    lp1_24 - low_voltage_line
    h1_25 - house
    lp1_25 - low_voltage_line
    h1_26 - house
    lp1_26 - low_voltage_line
    h1_27 - house
    lp1_27 - low_voltage_line
    h1_28 - house
    lp1_28 - low_voltage_line
    h1_29 - house
    lp1_29 - low_voltage_line
    h1_30 - house
    lp1_30 - low_voltage_line
    h1_31 - house
    lp1_31 - low_voltage_line
    h1_32 - house
    lp1_32 - low_voltage_line
    h1_33 - house
    lp1_33 - low_voltage_line
    h1_34 - house
    lp1_34 - low_voltage_line
    h1_35 - house
    lp1_35 - low_voltage_line
    h1_36 - house
    lp1_36 - low_voltage_line
    h1_37 - house
    lp1_37 - low_voltage_line
    h1_38 - house
    lp1_38 - low_voltage_line
    h1_39 - house
    lp1_39 - low_voltage_line
    h1_40 - house
    lp1_40 - low_voltage_line
    HP1 - high_voltage_line
    h2_1 - house
    lp2_1 - low_voltage_line
    h2_2 - house
    lp2_2 - low_voltage_line
    h2_3 - house
    lp2_3 - low_voltage_line
    h2_4 - house
    lp2_4 - low_voltage_line
    h2_5 - house
    lp2_5 - low_voltage_line
    h2_6 - house
    lp2_6 - low_voltage_line
    h2_7 - house
    lp2_7 - low_voltage_line
    h2_8 - house
    lp2_8 - low_voltage_line
    h2_9 - house
    lp2_9 - low_voltage_line
    h2_10 - house
    lp2_10 - low_voltage_line
    h2_11 - house
    lp2_11 - low_voltage_line
    h2_12 - house
    lp2_12 - low_voltage_line
    h2_13 - house
    lp2_13 - low_voltage_line
    h2_14 - house
    lp2_14 - low_voltage_line
    h2_15 - house
    lp2_15 - low_voltage_line
    h2_16 - house
    lp2_16 - low_voltage_line
    h2_17 - house
    lp2_17 - low_voltage_line
    h2_18 - house
    lp2_18 - low_voltage_line
    h2_19 - house
    lp2_19 - low_voltage_line
    h2_20 - house
    lp2_20 - low_voltage_line
    h2_21 - house
    lp2_21 - low_voltage_line
    h2_22 - house
    lp2_22 - low_voltage_line
    h2_23 - house
    lp2_23 - low_voltage_line
    h2_24 - house
    lp2_24 - low_voltage_line
    h2_25 - house
    lp2_25 - low_voltage_line
    h2_26 - house
    lp2_26 - low_voltage_line
    h2_27 - house
    lp2_27 - low_voltage_line
    h2_28 - house
    lp2_28 - low_voltage_line
    h2_29 - house
    lp2_29 - low_voltage_line
    h2_30 - house
    lp2_30 - low_voltage_line
    h2_31 - house
    lp2_31 - low_voltage_line
    h2_32 - house
    lp2_32 - low_voltage_line
    h2_33 - house
    lp2_33 - low_voltage_line
    h2_34 - house
    lp2_34 - low_voltage_line
    h2_35 - house
    lp2_35 - low_voltage_line
    h2_36 - house
    lp2_36 - low_voltage_line
    h2_37 - house
    lp2_37 - low_voltage_line
    h2_38 - house
    lp2_38 - low_voltage_line
    h2_39 - house
    lp2_39 - low_voltage_line
    h2_40 - house
    lp2_40 - low_voltage_line
    HP2 - high_voltage_line
    h3_1 - house
    lp3_1 - low_voltage_line
    h3_2 - house
    lp3_2 - low_voltage_line
    h3_3 - house
    lp3_3 - low_voltage_line
    h3_4 - house
    lp3_4 - low_voltage_line
    h3_5 - house
    lp3_5 - low_voltage_line
    h3_6 - house
    lp3_6 - low_voltage_line
    h3_7 - house
    lp3_7 - low_voltage_line
    h3_8 - house
    lp3_8 - low_voltage_line
    h3_9 - house
    lp3_9 - low_voltage_line
    h3_10 - house
    lp3_10 - low_voltage_line
    h3_11 - house
    lp3_11 - low_voltage_line
    h3_12 - house
    lp3_12 - low_voltage_line
    h3_13 - house
    lp3_13 - low_voltage_line
    h3_14 - house
    lp3_14 - low_voltage_line
    h3_15 - house
    lp3_15 - low_voltage_line
    h3_16 - house
    lp3_16 - low_voltage_line
    h3_17 - house
    lp3_17 - low_voltage_line
    h3_18 - house
    lp3_18 - low_voltage_line
    h3_19 - house
    lp3_19 - low_voltage_line
    h3_20 - house
    lp3_20 - low_voltage_line
    h3_21 - house
    lp3_21 - low_voltage_line
    h3_22 - house
    lp3_22 - low_voltage_line
    h3_23 - house
    lp3_23 - low_voltage_line
    h3_24 - house
    lp3_24 - low_voltage_line
    h3_25 - house
    lp3_25 - low_voltage_line
    h3_26 - house
    lp3_26 - low_voltage_line
    h3_27 - house
    lp3_27 - low_voltage_line
    h3_28 - house
    lp3_28 - low_voltage_line
    h3_29 - house
    lp3_29 - low_voltage_line
    h3_30 - house
    lp3_30 - low_voltage_line
    h3_31 - house
    lp3_31 - low_voltage_line
    h3_32 - house
    lp3_32 - low_voltage_line
    h3_33 - house
    lp3_33 - low_voltage_line
    h3_34 - house
    lp3_34 - low_voltage_line
    h3_35 - house
    lp3_35 - low_voltage_line
    h3_36 - house
    lp3_36 - low_voltage_line
    h3_37 - house
    lp3_37 - low_voltage_line
    h3_38 - house
    lp3_38 - low_voltage_line
    h3_39 - house
    lp3_39 - low_voltage_line
    h3_40 - house
    lp3_40 - low_voltage_line
    HP3 - high_voltage_line
   lpTransformer_1 - low_voltage_line
   lpTransformer_2 - low_voltage_line
   lpTransformer_3 - low_voltage_line
    )
    (:init
    (0Volt p1)
    (connected p1 t1 HP1)
    (transmissionSafe HP1)
    (connected p1 t2 HP2)
    (transmissionSafe HP2)
    (connected p1 t3 HP3)
    (transmissionSafe HP3)
    (connected h1_1 h1_2 lp1_1)
    (transmissionSafe lp1_1)
    (needsElectricity h1_1)
    (connected h1_2 h1_3 lp1_2)
    (transmissionSafe lp1_2)
    (needsElectricity h1_2)
    (connected h1_3 h1_4 lp1_3)
    (transmissionSafe lp1_3)
    (needsElectricity h1_3)
    (connected h1_4 h1_5 lp1_4)
    (transmissionSafe lp1_4)
    (needsElectricity h1_4)
    (connected h1_5 h1_6 lp1_5)
    (transmissionSafe lp1_5)
    (needsElectricity h1_5)
    (connected h1_6 h1_7 lp1_6)
    (transmissionSafe lp1_6)
    (needsElectricity h1_6)
    (connected h1_7 h1_8 lp1_7)
    (transmissionSafe lp1_7)
    (needsElectricity h1_7)
    (connected h1_8 h1_9 lp1_8)
    (transmissionSafe lp1_8)
    (needsElectricity h1_8)
    (connected h1_9 h1_10 lp1_9)
    (transmissionSafe lp1_9)
    (needsElectricity h1_9)
    (connected h1_10 h1_11 lp1_10)
    (transmissionSafe lp1_10)
    (needsElectricity h1_10)
    (connected h1_11 h1_12 lp1_11)
    (transmissionSafe lp1_11)
    (needsElectricity h1_11)
    (connected h1_12 h1_13 lp1_12)
    (transmissionSafe lp1_12)
    (needsElectricity h1_12)
    (connected h1_13 h1_14 lp1_13)
    (transmissionSafe lp1_13)
    (needsElectricity h1_13)
    (connected h1_14 h1_15 lp1_14)
    (transmissionSafe lp1_14)
    (needsElectricity h1_14)
    (connected h1_15 h1_16 lp1_15)
    (transmissionSafe lp1_15)
    (needsElectricity h1_15)
    (connected h1_16 h1_17 lp1_16)
    (transmissionSafe lp1_16)
    (needsElectricity h1_16)
    (connected h1_17 h1_18 lp1_17)
    (transmissionSafe lp1_17)
    (needsElectricity h1_17)
    (connected h1_18 h1_19 lp1_18)
    (transmissionSafe lp1_18)
    (needsElectricity h1_18)
    (connected h1_19 h1_20 lp1_19)
    (transmissionSafe lp1_19)
    (needsElectricity h1_19)
    (connected h1_20 h1_21 lp1_20)
    (transmissionSafe lp1_20)
    (needsElectricity h1_20)
    (connected h1_21 h1_22 lp1_21)
    (transmissionSafe lp1_21)
    (needsElectricity h1_21)
    (connected h1_22 h1_23 lp1_22)
    (transmissionSafe lp1_22)
    (needsElectricity h1_22)
    (connected h1_23 h1_24 lp1_23)
    (transmissionSafe lp1_23)
    (needsElectricity h1_23)
    (connected h1_24 h1_25 lp1_24)
    (transmissionSafe lp1_24)
    (needsElectricity h1_24)
    (connected h1_25 h1_26 lp1_25)
    (transmissionSafe lp1_25)
    (needsElectricity h1_25)
    (connected h1_26 h1_27 lp1_26)
    (transmissionSafe lp1_26)
    (needsElectricity h1_26)
    (connected h1_27 h1_28 lp1_27)
    (transmissionSafe lp1_27)
    (needsElectricity h1_27)
    (connected h1_28 h1_29 lp1_28)
    (transmissionSafe lp1_28)
    (needsElectricity h1_28)
    (connected h1_29 h1_30 lp1_29)
    (transmissionSafe lp1_29)
    (needsElectricity h1_29)
    (connected h1_30 h1_31 lp1_30)
    (transmissionSafe lp1_30)
    (needsElectricity h1_30)
    (connected h1_31 h1_32 lp1_31)
    (transmissionSafe lp1_31)
    (needsElectricity h1_31)
    (connected h1_32 h1_33 lp1_32)
    (transmissionSafe lp1_32)
    (needsElectricity h1_32)
    (connected h1_33 h1_34 lp1_33)
    (transmissionSafe lp1_33)
    (needsElectricity h1_33)
    (connected h1_34 h1_35 lp1_34)
    (transmissionSafe lp1_34)
    (needsElectricity h1_34)
    (connected h1_35 h1_36 lp1_35)
    (transmissionSafe lp1_35)
    (needsElectricity h1_35)
    (connected h1_36 h1_37 lp1_36)
    (transmissionSafe lp1_36)
    (needsElectricity h1_36)
    (connected h1_37 h1_38 lp1_37)
    (transmissionSafe lp1_37)
    (needsElectricity h1_37)
    (connected h1_38 h1_39 lp1_38)
    (transmissionSafe lp1_38)
    (needsElectricity h1_38)
    (connected h1_39 h1_40 lp1_39)
    (transmissionSafe lp1_39)
    (needsElectricity h1_39)
    (needsElectricity h1_40)
    (connected t1 h1_1 lpTransformer_1)
    (transmissionSafe lpTransformer_1)
    (needsElectricity t1)
    (connected h2_1 h2_2 lp2_1)
    (transmissionSafe lp2_1)
    (needsElectricity h2_1)
    (connected h2_2 h2_3 lp2_2)
    (transmissionSafe lp2_2)
    (needsElectricity h2_2)
    (connected h2_3 h2_4 lp2_3)
    (transmissionSafe lp2_3)
    (needsElectricity h2_3)
    (connected h2_4 h2_5 lp2_4)
    (transmissionSafe lp2_4)
    (needsElectricity h2_4)
    (connected h2_5 h2_6 lp2_5)
    (transmissionSafe lp2_5)
    (needsElectricity h2_5)
    (connected h2_6 h2_7 lp2_6)
    (transmissionSafe lp2_6)
    (needsElectricity h2_6)
    (connected h2_7 h2_8 lp2_7)
    (transmissionSafe lp2_7)
    (needsElectricity h2_7)
    (connected h2_8 h2_9 lp2_8)
    (transmissionSafe lp2_8)
    (needsElectricity h2_8)
    (connected h2_9 h2_10 lp2_9)
    (transmissionSafe lp2_9)
    (needsElectricity h2_9)
    (connected h2_10 h2_11 lp2_10)
    (transmissionSafe lp2_10)
    (needsElectricity h2_10)
    (connected h2_11 h2_12 lp2_11)
    (transmissionSafe lp2_11)
    (needsElectricity h2_11)
    (connected h2_12 h2_13 lp2_12)
    (transmissionSafe lp2_12)
    (needsElectricity h2_12)
    (connected h2_13 h2_14 lp2_13)
    (transmissionSafe lp2_13)
    (needsElectricity h2_13)
    (connected h2_14 h2_15 lp2_14)
    (transmissionSafe lp2_14)
    (needsElectricity h2_14)
    (connected h2_15 h2_16 lp2_15)
    (transmissionSafe lp2_15)
    (needsElectricity h2_15)
    (connected h2_16 h2_17 lp2_16)
    (transmissionSafe lp2_16)
    (needsElectricity h2_16)
    (connected h2_17 h2_18 lp2_17)
    (transmissionSafe lp2_17)
    (needsElectricity h2_17)
    (connected h2_18 h2_19 lp2_18)
    (transmissionSafe lp2_18)
    (needsElectricity h2_18)
    (connected h2_19 h2_20 lp2_19)
    (transmissionSafe lp2_19)
    (needsElectricity h2_19)
    (connected h2_20 h2_21 lp2_20)
    (transmissionSafe lp2_20)
    (needsElectricity h2_20)
    (connected h2_21 h2_22 lp2_21)
    (transmissionSafe lp2_21)
    (needsElectricity h2_21)
    (connected h2_22 h2_23 lp2_22)
    (transmissionSafe lp2_22)
    (needsElectricity h2_22)
    (connected h2_23 h2_24 lp2_23)
    (transmissionSafe lp2_23)
    (needsElectricity h2_23)
    (connected h2_24 h2_25 lp2_24)
    (transmissionSafe lp2_24)
    (needsElectricity h2_24)
    (connected h2_25 h2_26 lp2_25)
    (transmissionSafe lp2_25)
    (needsElectricity h2_25)
    (connected h2_26 h2_27 lp2_26)
    (transmissionSafe lp2_26)
    (needsElectricity h2_26)
    (connected h2_27 h2_28 lp2_27)
    (transmissionSafe lp2_27)
    (needsElectricity h2_27)
    (connected h2_28 h2_29 lp2_28)
    (transmissionSafe lp2_28)
    (needsElectricity h2_28)
    (connected h2_29 h2_30 lp2_29)
    (transmissionSafe lp2_29)
    (needsElectricity h2_29)
    (connected h2_30 h2_31 lp2_30)
    (transmissionSafe lp2_30)
    (needsElectricity h2_30)
    (connected h2_31 h2_32 lp2_31)
    (transmissionSafe lp2_31)
    (needsElectricity h2_31)
    (connected h2_32 h2_33 lp2_32)
    (transmissionSafe lp2_32)
    (needsElectricity h2_32)
    (connected h2_33 h2_34 lp2_33)
    (transmissionSafe lp2_33)
    (needsElectricity h2_33)
    (connected h2_34 h2_35 lp2_34)
    (transmissionSafe lp2_34)
    (needsElectricity h2_34)
    (connected h2_35 h2_36 lp2_35)
    (transmissionSafe lp2_35)
    (needsElectricity h2_35)
    (connected h2_36 h2_37 lp2_36)
    (transmissionSafe lp2_36)
    (needsElectricity h2_36)
    (connected h2_37 h2_38 lp2_37)
    (transmissionSafe lp2_37)
    (needsElectricity h2_37)
    (connected h2_38 h2_39 lp2_38)
    (transmissionSafe lp2_38)
    (needsElectricity h2_38)
    (connected h2_39 h2_40 lp2_39)
    (transmissionSafe lp2_39)
    (needsElectricity h2_39)
    (needsElectricity h2_40)
    (connected t2 h2_1 lpTransformer_2)
    (transmissionSafe lpTransformer_2)
    (needsElectricity t2)
    (connected h3_1 h3_2 lp3_1)
    (transmissionSafe lp3_1)
    (needsElectricity h3_1)
    (connected h3_2 h3_3 lp3_2)
    (transmissionSafe lp3_2)
    (needsElectricity h3_2)
    (connected h3_3 h3_4 lp3_3)
    (transmissionSafe lp3_3)
    (needsElectricity h3_3)
    (connected h3_4 h3_5 lp3_4)
    (transmissionSafe lp3_4)
    (needsElectricity h3_4)
    (connected h3_5 h3_6 lp3_5)
    (transmissionSafe lp3_5)
    (needsElectricity h3_5)
    (connected h3_6 h3_7 lp3_6)
    (transmissionSafe lp3_6)
    (needsElectricity h3_6)
    (connected h3_7 h3_8 lp3_7)
    (transmissionSafe lp3_7)
    (needsElectricity h3_7)
    (connected h3_8 h3_9 lp3_8)
    (transmissionSafe lp3_8)
    (needsElectricity h3_8)
    (connected h3_9 h3_10 lp3_9)
    (transmissionSafe lp3_9)
    (needsElectricity h3_9)
    (connected h3_10 h3_11 lp3_10)
    (transmissionSafe lp3_10)
    (needsElectricity h3_10)
    (connected h3_11 h3_12 lp3_11)
    (transmissionSafe lp3_11)
    (needsElectricity h3_11)
    (connected h3_12 h3_13 lp3_12)
    (transmissionSafe lp3_12)
    (needsElectricity h3_12)
    (connected h3_13 h3_14 lp3_13)
    (transmissionSafe lp3_13)
    (needsElectricity h3_13)
    (connected h3_14 h3_15 lp3_14)
    (transmissionSafe lp3_14)
    (needsElectricity h3_14)
    (connected h3_15 h3_16 lp3_15)
    (transmissionSafe lp3_15)
    (needsElectricity h3_15)
    (connected h3_16 h3_17 lp3_16)
    (transmissionSafe lp3_16)
    (needsElectricity h3_16)
    (connected h3_17 h3_18 lp3_17)
    (transmissionSafe lp3_17)
    (needsElectricity h3_17)
    (connected h3_18 h3_19 lp3_18)
    (transmissionSafe lp3_18)
    (needsElectricity h3_18)
    (connected h3_19 h3_20 lp3_19)
    (transmissionSafe lp3_19)
    (needsElectricity h3_19)
    (connected h3_20 h3_21 lp3_20)
    (transmissionSafe lp3_20)
    (needsElectricity h3_20)
    (connected h3_21 h3_22 lp3_21)
    (transmissionSafe lp3_21)
    (needsElectricity h3_21)
    (connected h3_22 h3_23 lp3_22)
    (transmissionSafe lp3_22)
    (needsElectricity h3_22)
    (connected h3_23 h3_24 lp3_23)
    (transmissionSafe lp3_23)
    (needsElectricity h3_23)
    (connected h3_24 h3_25 lp3_24)
    (transmissionSafe lp3_24)
    (needsElectricity h3_24)
    (connected h3_25 h3_26 lp3_25)
    (transmissionSafe lp3_25)
    (needsElectricity h3_25)
    (connected h3_26 h3_27 lp3_26)
    (transmissionSafe lp3_26)
    (needsElectricity h3_26)
    (connected h3_27 h3_28 lp3_27)
    (transmissionSafe lp3_27)
    (needsElectricity h3_27)
    (connected h3_28 h3_29 lp3_28)
    (transmissionSafe lp3_28)
    (needsElectricity h3_28)
    (connected h3_29 h3_30 lp3_29)
    (transmissionSafe lp3_29)
    (needsElectricity h3_29)
    (connected h3_30 h3_31 lp3_30)
    (transmissionSafe lp3_30)
    (needsElectricity h3_30)
    (connected h3_31 h3_32 lp3_31)
    (transmissionSafe lp3_31)
    (needsElectricity h3_31)
    (connected h3_32 h3_33 lp3_32)
    (transmissionSafe lp3_32)
    (needsElectricity h3_32)
    (connected h3_33 h3_34 lp3_33)
    (transmissionSafe lp3_33)
    (needsElectricity h3_33)
    (connected h3_34 h3_35 lp3_34)
    (transmissionSafe lp3_34)
    (needsElectricity h3_34)
    (connected h3_35 h3_36 lp3_35)
    (transmissionSafe lp3_35)
    (needsElectricity h3_35)
    (connected h3_36 h3_37 lp3_36)
    (transmissionSafe lp3_36)
    (needsElectricity h3_36)
    (connected h3_37 h3_38 lp3_37)
    (transmissionSafe lp3_37)
    (needsElectricity h3_37)
    (connected h3_38 h3_39 lp3_38)
    (transmissionSafe lp3_38)
    (needsElectricity h3_38)
    (connected h3_39 h3_40 lp3_39)
    (transmissionSafe lp3_39)
    (needsElectricity h3_39)
    (needsElectricity h3_40)
    (connected t3 h3_1 lpTransformer_3)
    (transmissionSafe lpTransformer_3)
    (needsElectricity t3)
    (systemsSafe)
    )
    (:goal
        (and
            (230Volt h1_1)
            (230Volt h1_2)
            (230Volt h1_3)
            (230Volt h1_4)
            (230Volt h1_5)
            (230Volt h1_6)
            (230Volt h1_7)
            (230Volt h1_8)
            (230Volt h1_9)
            (230Volt h1_10)
            (230Volt h1_11)
            (230Volt h1_12)
            (230Volt h1_13)
            (230Volt h1_14)
            (230Volt h1_15)
            (230Volt h1_16)
            (230Volt h1_17)
            (230Volt h1_18)
            (230Volt h1_19)
            (230Volt h1_20)
            (230Volt h1_21)
            (230Volt h1_22)
            (230Volt h1_23)
            (230Volt h1_24)
            (230Volt h1_25)
            (230Volt h1_26)
            (230Volt h1_27)
            (230Volt h1_28)
            (230Volt h1_29)
            (230Volt h1_30)
            (230Volt h1_31)
            (230Volt h1_32)
            (230Volt h1_33)
            (230Volt h1_34)
            (230Volt h1_35)
            (230Volt h1_36)
            (230Volt h1_37)
            (230Volt h1_38)
            (230Volt h1_39)
            (230Volt h1_40)
            (230Volt h2_1)
            (230Volt h2_2)
            (230Volt h2_3)
            (230Volt h2_4)
            (230Volt h2_5)
            (230Volt h2_6)
            (230Volt h2_7)
            (230Volt h2_8)
            (230Volt h2_9)
            (230Volt h2_10)
            (230Volt h2_11)
            (230Volt h2_12)
            (230Volt h2_13)
            (230Volt h2_14)
            (230Volt h2_15)
            (230Volt h2_16)
            (230Volt h2_17)
            (230Volt h2_18)
            (230Volt h2_19)
            (230Volt h2_20)
            (230Volt h2_21)
            (230Volt h2_22)
            (230Volt h2_23)
            (230Volt h2_24)
            (230Volt h2_25)
            (230Volt h2_26)
            (230Volt h2_27)
            (230Volt h2_28)
            (230Volt h2_29)
            (230Volt h2_30)
            (230Volt h2_31)
            (230Volt h2_32)
            (230Volt h2_33)
            (230Volt h2_34)
            (230Volt h2_35)
            (230Volt h2_36)
            (230Volt h2_37)
            (230Volt h2_38)
            (230Volt h2_39)
            (230Volt h2_40)
            (230Volt h3_1)
            (230Volt h3_2)
            (230Volt h3_3)
            (230Volt h3_4)
            (230Volt h3_5)
            (230Volt h3_6)
            (230Volt h3_7)
            (230Volt h3_8)
            (230Volt h3_9)
            (230Volt h3_10)
            (230Volt h3_11)
            (230Volt h3_12)
            (230Volt h3_13)
            (230Volt h3_14)
            (230Volt h3_15)
            (230Volt h3_16)
            (230Volt h3_17)
            (230Volt h3_18)
            (230Volt h3_19)
            (230Volt h3_20)
            (230Volt h3_21)
            (230Volt h3_22)
            (230Volt h3_23)
            (230Volt h3_24)
            (230Volt h3_25)
            (230Volt h3_26)
            (230Volt h3_27)
            (230Volt h3_28)
            (230Volt h3_29)
            (230Volt h3_30)
            (230Volt h3_31)
            (230Volt h3_32)
            (230Volt h3_33)
            (230Volt h3_34)
            (230Volt h3_35)
            (230Volt h3_36)
            (230Volt h3_37)
            (230Volt h3_38)
            (230Volt h3_39)
            (230Volt h3_40)
        )
    )
)
