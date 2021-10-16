package en;

class Spawn extends Entity {
  public function new(x:Int, y:Int) {
    super(x, y);
    setupSprite();
  }

  public function setupSprite() {
    var g = new h2d.Graphics(spr);
    g.beginFill(0xffa0a0);
    g.drawRect(0, 0, 8, 8);
    g.endFill();
  }

  override function update() {
    super.update();
    if (!cd.has('canSpawnAdd')) {
      spawnMob();
    }
  }

  public function spawnMob() {
    cd.setS('canSpawnAdd', Const.SPAWN_CD);
    // Add to level
    if (Game.ME.level.enemyGrp != null) {
      Game.ME.level.enemyGrp.push(new Mob(cx, cy));
    }
  }
}