import javafx.util.Pair;
import java.util.Stack;
import java.util.Collections;

class MazeGenerator{
  private int maze_width, maze_height;
  private Pair<Integer, Integer> startPos, goalPos;
  private ArrayList<ArrayList<Character>> maze;
  private int dx[] = {-2, 0, 2, 0};
  private int dy[] = {0, -2, 0, 2};
  
  private void initMazeArrayList(int arg_maze_width, int arg_maze_height){
    // Init Maze Info
    maze_width = arg_maze_width;
    maze_height = arg_maze_height;
    maze = new ArrayList<ArrayList<Character>>();
    
    // Initialize MazeArrayList
    for(int y = 0; y < maze_height; ++ y){
      maze.add(new ArrayList<Character>());
      for(int x = 0; x < maze_width; ++ x){
        maze.get(y).add('#');
      }
    }
  }
  
  private void digdigMaze(int x, int y){
    // Init Direction
    ArrayList<Integer> directList = new ArrayList<Integer>();
    directList.add(0);
    directList.add(1);
    directList.add(2);
    directList.add(3);
  
    // Dig
   Collections.shuffle(directList);
    for(int idx = 0; idx < 4; ++ idx){
      int mx = x + dx[directList.get(idx)];
      int my = y + dy[directList.get(idx)];
      if(0 <= mx && mx < maze_width && 0 <= my && my < maze_height && maze.get(my).get(mx) == '#'){
        maze.get(my).set((x + mx) / 2, '.');
        maze.get(my).set(mx, '.');
        maze.get((y + my) / 2).set((x + mx) / 2, '.');
        maze.get((y + my) / 2).set(mx, '.');
        digdigMaze(mx, my);
      }
    } 
  }
  
  public void generate(int startX, int startY, int arg_maze_width, int arg_maze_height){
    // Initialize
    initMazeArrayList(arg_maze_width | 1, arg_maze_height | 1);
    startPos = new Pair<Integer, Integer>(startX, startY);
    
    // Maze Generate
    digdigMaze(startX, startY);
    
    // Write Start & Goal
    maze.get(startPos.getKey()).set(startPos.getValue(), 'S');
    int goalX = int(random(maze_width)), goalY = int(random(maze_height));
    while(maze.get(goalY).get(goalX) != '.'){
      goalX = int(random(maze_width));
      goalY = int(random(maze_height));
    }
    goalPos = new Pair<Integer, Integer>(goalX, goalY);
    maze.get(goalY).set(goalX, 'G');
  }
  
  public void printMaze(){
    for(int y = 0; y < maze_height; ++ y){
      for(int x = 0; x < maze_width; ++ x){
        print(maze.get(y).get(x) + " ");
      }
      println();
    }
  }
  
  public ArrayList<ArrayList<Character>> getMaze(){
    return maze;
  }
  
  public Pair<Integer, Integer> getStartPos(){
    return startPos;
  }

  public Pair<Integer, Integer> getGoalPos(){
    return goalPos;
  }
  
  public Pair<Integer, Integer> getMazeSize(){
    return new Pair<Integer, Integer>(maze_width, maze_height);
  }
}