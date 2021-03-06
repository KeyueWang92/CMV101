import java.util.Random;
class Line_Chart{
  float maxfunding;
  float width_bar;
  float gap;
  String[] months;
  float[][] fundings;
  int[][] colors;
  float x_frame = 60;
  float y_frame = 40;
  ArrayList<ArrayList<Line>> lines = new ArrayList<ArrayList<Line>>();
  Button[] bs;
  
  class Line{
    float x1,x2,y1,y2,value1, value2, x, y;
    int index;
    Line(int index, float value1, float value2){
      this.index = index;
      this.value1 = value1;
      this.value2 = value2;
    }
    void draw_line(){
      line(x1, y1, x2, y2); 
    }
    void draw_dot(){
      ellipse(x,y,5,5);
    }
  }
  
  class Button{
    float x, y, wid, hgt;
    String lastname;
    int id;
    color c;
    Button(String lastname, int id, float x, float y){
      this.lastname = lastname;
      this.id = id;
      this.x = x;
      this.y = y;
      wid = 60;
      hgt = 15;
    }
    
    void draw(){
      stroke(255);
      rect(x,y,wid,hgt);
      textAlign(LEFT,TOP);
      fill(20);
      text(lastname,x+2,y);
    }
    
    boolean isMouseOn(){
      if (mouseX >= x && mouseX <= x + wid && mouseY >= y && mouseY <= y + hgt)
      return true;
      else return false;
    }
  }

  Line_Chart(Parser p){
    this.fundings = p.get_fundings();
    this.months = p.get_months();
    this.maxfunding = 0;
    for(int i = 0; i < fundings.length; i++){
      ArrayList<Line> aline = new ArrayList<Line>();
      for(int j = 0 ; j < 8; j++){
        Line l = new Line(j, fundings[i][j], fundings[i][j+1]);
        aline.add(l);
        maxfunding = max(fundings[i][j], maxfunding);
        maxfunding = max(fundings[i][j+1], maxfunding);
      }
      this.lines.add(aline);
    }
    this.set_color();
    width_bar = 0.65*0.8*600/months.length;
    gap = 0.35*0.8*600/months.length;
    this.arrange();
    this.buttons();
  }
  
  void set_color(){
    colors = new int[fundings.length][3];
    float fre = 0.3;
    for(int i = 0; i < fundings.length; i++){
      colors[i][0] = int(sin(fre*(i+5)+0)*127+128);
      colors[i][1] = int(sin(fre*(i+5)+2)*127+128);
      colors[i][2] = int(sin(fre*(i+5)+4)*127+128);
    }
  }
  
  void arrange(){
    for (ArrayList<Line> line: lines){
      for(Line l: line){
      l.x1 = x_frame+ (l.index+1)*gap + (l.index * width_bar) + width_bar/2;
      l.y1 = height - y_frame- height*0.8*l.value1/maxfunding;
      l.x2 = l.x1 + gap + width_bar;
      l.y2 = height - y_frame - height*0.8*l.value2/maxfunding;
      l.x = l.x1;
      l.y = l.y1;
      }
    }
  }
  
