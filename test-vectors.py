import rasterio
import geopandas as gpd
import geojson
import json
from shapely.geometry import Polygon, mapping
import pyogrio

"""
error:
  File "/app/dps-unit-test/daily-trace-gases/utils/vec_utils.py", line 8, in vec_load
    gdf = gpd.read_file(vector_path, use_arrow=True)

ValueError: Found GDAL data directory at /srv/conda/envs/notebook/share/gdal but it does not appear to correctly contain GDAL data files


"""

# (we have that) pip install pyarrow
# (we added) pip install fiona

vector_path = "daily-trace-gases/no2-prediction_scored.geojson"

print(1)
try:
    gdf = gpd.read_file(vector_path, use_arrow=True)
    print(gdf)
except Exception as e:
    print("exception!")
    print(e)

# Disabling arrow will fall back to standard reading inside pyogrio
print(2)
try:
    gdf = gpd.read_file(vector_path, engine="pyogrio", use_arrow=False)
    print(gdf)
except Exception as e:
    print("exception!")
    print(e)



print(3)
try:
    gdf = gpd.read_file(vector_path, engine="fiona")
    print(gdf)
except Exception as e:
    print("exception!")
    print(e)


print(4)
try:
    meta, table = pyogrio.read_arrow(vector_path)
    gdf = gpd.GeoDataFrame.from_arrow(table)
    print(gdf)
except Exception as e:
    print("exception!")
    print(e)

print(5)
print("(Alt maybe try again with exporting GDAL_DATA?")
try:
    import os
    os.environ["GDAL_DATA"] = "/srv/conda/envs/notebook/share/gdal"
    from osgeo import gdal  # Now it should import successfully
    gdf = gpd.read_file(vector_path, use_arrow=True)
    print(gdf)

except Exception as e:
    print("exception!")
    print(e)
