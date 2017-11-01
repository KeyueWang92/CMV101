class Pie{
  float x, y, dia, start, end;
  float ratio, value;
  ArrayList<Slice> slices = new ArrayList<Slice>();
  color repub, demo, other;
  Pie(Parser p){
    this.x = 900;
    this.y = 600;
    this.dia = 600/2;
    this.repub = color(233,29,14);
    this.demo = color(35,32,102);
    this.other = color(203,230,53);
    for(int i=0; i<p.candidates.length;i++){
      Slice s = new Slice(p.candidates[i].getParty(), 
                          p.candidates[i].getName(),
                          p.candidates[i].getFunding());
      if(s.party.equals("Republican")){
        s.setColor(color(233,29,14));
      }else if(s.party.equals("Democrat")){
        s.setColor(color(35,32,102));
      }else{
        s.setColor(color(203,230,53));
      }        
      slices.add(s);
    }
  }
  void draw(){
    ArrayList<Slice> ss = arrange(data_filter());
    //println(ss.size());
    for(Slice s:ss){
      //println(s.party);
      s.draw();
    }
  }
  
  //filter the data by the party it belongs to
  ArrayList<Slice> data_filter(){
    ArrayList<Slice> ss = new ArrayList<Slice>();
    for(Slice s:slices){
      if(PARTY.equals("ALL_PARTY")){
        ss.add(s);
      }else if(PARTY.equals(s.party)){
        ss.add(s);
      }
    }
    return ss;
  }
  //arrange the filtered data with the selected time
  ArrayList<Slice> arrange(ArrayList<Slice> data_filtered){
    float total = 0, ratio;
    for(Slice s:data_filtered){
      total += s.value[TIME];
    }
    ratio = 2*PI/total;
    start = 0.0;
    for(Slice s:data_filtered){
      end = start + s.value[TIME]*ratio;
      s.setLoc(x, y, dia, dia, start, end);
      start = end;
    }
    return data_filtered;
  }
  
  private class Slice{
    float x, y;
    float[] value;
    String party, name;
    float wid, hgt, start, end;
    color c;
    boolean show_data;
    Slice(String party, String name, float[] value){  
      this.party = party;
      this.name = name;
      this.value = value;
    }
    void setColor(color c){
      this.c = c;
    }
    
    void setLoc(float x, float y, float wid, float hgt, float start, float end){
      this.x = x;
      this.y = y;
      this.wid = wid;
      this.hgt = hgt;
      this.start = start;
      this.end = end;
    }
    
    boolean mouse_in(){  
      float angle = atan2(mouseY - y, mouseX - x);  
      if(angle < 0){
        angle += 2*PI;
      }   
      return sq(mouseX-x)+sq(mouseY-y) <= sq(wid/2) &&
              angle >= start && angle <= end;
    }
    
    void draw(){
      fill(this.c);
      if(mouse_in()){
        if(this.party.equals("Republican")){
          fill(repub);
        }else if (this.party.equals("Democrat")){
          fill(demo);
        }else{
          fill(other);
        }
        arc(x, y, wid+15, hgt+15, start, end, PIE);
      }else{
        arc(x, y, wid, hgt, start, end, PIE);
      }
      strokeWeight(2);
    }
  }
}