import csv
from infomap import Infomap


def read_csv_file():
    with open("data/new_edges.csv", 'r') as data:
        dictionary = csv.DictReader(data)
        index = 0
        vertices = {}
        edges = []

        for row in dictionary:
            importerFile = row["importerFile"]
            importedFile = row["importedFile"]

            if importerFile not in vertices:
                vertices[index] = importerFile
                index += 1
            

            if importedFile not in vertices:
                vertices[index] = importedFile
                index += 1
            elif importedFile == "NONE":
                continue
            
            edges.append(str(vertices[importerFile]) + " " + str(vertices[importedFile]))
            
        return (vertices, edges)
    

def main():
    (vertices, edges) = read_csv_file()

    im = Infomap(ftree=True, directed=True)

    im.set_names(vertices)
    im.add_links(edges)

    im.run()

    im.write_flow_tree("flowmethod.ftree")


if __name__ == "__main__":
    main()
