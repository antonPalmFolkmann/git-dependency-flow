import csv
from typing import List

class TrieNode():
    def __init__(self, module: str):
        self.module = module
        self.path = None
        self.children = {}

    # Insert method of TrieNode.
    # Traverses the trie by module components and assigns path to the last node.
    def insert(self, module_components: List[str], path: str):
        if module_components:
            if module_components[0] not in self.children:
                self.children[module_components[0]] = TrieNode(module_components[0])
            self.children[module_components[0]].insert(module_components[1:], path)
        else:
            self.path = path

    # Search method of TrieNode. 
    # Traverses the trie by module components and returns the path of the last node.
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

# Trie data structure for storing modules, classes, functions, constants, and assigns corresponding file paths as value.
# Import data from constants.csv, modules.csv, functions.csv, and classes.csv and insert into the trie.
class Trie():
    def importConstants(self):
        with open("data/constants.csv", "r") as csv_file:
            reader = csv.DictReader(csv_file)
            for line in reader:
                path = line["fileLocation"]
                module = line["constantModule"]
                module_components = module.split(".")
                self.root.insert(module_components, path)
                del module_components[-2]
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


# Map the imported module to the corresponding file path using the edges.csv file.
# Write the new edges to new_edges.csv.
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
                    importedFile = "NONE"
                edges.append(str(importerFile) + "," + ".".join(module_components) + "," + str(importedFile))
    with open("data/new_edges.csv", "w") as writer:
        writer.write("importerFile,importedModule,importedFile" + "\n")
        for edge in edges:
            writer.write(edge + "\n")