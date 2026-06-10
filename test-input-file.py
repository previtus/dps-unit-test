from datetime import datetime
import sys
import os
import argparse

date = datetime.now().isoformat()

# print("sys.argv:", sys.argv)
# sys.argv: ['/app/dps-unit-test/test-input-file.py', 'input/vr03.jpg']

parse = argparse.ArgumentParser(description="Tutorial demo")
parse.add_argument("--input_file", help="Input file to use", required=True)
parse.add_argument("--output_file", help="Output file to write", required=False)
parse.add_argument("--my_input_parameter", help="Foo", required=False)
parse.add_argument("--my_output_parameter", help="Bar", required=False)
args = parse.parse_args()

print("args = ", args)

input_file = args.input_file
with open(input_file, 'r') as fr:
    print(f"Opening input file {input_file} success")
