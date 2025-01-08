(define (problem powerplant_instance_1_transfomer_60_houses) (:domain Powerplant)
    (:objects
    p1 - powerplant
    t1 - transformer
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
   lpTransformer_1 - low_voltage_line
    )
    (:init
    (0Volt p1)
    (connected p1 t1 HP1)
    (transmissionSafe HP1)
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
        )
    )
)
