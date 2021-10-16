package en;

import dn.heaps.filter.PixelOutline;

class Pot extends Entity {
  public function new(x:Int, y:Int) {
    super(x, y);
    // spr.filter = new PixelOutline(0xffffff, 1);
    setupSprite();
  }

  public function setupSprite() {
    var g = new h2d.Graphics(spr);
    g.beginFill(0xff00ff, 1);
    g.drawRect(0, 0, 8, 8);
    g.endFill();
  }

  override function update() {
    super.update();
    if (Game.ME.level != null) {
      enemyCollisions();
    }
  }

  public function enemyCollisions() {
    if (level.hasEnemyCollision(cx, cy)) {
      var enemy = level.collidedEnemy(cx, cy);
      enemy.destroy();
      setSquashX(0.6);
    }
  }
}