import geojson
import geopandas as gpd

vector_path = "daily-trace-gases/no2-prediction_scored.geojson"

with open(vector_path, "r", encoding="utf-8") as file:
    geojson_data = geojson.load(file)
gdf2 = gpd.GeoDataFrame.from_features(geojson_data["features"])
new_order = ['confidence', 'D_norm_1', 'alpha1', 'number_of_pixels', 'geometry']
gdf2b = gdf2[new_order]
gdf2b = gdf2b.astype({
    'number_of_pixels': 'int32',
})

print(gdf2b)

print("worked!")

# maybe this doesn't fail due to gdal dependencies as the other ones?
# idk ...