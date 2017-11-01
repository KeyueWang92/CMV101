import org.gicentre.geomap.*;
GeoMap geoMap = new GeoMap(650,20,500,350,this);

int TIME;
String PARTY, STATE;
HashMap<String, Integer> time_to_int;
Parser p;
Map map;
Pie pie_chart;
Line_Chart lc;
Candidate can;

void setup(){
  frameRate(10);
  size(1200,800);
  TIME = 0;
  PARTY = "Republican";
  STATE = "ALL_STATE";
  p = new Parser("./data.csv");
  map = new Map(geoMap);
  pie_chart = new Pie(p);
  lc = new Line_Chart(p);
}

void draw(){
  fill(0);
  //background(0);
  //stroke(255);
  //fill(255);
  rect(0, 0, width, height);
  map.draw();
  pie_chart.draw();
  lc.draw();
}
void mouseClicked(){
  if(mouseButton == LEFT){
    //get the clicked candidate from pie chart
    can = pie_chart.clicked();
    if(can != null){
      PARTY = can.party;
      STATE = can.state;
    }
  }else if (mouseButton == RIGHT){
    PARTY = "ALL_PARTY";
    STATE = "ALL_STATE";
  }
}