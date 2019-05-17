import java.util.Collections;

class DepthFirstSearcher{
  private ArrayList<ArrayList<Character>> maze;
  private ArrayList<Pair<Integer, Integer>> route;
  private ArrayList<Pair<Integer, Integer>> visitedPos;
  private int maze_width, maze_height;
  private int dx[] = {-1, 1, 0, 0};
  private int dy[] = {0, 0, -1, 1};
  
  public void setMaze(ArrayList<ArrayList<Character>> argMaze){
    maze = argMaze;
    maze_width = argMaze.get(0).size();
    maze_height = argMaze.size();
    route = new ArrayList<Pair<Integer, Integer>>();
    visitedPos = new ArrayList<Pair<Integer, Integer>>();
  }
  
  private boolean recursiveSearch(int x, int y){
    // 探索済みにする
    visitedPos.add(new Pair<Integer, Integer>(x, y));
    
    // 範囲外判定
    if(!(0 <= x && x < maze_width && 0 <= y && y < maze_height)){
      return false;
    }
    
    // 道判定
    if(maze.get(y).get(x) == '#'){        // 壁
      return false;
    }else if(maze.get(y).get(x) == 'G'){  // ゴール
      route.add(new Pair<Integer, Integer>(x, y));
      return true;
    }
    
    // 四方向探索
    for(int idx = 0; idx < 4; ++ idx){
      int mx = x + dx[idx];
      int my = y + dy[idx];
      boolean searchResult = false;
      if(!visitedPos.contains(new Pair<Integer, Integer>(mx, my))){
        searchResult = recursiveSearch(mx, my);
      }
      
      if(searchResult){
        route.add(new Pair<Integer, Integer>(mx, my));
        return true;
      }
    }
    
    return false;
  }
  
  public ArrayList<Pair<Integer, Integer>> getGoalRoute(int startX, int startY){
    recursiveSearch(startX, startY);
    route.add(new Pair<Integer, Integer>(startX, startY));
    Collections.reverse(route);
    return route;
  }
}