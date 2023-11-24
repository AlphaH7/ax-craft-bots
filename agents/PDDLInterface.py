from collections.abc import Set
from typing import List, Tuple, Union
import requests
import subprocess
class PDDLInterface:

    COLOURS = ['red', 'blue', 'orange', 'black', 'green']
    ACTIONS = ['move', 'mine', 'pick-up', 'drop', 'start-building', 'deposit', 'complete-building']

    @staticmethod
    # Function to write a problem file
    # Complete this function

    def writeProblem(world_info, file="agents/problem.pddl"):
        with open(file, "w") as f:
           
            f.write("(define(problem craft-bots-problem)\n")
            f.write("(:domain craft-bots)\n")

            # Write objects
            f.write("(:objects\n")
           
            # Write actors
            for actor in world_info['actors']:
                f.write("a"+str(actor)+" ")
            f.write(" - actor\n")
           
            # Write edges
            for edge in world_info['edges']:
                f.write("e"+str(edge)+" ")
            f.write(" - edge\n")
           
            # Write nodes
            for node in world_info['nodes']:
                f.write("n"+str(node)+" ")
            f.write(" - node\n")
           
            # Write mines
            for mine in world_info['mines']:
                f.write("m"+str(mine)+" ")
            f.write(" - mine\n")
           
            # Write resources
            for resource in PDDLInterface.COLOURS:
                f.write(resource+" ")
            f.write(" - resource\n")
           
            # Write tasks
            for task in world_info['tasks']:
                f.write("t"+str(task)+" ")
            f.write(" - task\n")

            f.write(")\n")
           
            # Write initial state
            f.write("(:init\n")
           
            print(world_info)
           
            for actors_id, actor in world_info['actors'].items():
                f.write("(state a"+str(actors_id)+")\n")
                f.write("(actorloc a"+str(actors_id)+" n"+str(actor['node'])+")\n")
                f.write("(= (carry_limit a"+str(actors_id)+") 0)\n")
                for colour in PDDLInterface.COLOURS:
                    f.write("(= (carrying a"+str(actors_id)+" "+colour+") 0)\n")

            for mine_id, mine in world_info['mines'].items():
                f.write("(mineloc m"+str(mine_id)+" n"+str(mine['node'])+")\n")
                f.write("(available m"+str(mine_id)+" "+PDDLInterface.COLOURS[mine['colour']]+")\n")
                       
            for node, edge in world_info['edges'].items():
                f.write("(connected n"+str(edge['node_a'])+" n"+str(edge['node_b'])+" e"+str(edge['id'])+")\n")
                f.write("(connected n"+str(edge['node_b'])+" n"+str(edge['node_a'])+" e"+str(edge['id'])+")\n")
                       
               
            totr = [0, 0, 0, 0, 0]
           
            for task_id, task in world_info['tasks'].items():
                for i, resource in enumerate(task['needed_resources']):
                    if resource > 0:  # Only write if the resource is needed
                        f.write("(= (rfortask {} t{}) {})\n".format(PDDLInterface.COLOURS[i], task_id, resource))
                        f.write("(= (rdeposit n{} {}) {})\n".format(task['node'], PDDLInterface.COLOURS[i], resource))
                        totr[i] += resource
               
            for i, total in enumerate(totr):
                if total > 0:  # Only write if the total resource is more than 0
                    f.write("(= (max_resources {}) {})\n".format(PDDLInterface.COLOURS[i], total))
                       
            f.write(")\n")

            # Write goal state
            f.write("(:goal (and\n")
           
            # The goal is to complete all tasks
            for task_id, task in world_info['tasks'].items():
                for i, resource in enumerate(task['needed_resources']):
                    if resource > 0:  # Only write if the resource is needed
                        f.write("(= (rfortask {} t{}) 0)\n".format(PDDLInterface.COLOURS[i], task_id))
                                     
            f.write("))\n")

            f.write(")\n")
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
        print('\n\nCreating Plan !')
        subprocess.run(["./agents/optic-cplex -N ./agents/domain-craft-bots.pddl ./agents/problem.pddl | awk '/Solution Found/{flag=1;next} flag {print}' | tail -n +4 > ./agents/plan.pddl "], shell = True, executable="/bin/bash")
        print('\n\nCreated Plan!')
        return True

if __name__ == '__main__':
    PDDLInterface.generatePlan("domain-craft-bots.pddl", "problem.pddl", "plan.pddl", verbose=True)
    plan = PDDLInterface.readPDDLPlan('plan.pddl')
    print(plan)