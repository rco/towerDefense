package td.towers
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	import td.Creep;
	import td.projectiles.*;
	
	/**
	 * FireTower class
	 * 
	 * @author Garth Henson - Guahan Web (garth@guahanweb.com)
	 */
	public class FireTower extends Tower
	{
		/**
		 * Constructor method
		 * 
		 * @constructor
		 * @access public
		 * @param {MagicTD} mtd A reference to the current TD game
		 * @return Tower
		 */
		public function FireTower(mtd :MagicTD)
		{
			this.type  = 'fire';
			this.power = 3;
			this.rate  = 4;
			this.range = 120;
			
			super(mtd);
		}
		
		/**
		 * Generates the display for this tower
		 * 
		 * @access protected
		 * @return void
		 */
		protected override function drawTower() :void
		{
			this.towerMC = new Sprite();
			var g :Graphics = this.towerMC.graphics;
			
			// Draw the box
			g.lineStyle(1, 0x454545);
			g.beginFill(0xaaaaaa);
			g.drawRect(-6, -6, 12, 12);
			g.endFill();

			// Draw the element
			g.lineStyle(1, 0x770000);
			g.beginFill(0xffaaaa);
			g.drawCircle(0, 0, 4);
			g.endFill();
			
			this.addChild(this.towerMC);
		}
		
		/**
		 * Creates a new bullet to be fired from this tower
		 * 
		 * @access public
		 * @param {Creep} t The target creep
		 * @return FireBullet
		 */
		public override function getNewBullet(t:Creep):Bullet
		{
			var b :FireBullet = new FireBullet(t);
			b.x = this.x;
			b.y = this.y;
			b.setPower(this.power);
			return b;
		}
	}
}