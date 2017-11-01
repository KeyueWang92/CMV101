import org.gicentre.geomap.*;
GeoMap geoMap = new GeoMap(650,20,500,350,this);

int TIME;
String PARTY, STATE;
HashMap<String, Integer> time_to_int;
Parser p;
Map map;
Pie pie_chart;

void setup(){
  size(1200,800);
  TIME = 0;
  PARTY = "Republican";
  STATE = "ALL_STATE";
  p = new Parser("./data.csv");
  map = new Map(geoMap);
  pie_chart = new Pie(p);
}

void draw(){
  map.draw_map();
  pie_chart.draw();
}