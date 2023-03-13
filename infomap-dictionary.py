import csv

def read_csv_file():
    with open("edges.csv", 'r') as data:
        dictionary = csv.DictReader(data)
        index = 1
        vertices = {}
        edges = []

        for row in dictionary:
            path = row["path"]
            modulePath = row["modulePath"]

            if path not in vertices:
                vertices[path] = index
                index += 1
            

            if modulePath not in vertices:
                vertices[modulePath] = index
                index += 1
            
            edges.append(str(vertices[path]) + " " + str(vertices[modulePath]))
            
        return (vertices, edges)


def write_to_pajek_format(vertices, edges):
    with open('pajek.txt', 'w') as writer:
        writer.write("*Vertices " + str(len(vertices)) + "\n")
        for key, value in vertices.items():
            string = str(value) + " \"" + key + "\""
            writer.write(string + "\n")

        writer.write("*Edges " + str(len(edges)) + "\n")
        for edge in edges:
            writer.write(edge + "\n")


def main():
    (vertices, edges) = read_csv_file()
    write_to_pajek_format(vertices, edges)


if __name__ == "__main__":
    main()
