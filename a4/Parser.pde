class Parser{
  public String[] lines;
  public Candidate[] candidates;
  class Candidate{
    String name;
    String state;
    String party;
    float[] funding;
    Candidate(String name, String state, String party, float[] funding){
      this.name = name;
      this.state = state;
      this.party = party;
      this.funding = funding;
    }
  }
  Parser(String filename) {
    lines = loadStrings(filename);
    candidates = new Candidate[lines.length-1];
    //headers = split(lines[0], ",");
    for(int i = 1; i < lines.length; i++){
      String[] data = split(lines[i], ",");
      String lastname = data[0];
      String firstname = data[1];
      String state = data[2];
      String party = data[3];
      //skip party2
      float[] funding = new float[9];
      funding[0] = float(data[5]);
      funding[1] = float(data[6]);
      funding[2] = float(data[7]);
      funding[3] = float(data[8]);
      funding[4] = float(data[9]);
      funding[5] = float(data[10]);
      funding[6] = float(data[11]);
      funding[7] = float(data[12]);
      funding[8] = float(data[13]);
      candidates[i-1] = new Candidate(lastname+firstname, state, party, funding);
    }
  }
}