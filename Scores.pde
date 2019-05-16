JSONArray scores = null;

void readScores() {
  try {
    scores = loadJSONArray("score.json");
  } catch(Exception e) {}
}

void saveScores() {
  if(scores == null) {
    scores = new JSONArray();
  }
  JSONObject score = new JSONObject();
  score.setString("player", enteredName);
  score.setInt("score", game.player.points);
  
  scores.append(score);
  saveJSONArray(scores, "score.json");
}
