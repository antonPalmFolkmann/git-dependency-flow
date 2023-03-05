import csv

filename="decoded-results.csv"

with open(filename, 'r') as data:
    dictionary = csv.DictReader(data)

    for row in dictionary:
        row["path"] = hash(row["path"]) % 3456345643
        row["modulePath"] = hash(row["modulePath"]) % 3456345643
        print(row["path"], row["modulePath"])
    
    for row in dictionary:
        print(row)