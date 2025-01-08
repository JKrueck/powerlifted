(define (problem powerplant_instance_2_transfomer_60_houses) (:domain Powerplant)
    (:objects
    p1 - powerplant
    t1 - transformer
    t2 - transformer
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
    h1_41 - house
    lp1_41 - low_voltage_line
    h1_42 - house
    lp1_42 - low_voltage_line
    h1_43 - house
    lp1_43 - low_voltage_line
    h1_44 - house
    lp1_44 - low_voltage_line
    h1_45 - house
    lp1_45 - low_voltage_line
    h1_46 - house
    lp1_46 - low_voltage_line
    h1_47 - house
    lp1_47 - low_voltage_line
    h1_48 - house
    lp1_48 - low_voltage_line
    h1_49 - house
    lp1_49 - low_voltage_line
    h1_50 - house
    lp1_50 - low_voltage_line
    h1_51 - house
    lp1_51 - low_voltage_line
    h1_52 - house
    lp1_52 - low_voltage_line
    h1_53 - house
    lp1_53 - low_voltage_line
    h1_54 - house
    lp1_54 - low_voltage_line
    h1_55 - house
    lp1_55 - low_voltage_line
    h1_56 - house
    lp1_56 - low_voltage_line
    h1_57 - house
    lp1_57 - low_voltage_line
    h1_58 - house
    lp1_58 - low_voltage_line
    h1_59 - house
    lp1_59 - low_voltage_line
    h1_60 - house
    lp1_60 - low_voltage_line
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
    h2_41 - house
    lp2_41 - low_voltage_line
    h2_42 - house
    lp2_42 - low_voltage_line
    h2_43 - house
    lp2_43 - low_voltage_line
    h2_44 - house
    lp2_44 - low_voltage_line
    h2_45 - house
    lp2_45 - low_voltage_line
    h2_46 - house
    lp2_46 - low_voltage_line
    h2_47 - house
    lp2_47 - low_voltage_line
    h2_48 - house
    lp2_48 - low_voltage_line
    h2_49 - house
    lp2_49 - low_voltage_line
    h2_50 - house
    lp2_50 - low_voltage_line
    h2_51 - house
    lp2_51 - low_voltage_line
    h2_52 - house
    lp2_52 - low_voltage_line
    h2_53 - house
    lp2_53 - low_voltage_line
    h2_54 - house
    lp2_54 - low_voltage_line
    h2_55 - house
    lp2_55 - low_voltage_line
    h2_56 - house
    lp2_56 - low_voltage_line
    h2_57 - house
    lp2_57 - low_voltage_line
    h2_58 - house
    lp2_58 - low_voltage_line
    h2_59 - house
    lp2_59 - low_voltage_line
    h2_60 - house
    lp2_60 - low_voltage_line
    HP2 - high_voltage_line
   lpTransformer_1 - low_voltage_line
   lpTransformer_2 - low_voltage_line
    )
    (:init
    (0Volt p1)
    (connected p1 t1 HP1)
    (transmissionSafe HP1)
    (connected p1 t2 HP2)
    (transmissionSafe HP2)
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
    (connected h1_40 h1_41 lp1_40)
    (transmissionSafe lp1_40)
    (needsElectricity h1_40)
    (connected h1_41 h1_42 lp1_41)
    (transmissionSafe lp1_41)
    (needsElectricity h1_41)
    (connected h1_42 h1_43 lp1_42)
    (transmissionSafe lp1_42)
    (needsElectricity h1_42)
    (connected h1_43 h1_44 lp1_43)
    (transmissionSafe lp1_43)
    (needsElectricity h1_43)
    (connected h1_44 h1_45 lp1_44)
    (transmissionSafe lp1_44)
    (needsElectricity h1_44)
    (connected h1_45 h1_46 lp1_45)
    (transmissionSafe lp1_45)
    (needsElectricity h1_45)
    (connected h1_46 h1_47 lp1_46)
    (transmissionSafe lp1_46)
    (needsElectricity h1_46)
    (connected h1_47 h1_48 lp1_47)
    (transmissionSafe lp1_47)
    (needsElectricity h1_47)
    (connected h1_48 h1_49 lp1_48)
    (transmissionSafe lp1_48)
    (needsElectricity h1_48)
    (connected h1_49 h1_50 lp1_49)
    (transmissionSafe lp1_49)
    (needsElectricity h1_49)
    (connected h1_50 h1_51 lp1_50)
    (transmissionSafe lp1_50)
    (needsElectricity h1_50)
    (connected h1_51 h1_52 lp1_51)
    (transmissionSafe lp1_51)
    (needsElectricity h1_51)
    (connected h1_52 h1_53 lp1_52)
    (transmissionSafe lp1_52)
    (needsElectricity h1_52)
    (connected h1_53 h1_54 lp1_53)
    (transmissionSafe lp1_53)
    (needsElectricity h1_53)
    (connected h1_54 h1_55 lp1_54)
    (transmissionSafe lp1_54)
    (needsElectricity h1_54)
    (connected h1_55 h1_56 lp1_55)
    (transmissionSafe lp1_55)
    (needsElectricity h1_55)
    (connected h1_56 h1_57 lp1_56)
    (transmissionSafe lp1_56)
    (needsElectricity h1_56)
    (connected h1_57 h1_58 lp1_57)
    (transmissionSafe lp1_57)
    (needsElectricity h1_57)
    (connected h1_58 h1_59 lp1_58)
    (transmissionSafe lp1_58)
    (needsElectricity h1_58)
    (connected h1_59 h1_60 lp1_59)
    (transmissionSafe lp1_59)
    (needsElectricity h1_59)
    (needsElectricity h1_60)
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
    (connected h2_40 h2_41 lp2_40)
    (transmissionSafe lp2_40)
    (needsElectricity h2_40)
    (connected h2_41 h2_42 lp2_41)
    (transmissionSafe lp2_41)
    (needsElectricity h2_41)
    (connected h2_42 h2_43 lp2_42)
    (transmissionSafe lp2_42)
    (needsElectricity h2_42)
    (connected h2_43 h2_44 lp2_43)
    (transmissionSafe lp2_43)
    (needsElectricity h2_43)
    (connected h2_44 h2_45 lp2_44)
    (transmissionSafe lp2_44)
    (needsElectricity h2_44)
    (connected h2_45 h2_46 lp2_45)
    (transmissionSafe lp2_45)
    (needsElectricity h2_45)
    (connected h2_46 h2_47 lp2_46)
    (transmissionSafe lp2_46)
    (needsElectricity h2_46)
    (connected h2_47 h2_48 lp2_47)
    (transmissionSafe lp2_47)
    (needsElectricity h2_47)
    (connected h2_48 h2_49 lp2_48)
    (transmissionSafe lp2_48)
    (needsElectricity h2_48)
    (connected h2_49 h2_50 lp2_49)
    (transmissionSafe lp2_49)
    (needsElectricity h2_49)
    (connected h2_50 h2_51 lp2_50)
    (transmissionSafe lp2_50)
    (needsElectricity h2_50)
    (connected h2_51 h2_52 lp2_51)
    (transmissionSafe lp2_51)
    (needsElectricity h2_51)
    (connected h2_52 h2_53 lp2_52)
    (transmissionSafe lp2_52)
    (needsElectricity h2_52)
    (connected h2_53 h2_54 lp2_53)
    (transmissionSafe lp2_53)
    (needsElectricity h2_53)
    (connected h2_54 h2_55 lp2_54)
    (transmissionSafe lp2_54)
    (needsElectricity h2_54)
    (connected h2_55 h2_56 lp2_55)
    (transmissionSafe lp2_55)
    (needsElectricity h2_55)
    (connected h2_56 h2_57 lp2_56)
    (transmissionSafe lp2_56)
    (needsElectricity h2_56)
    (connected h2_57 h2_58 lp2_57)
    (transmissionSafe lp2_57)
    (needsElectricity h2_57)
    (connected h2_58 h2_59 lp2_58)
    (transmissionSafe lp2_58)
    (needsElectricity h2_58)
    (connected h2_59 h2_60 lp2_59)
    (transmissionSafe lp2_59)
    (needsElectricity h2_59)
    (needsElectricity h2_60)
    (connected t2 h2_1 lpTransformer_2)
    (transmissionSafe lpTransformer_2)
    (needsElectricity t2)
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
            (230Volt h1_41)
            (230Volt h1_42)
            (230Volt h1_43)
            (230Volt h1_44)
            (230Volt h1_45)
            (230Volt h1_46)
            (230Volt h1_47)
            (230Volt h1_48)
            (230Volt h1_49)
            (230Volt h1_50)
            (230Volt h1_51)
            (230Volt h1_52)
            (230Volt h1_53)
            (230Volt h1_54)
            (230Volt h1_55)
            (230Volt h1_56)
            (230Volt h1_57)
            (230Volt h1_58)
            (230Volt h1_59)
            (230Volt h1_60)
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
            (230Volt h2_41)
            (230Volt h2_42)
            (230Volt h2_43)
            (230Volt h2_44)
            (230Volt h2_45)
            (230Volt h2_46)
            (230Volt h2_47)
            (230Volt h2_48)
            (230Volt h2_49)
            (230Volt h2_50)
            (230Volt h2_51)
            (230Volt h2_52)
            (230Volt h2_53)
            (230Volt h2_54)
            (230Volt h2_55)
            (230Volt h2_56)
            (230Volt h2_57)
            (230Volt h2_58)
            (230Volt h2_59)
            (230Volt h2_60)
        )
    )
)
