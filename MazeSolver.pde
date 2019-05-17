MazeGenerator mazeGenerator = new MazeGenerator();
DepthFirstSearcher depthFirstSearcher = new DepthFirstSearcher();
BreadthFirstSearcher breadthFirstSearcher = new BreadthFirstSearcher();
HashMap<Character, Integer> colors = new HashMap<Character, Integer>();
ArrayList<Pair<Integer, Integer>> DFSGoalRoute, BFSGoalRoute;

int limit = 0;

void setup() {
  size(710, 710);
  frameRate(60);

  mazeGenerator.generate(1, 1, 130, 130);
  mazeGenerator.printMaze();
  colors.put('.', #B9FFC5);
  colors.put('#', #71656B);
  colors.put('S', #FF2C3D);
  colors.put('G', #2C57FF);

  depthFirstSearcher.setMaze(mazeGenerator.getMaze());
  DFSGoalRoute = depthFirstSearcher.getGoalRoute(1, 1);
  breadthFirstSearcher.setMaze(mazeGenerator.getMaze());
  BFSGoalRoute = breadthFirstSearcher.getGoalRoute(1, 1);
}

void draw() {
  // Get Maze Info
  ArrayList<ArrayList<Character>> maze = mazeGenerator.getMaze();
  int maze_width = mazeGenerator.getMazeSize().getKey();
  int maze_height = mazeGenerator.getMazeSize().getKey();

  // Draw Maze
  for (int y = 0; y < maze_height; ++ y) {
    for (int x = 0; x < maze_width; ++ x) {
      fill(colors.get(maze.get(y).get(x)));
      rect(x * 5, y * 5, 5, 5);
    }
  }

  // DFS Goal Route
  for (int idx = 0; idx < min(limit, DFSGoalRoute.size()); ++ idx) {
    int x = DFSGoalRoute.get(idx).getKey();
    int y = DFSGoalRoute.get(idx).getValue();
    fill(255, 0, 0, 100);
    rect(x * 5, y * 5, 5, 5);
  }

  // BFS Goal Route
  for (int idx = 0; idx < min(limit, BFSGoalRoute.size()); ++ idx) {
    int x = BFSGoalRoute.get(idx).getKey();
    int y = BFSGoalRoute.get(idx).getValue();
    fill(0, 0, 255, 100);
    rect(x * 5, y * 5, 5, 5);
  }

  // 終了判定
  if(limit >= DFSGoalRoute.size() && limit >= BFSGoalRoute.size()){
    stop();
  }else{
    ++ limit;
  }
}