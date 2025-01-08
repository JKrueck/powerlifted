import os

def generate_pddl_problem(instance_name, num_transformers, houses_per_block):
    # Header for the problem
    pddl_problem = f"(define (problem {instance_name}) (:domain Powerplant)\n"
    
    # Generate the objects section
    pddl_problem += "    (:objects\n"
    # Powerplant and transformers
    pddl_problem += "    p1 - powerplant\n"
    for t in range(1, num_transformers + 1):
        pddl_problem += f"    t{t} - transformer\n"
    # Houses and power lines
    for t in range(1, num_transformers + 1):
        for h in range(1, houses_per_block + 1):
            pddl_problem += f"    h{t}_{h} - house\n"
            pddl_problem += f"    lp{t}_{h} - low_voltage_line\n"
        pddl_problem += f"    HP{t} - high_voltage_line\n"
    for t in range(1, num_transformers+1):
        pddl_problem+= f"   lpTransformer_{t} - low_voltage_line\n"
    pddl_problem += "    )\n"
    
    # Generate the initial state (init section)
    pddl_problem += "    (:init\n"
    pddl_problem += "    (0Volt p1)\n"
    
    # Connections between the powerplant and transformers using high voltage lines
    for t in range(1, num_transformers + 1):
        pddl_problem += f"    (connected p1 t{t} HP{t})\n"
        pddl_problem += f"    (transmissionSafe HP{t})\n"
    
    # Connections between transformers and houses using low voltage lines
    for t in range(1, num_transformers + 1):
        # Chain structure to connect houses without forming a clique
        for h in range(1, houses_per_block):
            pddl_problem += f"    (connected h{t}_{h} h{t}_{h + 1} lp{t}_{h})\n"
            pddl_problem += f"    (transmissionSafe lp{t}_{h})\n"
            pddl_problem += f"    (needsElectricity h{t}_{h})\n"
        pddl_problem += f"    (needsElectricity h{t}_{houses_per_block})\n"
        
        # Connect transformer to the first house in the chain
        pddl_problem += f"    (connected t{t} h{t}_1 lpTransformer_{t})\n"
        pddl_problem += f"    (transmissionSafe lpTransformer_{t})\n"
        pddl_problem += f"    (needsElectricity t{t})\n"
    
    # Add system safety predicate
    pddl_problem += "    (systemsSafe)\n"
    pddl_problem += "    )\n"

    
    # Generate the goal section
    pddl_problem += "    (:goal\n        (and\n"
    for t in range(1, num_transformers + 1):
        for h in range(1, houses_per_block + 1):
            pddl_problem += f"            (230Volt h{t}_{h})\n"
    pddl_problem += "        )\n    )\n"
    pddl_problem += ")\n"
    
    return pddl_problem

# Function to save the PDDL problem instance in the same directory as the script
def save_pddl_problem(instance_name, num_transformers, houses_per_block):
    script_dir = os.path.dirname(os.path.abspath(__file__))  # Get the script's directory
    filename = os.path.join(script_dir, f"{instance_name}.pddl")  # Save in the same directory as the script
    pddl_content = generate_pddl_problem(instance_name, num_transformers, houses_per_block)
    with open(filename, 'w') as file:
        file.write(pddl_content)

# Example usage
if __name__ == "__main__":
    instance_name = "powerplant_instance"
    num_transformers = [1,2,3]  # Number of transformer blocks
    houses_per_block = [3,5,10,20,30,40,40,60,70,80,90,100,200,300,400,500]  # Number of houses per block (non-clique, reachable structure)
    
    for num_trans in num_transformers:
        for houses in houses_per_block:
            save_pddl_problem(instance_name+"_"+str(num_trans)+"_transfomer_"+str(houses)+"_houses", num_trans, houses)
            print(f"PDDL problem instance '"+instance_name+"_"+str(num_trans)+"_transfomer_"+str(houses)+"_houses"+".pddl' with {num_trans} transformers and {houses} houses per block generated successfully!")