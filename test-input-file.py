from datetime import datetime
import sys
import os

date = datetime.now().isoformat()

print("sys.argv:", sys.argv)

input_file = sys.argv[1]
with open(input_file, 'r') as fr:
    print(f"Opening input file {input_file} success")

