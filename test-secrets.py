from maap.maap import MAAP
from timeit import default_timer as timer

maap = MAAP()

print(maap.secrets.get_secrets())
# before ... maap.secrets.add_secret("EARTHDATA_TOKEN", "ABCD...")
# [{'secret_name': 'foobar'}]
# foobar_

# TODO: TRY ACCESSING earthdata using the
# TODO - export EARTHDATA_USERNAME and EARTHDATA_PASSWORD before the earthaccess.login() call
import os
os.environ["EARTHDATA_TOKEN"] = maap.secrets.get_secret("EARTHDATA_TOKEN")
import earthaccess

from earthaccess import download
auth = earthaccess.login(strategy="environment", persist=True)

# retrieve either an Earthdata login token from the
# `EARTHDATA_TOKEN` environment variable, or a username and password
# pair from the `EARTHDATA_USERNAME` and `EARTHDATA_PASSWORD`
# environment variables (specifying a token takes precedence).

print("example download ...")

start = timer()
earthaccess.download(["https://data.lpdaac.earthdatacloud.nasa.gov/lp-prod-protected/EMITL1BRAD.001/EMIT_L1B_RAD_001_20260102T143123_2600209_005/EMIT_L1B_RAD_001_20260102T143123_2600209_005.nc"], local_path=".")
print("downloaded! ...")

end = timer()
time = (end - start)
print("Download took "+str(time)+"s ("+str(time/60.0)+"min)")
