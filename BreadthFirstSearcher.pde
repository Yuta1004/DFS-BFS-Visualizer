import java.util.Collections;
import java.util.Queue;
import java.util.ArrayDeque;

class BreadthFirstSearcher{
  private ArrayList<ArrayList<Character>> maze;
  private ArrayList<Pair<Integer, Integer>> route;
  private ArrayList<Pair<Integer, Integer>> visitedPos;
  private ArrayList<ArrayList<Pair<Integer, Integer>>> fromPosMemo;
  private int maze_width, maze_height;
  private int goalX, goalY;
  private int dx[] = {-1, 1, 0, 0};
  private int dy[] = {0, 0, -1, 1};
  
  public void setMaze(ArrayList<ArrayList<Character>> argMaze){
    maze = argMaze;
    maze_width = argMaze.get(0).size();
    maze_height = argMaze.size();
    route = new ArrayList<Pair<Integer, Integer>>();
    visitedPos = new ArrayList<Pair<Integer, Integer>>();
    
    // Init Memo
    fromPosMemo = new ArrayList<ArrayList<Pair<Integer, Integer>>>();
    for(int y = 0; y < maze_height; ++ y){
      fromPosMemo.add(new ArrayList<Pair<Integer, Integer>>());
      for(int x = 0; x < maze_width; ++ x){
        fromPosMemo.get(y).add(new Pair<Integer, Integer>(0, 0));
      }
    }
  }
  
  private void searchShortestRoute(int startX, int startY){
    Queue<Pair<Integer, Integer>> searchPosQueue = new ArrayDeque<Pair<Integer, Integer>>();
    searchPosQueue.add(new Pair<Integer, Integer>(startX, startY));
    
    while(searchPosQueue.size() > 0){
      Pair<Integer, Integer> pos = searchPosQueue.remove();
      int x = pos.getKey();
      int y = pos.getValue();
      
      // 道判定
      if(maze.get(y).get(x) == '#'){        // 壁
        continue;
      }else if(maze.get(y).get(x) == 'G'){  // ゴール
        goalX = x;
        goalY = y;
        break;
      }
      
      // 四方向探索
      for(int idx = 0; idx < 4; ++ idx){
        int mx = x + dx[idx];
        int my = y + dy[idx];
        if(0 <= mx && mx < maze_width && 0 <= my && my < maze_height){
          if(!visitedPos.contains(new Pair<Integer, Integer>(mx, my))){
            fromPosMemo.get(my).set(mx, new Pair<Integer, Integer>(x, y));
            searchPosQueue.add(new Pair<Integer, Integer>(mx, my));
            visitedPos.add(new Pair<Integer, Integer>(mx, my));
          }
        }
      }
    }
  }
  
  public ArrayList<Pair<Integer, Integer>> getGoalRoute(int startX, int startY){
    // Search
    searchShortestRoute(startX, startY);
    
    // Restore Route
    int x = goalX, y = goalY;
    while(x != startX || y != startY){
      route.add(new Pair<Integer, Integer>(x, y));
      x = fromPosMemo.get(y).get(x).getKey();
      y = fromPosMemo.get(y).get(x).getValue();
    }
    route.add(new Pair<Integer, Integer>(x, y));
    
    Collections.reverse(route);
    return route;
  }
}