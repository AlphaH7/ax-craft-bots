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

    def writeProblem(world_info, file="agents/problem-craftbots.pddl"):
        # Function that will
        with open(file, "w") as f:
            # Writing domain and problem definition
            f.write("(define (problem craft-bots-problem)\n")
            f.write("(:domain craft-bots)\n")

            # Writing objects
            f.write("(:objects\n")
            actors = ["a" + str(actor_id) for actor_id in world_info["actors"].keys()]
            locations = ["l" + str(node_id) for node_id in world_info["nodes"].keys()]
            edges = ["e" + str(edge_id) for edge_id in world_info["edges"].keys()]
            mines = ["m" + str(mine_id) for mine_id in world_info["mines"].keys()]
            resources = ["red", "blue", "orange", "black", "green"]
            tasks = ["t" + str(task_id) for task_id in world_info["tasks"].keys()]
            f.write(" ".join(actors) + " - actor\n")
            f.write(" ".join(edges) + " - edge\n")
            f.write(" ".join(locations) + " - location\n")
            f.write(" ".join(mines) + " - mine\n")
            f.write(" ".join(resources) + " - resource\n")
            f.write(" ".join(tasks) + " - task\n")
            f.write(")\n")

            # Writing initial state
            f.write("(:init\n")
            for actor_id, actor in world_info["actors"].items():
                f.write(f"    (alocation a{actor_id} l{actor['node']})\n")
                f.write(f"    (actorstate a{actor_id})\n")

            for mine_id, mine in world_info["mines"].items():
                f.write(f"    (mlocation m{mine_id} l{mine['node']})\n")
                f.write(f"    (mcolour m{mine_id} {['red', 'blue', 'orange', 'black', 'green'][mine['colour']]})\n")

            for edge_id, edge in world_info["edges"].items():
                f.write(f"    (connects l{edge['node_a']} l{edge['node_b']} e{edge_id})\n")
                f.write(f"    (connects l{edge['node_b']} l{edge['node_a']} e{edge_id})\n")

            for task_id, task in world_info["tasks"].items():
                for i, res_count in enumerate(task["needed_resources"]):
                    if res_count > 0:
                        resource = ['red', 'blue', 'orange', 'black', 'green'][i]
                        f.write(f"    (= (needed_resources {resource} l{task['node']} t{task_id}) {res_count})\n")

            f.write(")\n")

            # Writing goal state
            f.write("(:goal (and\n")
            for task_id, task in world_info["tasks"].items():
                for i, _ in enumerate(task["needed_resources"]):
                    resource = ['red', 'blue', 'orange', 'black', 'green'][i]
                    f.write(f"    (= (needed_resources {resource} l{task['node']} t{task_id}) 0)\n")
            f.write("))\n")

            f.write(")\n")

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
        # data = {'domain': open(domain, 'r').read(), 'problem': open(problem, 'r').read()}
        ##resp = requests.post('https://popf-cloud-solver.herokuapp.com/solve', verify=True, json=data).json()
        #if not 'plan' in resp['result']:
        #    if verbose:
        #        print("WARN: Plan was not found!")
          #      print(resp)
         #   return False
        #with open(plan, 'w') as f:
         #   f.write(''.join([act for act in resp['result']['plan']]))
        #f.close()
        # subprocess.run(["optic-cplex -N /home/alb23153/craft-bots-main/agents/domain-craft-bots.pddl /home/alb23153/craft-bots-main/agents/problem.pddl | awk '/Solution Found/{flag=1;next} flag {print}' | tail -n +4 > /home/alb23153/craft-bots-main/agents/plan.pddl "], shell = True, executable="/bin/bash")
        return True

if __name__ == '__main__':
    PDDLInterface.generatePlan("domain-craft-bots.pddl", "problem.pddl", "plan.pddl", verbose=True)
    print("test arg 4")
    plan = PDDLInterface.readPDDLPlan('plan.pddl')
    print(plan)