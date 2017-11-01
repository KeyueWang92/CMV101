class Map{
  HashMap<String, Integer> stateid;
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
  
  void draw(){
    //background(255);  // Ocean colour
    stroke(0,40);               // Boundary colour
    fill(210);          // Land colour
    geoMap.draw();              // Draw the entire map.
   
    // Find the country at mouse position and draw in different colour.
    int id = geoMap.getID(mouseX, mouseY);
    if (id != -1) {
      fill(180, 120, 120);      // Highlighted land colour.
      geoMap.draw(id);  
      // get the state name using id.
      String name = geoMap.getAttributeTable().findRow(str(id),0).getString("Abbrev");    
      fill(0);
      text(name, mouseX+5, mouseY-5);
    }
  }
}
 