package td.towers
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	
	import td.projectiles.*;
	import td.*;

	/**
	 * IceTower class
	 * 
	 * @author Garth Henson - Guahan Web (garth@guahanweb.com)
	 */
	public class IceTower extends Tower
	{
		/**
		 * Constructor method
		 * 
		 * @constructor
		 * @access public
		 * @param {MagicTD} mtd A reference to the current TD game
		 * @return Tower
		 */
		public function IceTower(mtd :MagicTD)
		{
			this.type  = 'ice';
			this.power = 8;
			this.rate  = 1;
			this.range = 60;
			
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
			g.lineStyle(1, 0x000077);
			g.beginFill(0xaaaaff);
			g.drawCircle(0, 0, 4);
			g.endFill();
			
			this.addChild(this.towerMC);
		}

		/**
		 * Creates a new bullet to be fired from this tower
		 * 
		 * @access public
		 * @param {Creep} t The target creep
		 * @return IceBullet
		 */
		public override function getNewBullet(t:Creep):Bullet
		{
			var b :IceBullet = new IceBullet(t);
			b.x = this.x;
			b.y = this.y;
			b.setPower(this.power);
			return b;
		}
	}
}