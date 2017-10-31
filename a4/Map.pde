class Map{
  HashMap<String, Integer> stateid;
  HashMap<Integer, Float> statefunding;
  GeoMap geoMap;
  Map(GeoMap geoMap){
    stateid = new HashMap<String, Integer>();
    this.geoMap = geoMap; 
    geoMap.readFile("usContinental");   // Read shapefile.
    //geoMap.writeAttributesAsTable(51); //get mapinfo
    for (int id = 1; id < 52; id++) {
      stateid.put(geoMap.getAttributeTable().findRow(str(id),0).getString("Abbrev"), id);
    }
  }
  
  void arrange(int month){
    statefunding = new HashMap<Integer, Float>();
    for (int i = 0; i < p.candidates.length; i++){
      for (int j = 0; j < month; j++) {
        int stateid = this.stateid.get(p.candidates[i].state);
        if (statefunding.containsKey(stateid)) 
          statefunding.put(stateid,statefunding.get(stateid) + p.candidates[i].funding[j]);
        else statefunding.put(stateid, p.candidates[i].funding[j]);
      }
    }
  }

  void draw(){
    background(255);  // Ocean colour
    stroke(255);               // Boundary colour
    //fill(210); // Land colour
    //geoMap.draw();              // Draw the entire map.
    arrange(9); // init the statefunding based on the parameter "month"
    // redraw the states that appear in the data 
    for (int i = 1; i < 52; i++) {
      if (statefunding.containsKey(i)) fill(select_color(statefunding.get(i)));
      else fill(210);
      geoMap.draw(i);
    }
    // Find the country at mouse position and draw in different colour.
    int id = geoMap.getID(mouseX, mouseY);
    if (id != -1) {
      stroke(#998285);
      strokeWeight(2);
      if (statefunding.containsKey(id)) fill(select_color(statefunding.get(id)));
      else fill(210);
      geoMap.draw(id);
      strokeWeight(1);
      // get the state name using id.
      String name = geoMap.getAttributeTable().findRow(str(id),0).getString("Abbrev"); 
      fill(0);
      text(name, mouseX+5, mouseY-5);
      if (statefunding.containsKey(id)){
        Float funding = statefunding.get(id)/1000000;
        text("$"+funding+"M", mouseX+5, mouseY+10);
      }
    }
  }
  
  color select_color(float funding){
    color c = color(255,int(255-funding/3770000),int(255-funding/1800000));
    return c;
  }
}
 