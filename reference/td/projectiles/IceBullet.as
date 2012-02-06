package td.projectiles
{
	import flash.display.Graphics;
	import td.Creep;

	/**
	 * IceBullet class.
	 * 
	 * @author Garth Henson - Guahan Web (garth@guahanweb.com)
	 */
	public class IceBullet extends Bullet
	{
		/**
		 * Constructor method
		 * 
		 * @constructor
		 * @access public
		 * @param {Object} t the target object
		 * @return IceBullet
		 */
		public function IceBullet(t:Creep)
		{
			super(t);
		}
		
		/**
		 * Draws the visuals for our bullet
		 * 
		 * @return void
		 */
		protected override function draw() :void
		{
			var g :Graphics = this.graphics;
			g.lineStyle(1, 0x000077);
			g.beginFill(0xaaaaff);
			g.drawCircle(0, 0, 4);
			g.endFill();
		}
	}
}