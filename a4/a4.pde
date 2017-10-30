import org.gicentre.geomap.*;
GeoMap geoMap = new GeoMap(650,20,500,350,this);

Parser p;
Map map;
void setup(){
  size(1200,800);
  p = new Parser("./data.csv");
  map = new Map(geoMap);
}

void draw(){
  map.draw_map();
}