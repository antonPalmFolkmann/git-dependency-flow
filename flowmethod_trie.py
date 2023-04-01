# Create class TrieNode. Inputs are self and a string of the module name.
# Set the module name as an attribute of the node.
# Set the path to the file containing the module as an attribute of the node.
# Set the children of the node as an attribute of the node.
# Set the node as a leaf node as an attribute of the node.
import csv
from typing import List


class TrieNode():
    def __init__(self, module: str):
        self.module = module
        self.path = None
        self.children = {}

# Create insert method of TrieNode. Inputs are self and a list of module 
# components as strings and a string of the path to the file containing the module.
# If the first module component is not in the children of the current node,
# create a new node for it and add it to the children of the current node, and give the rest of the module components
# as inputs in the new node.
# If the first module component is in the children of the current node, give the rest of the module components
# as inputs in the child node.
# If the list of module components is empty, set the current node to be a leaf node and set the path to the file containing the module.
    def insert(self, module_components: List[str], path: str):
        if module_components:
            if module_components[0] not in self.children:
                self.children[module_components[0]] = TrieNode(module_components[0])
            self.children[module_components[0]].insert(module_components[1:], path)
        else:
            self.path = path

# Create search method of TrieNode. Inputs are self and a list of module components as strings.
# If the first module component is not in the children of the current node, return None.
# If the first module component is in the children of the current node, give the rest of the module components
# as inputs in the child node.
# If the list of module components is empty, return the path as a string.
    def search(self, module_components: List[str]):
        if module_components:
            if module_components[0] not in self.children:
                return None
            return self.children[module_components[0]].search(module_components[1:])
        else:
            if self.path == None:
                if "__init__" in self.children:
                    return self.children["__init__"].path
                else:
                    return None
            return self.path
        
# Create method print to print the trie.
    def print(self, level=0):
        print("  " * level, self.module)
        for child in self.children.values():
            child.print(level + 1)

# Create class Trie. Import CSV file with module names and paths to files containing the modules from file "modules.csv"
# with the first column containing the module names and the second column containing the paths.

class Trie():
    def importConstants(self):
        with open("data/constants.csv", "r") as csv_file:
            reader = csv.DictReader(csv_file)
            for line in reader:
                path = line["fileLocation"]
                module = line["constantModule"]
                module_components = module.split(".")
                self.root.insert(module_components, path)

    def importModules(self):
        with open("data/modules.csv", "r") as csv_file:
            reader = csv.DictReader(csv_file)
            for line in reader:
                path = line["fileLocation"]
                module = line["moduleName"]
                module_components = module.split(".")
                self.root.insert(module_components, path)
    
    def importFunctions(self):
        with open("data/functions.csv", "r") as csv_file:
            reader = csv.DictReader(csv_file)
            for line in reader:
                path = line["fileLocation"]
                module = line["functionModule"]
                module_components = module.split(".")
                self.root.insert(module_components, path)

    def importClasses(self):
        with open("data/classes.csv", "r") as csv_file:
            reader = csv.DictReader(csv_file)
            for line in reader:
                path = line["fileLocation"]
                module = line["classModule"]
                module_components = module.split(".")
                self.root.insert(module_components, path)
                del module_components[-2]
                self.root.insert(module_components, path)

    def __init__(self):
        self.root = TrieNode("")
        self.importConstants()
        self.importModules()
        self.importFunctions()
        self.importClasses()


# Run the Trie class and print the trie.
if __name__ == "__main__":
    trie = Trie()
    edges = []
    with open("data/edges.csv", "r") as csv_file:
            reader = csv.DictReader(csv_file)
            for line in reader:
                importerFile = line["importerFile"]
                importedModule = line["importedModule"]
                module_components = importedModule.split(".")
                importedFile = trie.root.search(module_components)
                if importedFile == None:
                    print(module_components)
                    importedFile = "NONE"
                edges.append(str(importerFile) + " " + ".".join(module_components) + " " + str(importedFile))
    with open("data/new_edges.csv", "w") as writer:
        for edge in edges:
            writer.write(edge + "\n")