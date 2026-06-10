from datetime import datetime
import sys
import os

date = datetime.now().isoformat()

print("sys.argv:", sys.argv)
# sys.argv: ['/app/dps-unit-test/test-output-product.py', '/data/work/jobs/2026/06/10/00/51/job-vitek_tutorial_v01__main-20260610T004952.11232Z/output']

output_dir = sys.argv[1]
with open(os.path.join(output_dir, "write-output.txt"), 'w') as fw:
    fw.write(str(date))
    fw.write(" Output Product Write successfull")
