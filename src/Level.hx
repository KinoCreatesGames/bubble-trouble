import en.Mob;
import en.Spawn;
import en.Pot;

class Level extends dn.Process {
  var game(get, never):Game;

  inline function get_game()
    return Game.ME;

  var fx(get, never):Fx;

  inline function get_fx()
    return Game.ME.fx;

  /** Level grid-based width**/
  public var cWid(get, never):Int;

  inline function get_cWid()
    return 16;

  /** Level grid-based height **/
  public var cHei(get, never):Int;

  inline function get_cHei()
    return 16;

  /** Level pixel width**/
  public var pxWid(get, never):Int;

  inline function get_pxWid()
    return cWid * Const.GRID;

  /** Level pixel height**/
  public var pxHei(get, never):Int;

  inline function get_pxHei()
    return cHei * Const.GRID;

  var invalidated = true;

  public var pot:Pot;
  public var spawns:Array<Spawn>;
  public var enemyGrp:Array<Mob>;

  public function new() {
    super(Game.ME);
    createRootInLayers(Game.ME.scroller, Const.DP_BG);
    createGroups();
    createEntities();
    createObstacles();
  }

  public function createGroups() {
    spawns = [];
    enemyGrp = [];
  }

  public function createEntities() {
    pot = new Pot(8, 8);
    var space = 7;
    // Create Spawn L <--> R
    spawns.push(new Spawn(pot.cx - space, pot.cy));
    spawns.push(new Spawn(pot.cx + space, pot.cy));
  }

  public function createObstacles() {}

  /** TRUE if given coords are in level bounds **/
  public inline function isValid(cx, cy)
    return cx >= 0 && cx < cWid && cy >= 0 && cy < cHei;

  /** Gets the integer ID of a given level grid coord **/
  public inline function coordId(cx, cy)
    return cx + cy * cWid;

  /** Ask for a level render that will only happen at the end of the current frame. **/
  public inline function invalidate() {
    invalidated = true;
  }

  public function hasEnemyCollision(x:Int, y:Int) {
    return enemyGrp.exists((enemy) -> enemy.cx == x && enemy.cy == y
      && enemy.isAlive());
  }

  public function collidedEnemy(x:Int, y:Int) {
    return enemyGrp.filter((enemy) -> enemy.cx == x && enemy.cy == y
      && enemy.isAlive())
      .first();
  }

  function render() {
    // Placeholder level render
    root.removeChildren();
    for (cx in 0...cWid)
      for (cy in 0...cHei) {
        var g = new h2d.Graphics(root);
        if (cx == 0
          || cy == 0
          || cx == cWid - 1
          || cy == cHei - 1) g.beginFill(0xffcc00); else
          g.beginFill(Color.randomColor(rnd(0, 1), 0.5, 0.4));
        g.drawRect(cx * Const.GRID, cy * Const.GRID, Const.GRID, Const.GRID);
      }
  }

  override function postUpdate() {
    super.postUpdate();

    if (invalidated) {
      invalidated = false;
      render();
    }
  }
}