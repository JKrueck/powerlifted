import os

def generate_pddl_problem(instance_name, num_hydrogens):
    # Header for the problem
    pddl_problem = f"(define (problem {instance_name}) (:domain ChemicalMod)\n"
    
    # Generate hydrogen objects
    pddl_problem += "(:objects\n"
    for i in range(1, num_hydrogens + 1):
        pddl_problem += f"h{i} - hydrogen\n"
    

    #generate unnessecary objects
    for i in range (1,16):
        pddl_problem += f"l{i} - large\n"
    pddl_problem += ")\n"
    # Generate the initial double bonds (star pattern with h1 as the central atom)
    central_atom = f"h{num_hydrogens}"
    pddl_problem += "(:init\n"
    
    # Create double bonds and add unnecessary preconditions
    for i in range(1, num_hydrogens):
        pddl_problem += f"(doublebond h{i} {central_atom})\n"
        #pddl_problem += f"(doublebond {central_atom} h{i})\n"
        
    # Add unnecessary preconditions for each hydrogen atom
    for i in range(1, 12):
        pddl_problem += f"(unnessecary{i} l{i} l{i+1})\n"
    pddl_problem += ")\n"
    
    # Generate the goal (removing double bonds and adding single bonds)
    pddl_problem += "(:goal\n(and\n"
    for i in range(1, num_hydrogens):
        #pddl_problem += f"(not(doublebond h{i} {central_atom}))\n"
        pddl_problem += f"(removedDoubleBond h{i} {central_atom})\n"
        #pddl_problem += f"(not(doublebond {central_atom} h{i}))\n"
        #pddl_problem += f"(removedDoubleBond {central_atom} h{i})\n"
        pddl_problem += f"(bond h{i} {central_atom})\n"
        #pddl_problem += f"(bond {central_atom} h{i})\n"
    pddl_problem += "))\n)\n"

    return pddl_problem

# Generate and save a problem instance in the same folder as the script
def save_pddl_problem(instance_name, num_hydrogens):
    script_dir = os.path.dirname(os.path.realpath(__file__))  # Get the script's directory
    filename = os.path.join(script_dir, f"{instance_name}.pddl")  # Save in the same directory
    pddl_content = generate_pddl_problem(instance_name, num_hydrogens)
    with open(filename, 'w') as file:
        file.write(pddl_content)

# Example usage
if __name__ == "__main__":
    instance_name = "starbonds_"
    amounts = [10, 20, 30, 40, 50, 75, 100]
    for num_hydrogens in range(10,51):
        instance_name = "starbonds_"
        instance_name += str(num_hydrogens)
        save_pddl_problem(instance_name, num_hydrogens)
        print(f"PDDL problem instance '{instance_name}.pddl' with {num_hydrogens} hydrogens generated successfully!")
