import csv
import networkx as nx
from infomap import Infomap
import matplotlib.pyplot as plt


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

            if not dg.has_node(importedFile):
                dg.add_node(importedFile)

            dg.add_edge(importerFile, importedFile)
        
        print("directed graph links: " + str(len(dg.edges)))
        print("directed graph nodes: " + str(len(dg.nodes)))
        return dg
    

def main():
    dg = read_csv_file()
    plt.figure(figsize=(128,128)) 
    nx.draw(dg, pos = nx.kamada_kawai_layout(dg), with_labels=True)
    plt.axis('equal') 
    plt.show()
    plt.savefig("networkx.png")

    im = Infomap(
        ftree=True,
        two_level=True,
        silent=True, 
        node_limit=1000000
    )

    im.add_networkx_graph(dg)

    im.run()        

    tmp = 0
    for link in im.get_links():
        tmp += 1
    
    print(tmp)

    im.write_flow_tree("flowmethod.ftree")


if __name__ == "__main__":
    main()
