package en;

class Mob extends Entity {
  public var pot:Pot;

  public static inline var SPD:Float = 0.05;

  public function new(x:Int, y:Int) {
    super(x, y);
    lockTarget();
    setupSprite();
  }

  public function lockTarget() {
    if (Game.ME.level != null && Game.ME.level.pot != null) {
      pot = Game.ME.level.pot;
    }
  }

  public function setupSprite() {
    var g = new h2d.Graphics(spr);
    g.beginFill(0xff0000);
    g.drawRect(0, 0, 8, 8);
    g.endFill();
  }

  override function fixedUpdate() {
    super.fixedUpdate();
    routeToTarget();
  }

  public function routeToTarget() {
    if (pot != null) {
      var dirVec = new Vec2(pot.cx - cx, pot.cy - cy);
      var norm = dirVec.normalize();
      dx = norm.x * SPD;
      dy = norm.y * SPD;
    }
  }
}