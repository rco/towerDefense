package td.projectiles
{
	import flash.display.Graphics;
	import td.Creep;

	/**
	 * FireBullet class.
	 * 
	 * @author Garth Henson - Guahan Web (garth@guahanweb.com)
	 */
	public class FireBullet extends Bullet
	{
		/**
		 * Constructor method
		 * 
		 * @constructor
		 * @access public
		 * @param {Object} t the target object
		 * @return FireBullet
		 */
		public function FireBullet(t:Creep)
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
			g.lineStyle(1, 0x770000);
			g.beginFill(0xffaaaa);
			g.drawCircle(0, 0, 4);
			g.endFill();
		}
	}
}