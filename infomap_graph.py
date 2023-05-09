import csv
import networkx as nx
from infomap import Infomap


def create_digraph_from_csv():
    with open("data/new_edges.csv", 'r') as edges:
        dg = nx.DiGraph()
        data = csv.DictReader(edges)

        for row in data:
            importerFile = row["importerFile"]
            importedFile = row["importedFile"]

            if importedFile == "NONE":
                continue

            if not dg.has_node(importerFile):
                dg.add_node(importerFile)

            if not dg.has_node(importedFile):
                dg.add_node(importedFile)

            dg.add_edge(importerFile, importedFile)
        
        return dg
    

def main():
    dg = create_digraph_from_csv()
    
    im = Infomap(
        ftree=True,
        two_level=True,
        silent=True, 
        node_limit=1000000
    )

    im.add_networkx_graph(dg)
    im.run()
    im.write_flow_tree("flowmethod.ftree")


if __name__ == "__main__":
    main()
