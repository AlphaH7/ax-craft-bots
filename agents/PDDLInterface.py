from collections.abc import Set
from typing import List, Tuple, Union
import requests
import os  # Import the os module
import subprocess

class PDDLInterface:

    COLOURS = ['red', 'blue', 'orange', 'black', 'green']
    ACTIONS = ['move', 'mine', 'pick-up', 'drop', 'start-building', 'deposit', 'complete-building']

    @staticmethod
    # Function to write a problem file
    # Complete this function

    def writeProblem(world_info, file="agents/problem.pddl"):
        # Function that will

        with open(file, "w") as f:

            f.write("(define(problem craft-bots-problem)\n")
            f.write("(:domain craft-bots)\n")

            f.write("(:objects\n ")

            for actor in world_info['actors']:
                f.write("a"+str(actor)+" ")
            f.write("- actor\n ")

            f.write("))\n")
            f.close()

    @staticmethod
    def readPDDLPlan(file: str):
        # Completed already, will read a generated plan from file
        plan = []
        with open(file, "r") as f:
            line = f.readline().strip()
            while line:
                tokens = line.split()
                action = tokens[1][1:]
                params = tokens [2:-1]
                # remove trailing bracket
                params[-1] = params[-1][:-1]
                # remove character prefix and convert colours to ID
                params = [int(p[1:]) if p not in PDDLInterface.COLOURS else PDDLInterface.COLOURS.index(p) for p in params]
                plan.append((action, params))
                line = f.readline().strip()
            f.close()
        return plan

    @staticmethod
    # Completed already
    def generatePlan(domain: str, problem: str, plan: str, verbose=False):
        # Ensure the OPTIC-cplex executable is executable
        os.chmod("./agents/optic-cplex", 0o755)

        # Call OPTIC-cplex to generate the plan
        result = subprocess.run(["./agents/optic-cplex", domain, problem, "-o", plan], capture_output=True, text=True)

        if verbose:
            print(result.stdout)
            if result.stderr:
                print("Error:", result.stderr)

        # Check if the plan was successfully generated
        if result.returncode != 0:
            print("WARN: Plan was not found!")
            return False

        return True

if __name__ == '__main__':
    PDDLInterface.generatePlan("domain-craft-bots.pddl", "problem.pddl", "plan.pddl", verbose=True)
    plan = PDDLInterface.readPDDLPlan('plan.pddl')
    print(plan)