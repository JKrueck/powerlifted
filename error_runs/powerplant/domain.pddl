(define (domain Powerplant)
(:requirements :strips :typing :equality)
(:types
    building powerline - object
    powerplant transformer house - building
    high_voltage_line low_voltage_line - powerline
)
(:predicates
    (connected ?x - building ?y - building ?l - powerline)
    (1000Volt ?x - building)
    (230Volt ?x - building)
    (0Volt ?x - building)
    (transmissionSafe ?x - powerline)
    (systemsSafe)
    (needsElectricity ?x - building)
)
(:action StartPowerplant
    :parameters (?p - powerplant)
    :precondition (0Volt ?p)
    :effect (and (not (0Volt ?p)) (1000Volt ?p))
)
(:action TransportHighVoltage
    :parameters (?p - powerplant ?t - transformer ?l - high_voltage_line)
    :precondition (and (connected ?p ?t ?l) (1000Volt ?p) (transmissionSafe ?l) (needsElectricity ?t))
    :effect (1000Volt ?t)
)
(:action TransportLowVoltage
    :parameters (?b - building ?h - house ?l - low_voltage_line)
    :precondition (and (connected ?b ?h ?l) (transmissionSafe ?l) (230Volt ?b) (needsElectricity ?h))
    :effect (230Volt ?h)
)
(:action ChangeVoltage
    :parameters (?t - transformer)
    :precondition (and (1000Volt ?t) (systemsSafe))
    :effect (230Volt ?t)
)
)
