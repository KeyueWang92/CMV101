class Pie{
  float x, y, dia, start, end;
  float ratio, value;
  ArrayList<Slice> slices = new ArrayList<Slice>();
  ArrayList<Slice> s_to_show;
  color repub, demo, other;
  String curr_state;
  Parser p;
  Pie(Parser p){
    this.p = p;
    this.x = 900;
    this.y = 600;
    this.dia = 600/2;
    this.repub = color(233,29,14);
    this.demo = color(35,32,102);
    this.other = color(203,230,53);
    this.curr_state = "ALL_PARTY";
    for(int i=0; i<p.candidates.length;i++){
      Slice s = new Slice(i, p.candidates[i].getParty(), 
                          p.candidates[i].getName(),
                          p.candidates[i].getFunding());
      if(s.party.equals("Republican")){
        s.setColor(#ffb4b4);
      }else if(s.party.equals("Democrat")){
        s.setColor(#b5deff);
      }else{
        s.setColor(#b3f7af);
      }        
      slices.add(s);
    }
  }
  void draw(){
    s_to_show = arrange(data_filter());
    for(Slice s:s_to_show){
      s.draw();
    }
    for(Slice s:s_to_show){
          if(s.show_data){
            //fill(#CCCC00);
            fill(255);
            textSize(13);
            textAlign(CENTER, CENTER);
            text("Funding: "+s.value[TIME], mouseX, mouseY-35);
            text(s.name, mouseX, mouseY-20);
          }
      }
  }
  Candidate clicked(){
    for(Slice s:s_to_show){
      if(s.mouse_in()){
        return p.candidates[s.id];
      }
    }
    return null;
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
    int id;
    float x, y;
    float[] value;
    String party, name;
    float wid, hgt, start, end;
    color c;
    boolean show_data;
    Slice(int id, String party, String name, float[] value){  
      this.id = id;
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
      return sq(mouseX-(x+10*cos((start+end)/2)))+sq(mouseY-(y+10*sin((start+end)/2))) <= sq(wid/2) &&
              angle >= start && angle <= end;
    }
    
    void draw(){
      color c1 = this.c;
      if(mouse_in()){
        if(this.party.equals("Republican")){
          c1 = repub;
        }else if (this.party.equals("Democrat")){
          c1= demo;
        }else{
          c1 = other;
        }
        this.show_data = true;
      }else{
        this.show_data = false;
      }
      fill(c1);
      if(mouse_in()){
        //stroke(0);
        arc(x+10*cos((start+end)/2), y+10*sin((start+end)/2), wid+15, hgt+15, start, end);
      }else{
        arc(x, y, wid, hgt, start, end, PIE);
        stroke(255);
      }
      strokeWeight(1);
    }
  }
}