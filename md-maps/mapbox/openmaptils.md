# 1.OpenMapTiles 


https://github.com/openmaptiles/openmaptiles


OpenMapTiles is an extensible and open vector tile schema for a OpenStreetMap basemap. It is used to generate vector tiles for openmaptiles.org and openmaptiles.com.
We encourage you to collaborate, reuse and adapt existing layers and add your own layers or use our approach for your own vector tile project. The repository is built on top of the openmaptiles/tools to simplify vector tile creation.
🔗 Docs http://openmaptiles.org/docs
🔗 Schema: http://openmaptiles.org/schema
🔗 Production package: http://openmaptiles.com/

Styles
You can start from several GL styles supporting the OpenMapTiles vector schema.
🔗 Learn how to create Mapbox GL styles with Maputnik and OpenMapTiles.
OSM Bright
Positron
Dark Matter
Klokantech Basic
Klokantech 3D
Fiord Color
Toner

We also ported over our favorite old raster styles (TM2).
🔗 Learn how to create TM2 styles with Mapbox Studio Classic and OpenMapTiles.
Light
Dark
OSM Bright
Pencil
Woodcut
Pirates
Wheatpaste


Schema
OpenMapTiles consists out of a collection of documented and self contained layers you can modify and adapt. Together the layers make up the OpenMapTiles tileset.
🔗 Study the vector tile schema
aeroway
boundary
building
housenumber
landcover
landuse
mountain_peak
park
place
poi
transportation
transportation_name
water
water_name
waterway


Develop
To work on OpenMapTiles you need Docker and Python.
Install Docker. Minimum version is 1.12.3+.
Install Docker Compose. Minimum version is 1.7.1+.
Install OpenMapTiles tools with pip install openmaptiles-tools


Build
Build the tileset.
git clone git@github.com:openmaptiles/openmaptiles.git
cd openmaptiles
# Build the imposm mapping, the tm2source project and collect all SQL scripts
make
# You can also run the build process inside a Docker container
docker run -v $(pwd):/tileset openmaptiles/openmaptiles-tools make
You can execute the following manual steps (for better understanding) or use the provided quickstart.sh script.
./quickstart.sh



Prepare the Database
Now start up the database container.
docker-compose up -d postgres
Import external data from OpenStreetMapData, Natural Earth and OpenStreetMap Lake Labels.
docker-compose run import-water
docker-compose run import-natural-earth
docker-compose run import-lakelines
docker-compose run import-osmborder
Download OpenStreetMap data extracts and store the PBF file in the ./data directory.
cd data
wget http://download.geofabrik.de/europe/albania-latest.osm.pbf
Import OpenStreetMap data with the mapping rules from build/mapping.yaml (which has been created by make).
docker-compose run import-osm


Work on Layers
Each time you modify layer SQL code run make and docker-compose run import-sql.
make clean && make && docker-compose run import-sql

Now you are ready to generate the vector tiles. Using environment variables you can limit the bounding box and zoom levels of what you want to generate (docker-compose.yml).
docker-compose run generate-vectortiles




License
All code in this repository is under the BSD license and the cartography decisions encoded in the schema and SQL are licensed under CC-BY.
Products or services using maps derived from OpenMapTiles schema need to visibly credit "OpenMapTiles.org" or reference "OpenMapTiles" with a link to http://openmaptiles.org/. Exceptions to attribution requirement can be granted on request.
For a browsable electronic map based on OpenMapTiles and OpenStreetMap data, the credit should appear in the corner of the map. For example:
© OpenMapTiles © OpenStreetMap contributors
For printed and static maps a similar attribution should be made in a textual description near the image, in the same fashion as if you cite a photograph.
