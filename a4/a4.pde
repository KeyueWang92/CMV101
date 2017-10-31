import org.gicentre.geomap.*;

GeoMap geoMap = new GeoMap(650,20,500,350,this);

Parser p;
Map map;
Line_Chart lc;

void setup(){
  frameRate(10);
  size(1200,800);
  p = new Parser("./data.csv");
  map = new Map(geoMap);
  lc = new Line_Chart(p);
}

void draw(){
  stroke(255);
  fill(255);
  rect(0, 0, width, height);
  map.draw();
  lc.draw();
}
  
void mouseClicked(){
  for(int i = 0; i < lc.bs.length;i++){
    if (lc.bs[i].isMouseOn()){
       //state =  Selected_candidate(i);
       println("clicked " + i);
    }
  }
}