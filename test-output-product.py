from datetime import datetime
import sys
import os

date = datetime.now().isoformat()

print("sys.argv:", sys.argv)

output_dir = sys.argv[1]
with open(os.path.join(output_dir, "write-output.txt"), 'w') as fw:
    fw.write(str(date))
    fw.write(" Output Product Write successfull")
