/// [GameMode] defines the mechanism of repeating the tasks.
enum GameMode {
  /// Each player have own but the same as others set of tasks which cannot be repeated.
  /// When one of the players did all tasks from his sets then game is over.
  tasksPerPlayer,
  /// Each new wheel spin pick the new task which will not appear again in this game.
  /// Game is finished when tasks are over.
  tasksPerGame,
}
