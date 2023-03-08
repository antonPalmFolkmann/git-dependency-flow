import csv
import ctypes

filename="decoded-results.csv"

with open(filename, 'r') as data:
    dictionary = csv.DictReader(data)

    for row in dictionary:
        row["path"] = ctypes.c_size_t(hash(row["path"])).value
        row["modulePath"] = ctypes.c_size_t(hash(row["modulePath"])).value
        print(row["path"], row["modulePath"])
    
    for row in dictionary:
        print(row)