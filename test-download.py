import os.path
import earthaccess
from earthaccess import download

auth = earthaccess.login()
print("auth:")
print(auth)

print("now running earthaccess.download() ...")
earthaccess.download(["https://data.lpdaac.earthdatacloud.nasa.gov/lp-prod-protected/EMITL2BCH4ENH.002/EMIT_L2B_CH4ENH_002_20240616T072726_2416805_025/EMIT_L2B_CH4ENH_002_20240616T072726_2416805_025.tif"], local_path=".")

print("Download completed!")