  void draw(){    
    //if state == ALL
    //draw_background
    fill(#4e3654);
    stroke(#4e3654);
    rect(2*gap+60,120,(width_bar+gap)*(TIME), 640);
    
    draw_axis();
    draw_buttons();
    
    //draw lines
    if (STATE.equals("ALL_STATE") && PARTY.equals("ALL_PARTY")){
      for(int i = 0; i < fundings.length; i++){
        fill(colors[i][0], colors[i][1], colors[i][2]);
        stroke(colors[i][0], colors[i][1], colors[i][2]);
        draw_aline(lines.get(i));
      }
    } 
    // for selected candidate
    else if (can2 != null){
      int canid = 0;
      for(int i = 0; i < p.candidates.length; i++){
        if (can != p.candidates[i]) {
          fill(220);
          stroke(220);
          draw_aline(lines.get(i));
        }
        else canid = i;
      }
      fill(colors[canid][0], colors[canid][1], colors[canid][2]);
      stroke(colors[canid][0], colors[canid][1], colors[canid][2]);
      draw_aline(lines.get(canid));
    } 
    // for selected party
    else if (can != null){
      String par = PARTY;
      for(int i = 0; i < p.candidates.length;i++){
        if (p.candidates[i].party.equals(par)) {
          println("here");
          fill(colors[i][0], colors[i][1], colors[i][2]);
          stroke(colors[i][0], colors[i][1], colors[i][2]);
        } else {
          fill(220);
          stroke(220);
        }
        draw_aline(lines.get(i));
      }
    }
    //for selected state
    else if (!STATE.equals("ALL_STATE")) {
      ArrayList<Integer> cans = new ArrayList<Integer>();
      for(int i = 0; i < p.candidates.length;i++){
        if (STATE.equals(p.candidates[i].state)) {
          cans.add(i);
        } else {
          fill(200);
          stroke(200);
          draw_aline(lines.get(i));
        }        
      }
      for(int i = 0; i < cans.size();i++){
        int canid = cans.get(i);
        fill(colors[canid][0], colors[canid][1], colors[canid][2]);
        stroke(colors[canid][0], colors[canid][1], colors[canid][2]);
        draw_aline(lines.get(canid));
      }
    }
    //if state == Selected_candidate(index)
    //for(int i = 0; i < p.candidates.length; i++){
    //  if (index == i) {
    //    fill(colors[i][0], colors[i][1], colors[i][2]);
    //    stroke(colors[i][0], colors[i][1], colors[i][2]);
    //  }
    //  else {
    //    fill(220);
    //    stroke(220);
    //  }
    //  draw_aline(lines.get(i));
    //}
    
    //if state == Selected_state(id)
    //int id = 41;
    //for(int i = 0; i < p.candidates.length;i++){
    //  if (map.stateid.get(p.candidates[i].state) == id) {
    //    fill(colors[i][0], colors[i][1], colors[i][2]);
    //    stroke(colors[i][0], colors[i][1], colors[i][2]);
    //  } else {
    //    fill(200);
    //    stroke(200);
    //  }
    //  draw_aline(lines.get(i));
    //}
    
    //if state == Selected_party(party)
    //String par = "Other";
    //for(int i = 0; i < p.candidates.length;i++){
    //  if (p.candidates[i].party.equals(par)) {
    //    fill(colors[i][0], colors[i][1], colors[i][2]);
    //    stroke(colors[i][0], colors[i][1], colors[i][2]);
    //  } else {
    //    fill(200);
    //    stroke(200);
    //  }
    //  draw_aline(lines.get(i));
    //}
  }
  
  void draw_axis(){
    stroke(150);
    fill(150);
    textAlign(LEFT);
    textSize(12);
    // add the x-axis names
    for(int i=0;i<months.length; i++){   
      pushMatrix();
      translate(x_frame + (i+1)*gap + i*width_bar, height-y_frame+10);
      rotate(radians(45));
      text(months[i], 0,0);
      popMatrix(); 
    }

    // add the y-axis lines
    float temp = 800-y_frame;
    float y_gap =  0.8*800/10;
    int y_gap_value = int(maxfunding/10/1000000); //funding in million
    int y_mark = 0; 
    while(temp >= 0.1*800){
      line(x_frame, temp, 600-x_frame+20, temp);
      text(y_mark*y_gap_value + "M", 20, temp);
      y_mark ++;
      temp -= y_gap;
    }
    line(x_frame, height-y_frame, x_frame, temp);
  }
  
  void draw_aline(ArrayList<Line> line){
    //draw lines
    for(Line l: line){
      line(l.x1, l.y1, l.x2, l.y2);
    }
    //draw dots
    for(int i = 0; i < line.size(); i++){
      ellipse(line.get(i).x1,line.get(i).y1,5,5);
    }
    ellipse(line.get(line.size()-1).x2, line.get(line.size()-1).y2, 5,5);
  }
  
  void buttons(){
    bs = new Button[p.candidates.length];
    for (int i = 0; i < p.candidates.length; i++){
      if (i < 9){
        for (i = 0; i < 9; i++){
          Button b = new Button(p.candidates[i].lastname,i,(i+1)*60, y_frame-10);
          b.c = #ffb4b4;
          bs[i] = b;
        }
      } else if (i < 17){
        for (i = 9; i < 17; i++){
          Button b = new Button(p.candidates[i].lastname,i,(i-8)*60, y_frame+5);
          b.c = #ffb4b4;
          bs[i] = b;
        }
      } else if (i < 22){
        for (i = 17; i < 22; i++){
          Button b = new Button(p.candidates[i].lastname,i,(i-16)*60, y_frame+20);
          b.c = #b5deff;
          bs[i] = b;
        }
      } else {
        for (i = 22; i < p.candidates.length; i++){
          Button b = new Button(p.candidates[i].lastname,i,(i-21)*60, y_frame+35);
          b.c = #b3f7af;
          bs[i] = b;
        }
      }
    }
  }
  
  void draw_buttons(){
    for (int i = 0; i < p.candidates.length; i++){
      if (bs[i].isMouseOn()) fill(255);
      else fill(bs[i].c);
      bs[i].draw();
    }
  }
  
  Candidate clicked(){
    for(int i = 0; i < bs.length; i++){
      if(bs[i].isMouseOn()){
        return p.candidates[i];
      }
    }
    return null;
  }
  
  int click_time(){
    for (int i = 0; i < 9; i++){
      if (mouseX >= (2 * gap + 60 + i * (width_bar+gap)) && mouseX <= (2 * gap + 60 + (i+1) * (width_bar+gap))
          && mouseY >= 120 && mouseY <= 760) 
        {
          TIME = i;
          break;
        }
    }
    return TIME;
  }
}