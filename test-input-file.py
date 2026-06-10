from datetime import datetime
import sys
import os

date = datetime.now().isoformat()

print("sys.argv:", sys.argv)
# sys.argv: ['/app/dps-unit-test/test-input-file.py', 'input/vr03.jpg']

input_file = sys.argv[1]
with open(input_file, 'r') as fr:
    print(f"Opening input file {input_file} success")

