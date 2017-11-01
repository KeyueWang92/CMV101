import org.gicentre.geomap.*;
import java.util.*;
GeoMap geoMap = new GeoMap(650,20,500,350,this);

int TIME;
String PARTY, STATE;
HashMap<String, Integer> time_to_int;
Parser p;
Map map;
Pie pie_chart;
Line_Chart lc;
Candidate can;
Candidate can2;

void setup(){
  frameRate(10);
  size(1200,800);
  TIME = 8;
  PARTY = "ALL_PARTY";
  STATE = "ALL_STATE";
  p = new Parser("./data.csv");
  map = new Map(geoMap);
  pie_chart = new Pie(p);
  lc = new Line_Chart(p);
  can = null;
  can2 = null;
}

void draw(){
  fill(0);
  //background(0);
  stroke(0);
  //fill(255);
  rect(0, 0, width, height);
  map.draw();
  pie_chart.draw();
  lc.draw();
}


void mouseClicked(){
  if(mouseButton == LEFT){
    //get the clicked candidate from pie chart
    if (map.clicked() != null) STATE = map.clicked();
    can = pie_chart.clicked();
    can2 = lc.clicked();
    if (can == null){
      can = lc.clicked();
    }
    if(can != null){
      PARTY = can.party;
      STATE = can.state;
    }
    TIME = lc.click_time();
  }else if (mouseButton == RIGHT){
    PARTY = "ALL_PARTY";
    STATE = "ALL_STATE";
    can = null;
    can2 = null;
    TIME = 8;
  }
  
  int id = geoMap.getID(mouseX, mouseY);
  if (id != -1){
    if(map.statefunding.containsKey(id)){
      println("$"+map.statefunding.get(id)/1000000+"M");
      //STATE = Selected_state(id)
      //textAlign(CENTER,CENTER);
      //textSize(30);
      //fill(#ff2088);
      //text("$"+map.statefunding.get(id)/1000000+"M", 900,150);
    }
  }
}