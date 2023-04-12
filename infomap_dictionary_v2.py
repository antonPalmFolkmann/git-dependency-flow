import csv
import networkx as nx
from infomap import Infomap


def read_csv_file():
    with open("data/new_edges.csv", 'r') as data:
        dg = nx.DiGraph()

        dictionary = csv.DictReader(data)

        for row in dictionary:
            importerFile = row["importerFile"]
            importedFile = row["importedFile"]

            if importedFile == "NONE":
                continue

            if not dg.has_node(importerFile):
                dg.add_node(importerFile)
                dg.add_edge(importerFile, importerFile)

            if not dg.has_node(importedFile):
                dg.add_node(importedFile)
                dg.add_edge(importedFile, importedFile)

            dg.add_edge(importerFile, importedFile)
            
        return dg
    

def main():
    dg = read_csv_file()

    im = Infomap(
        ftree=True,
        two_level=True,
        include_self_links=True,
        silent=True, 
        node_limit=1000000
    )

    im.add_networkx_graph(dg)

    im.run()

    im.write_flow_tree("flowmethod.ftree")


if __name__ == "__main__":
    main()
