package td.towers
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import td.*;
	import td.projectiles.*;

	/**
	 * The tower class that should be extended for every type of tower
	 * 
	 * @author Garth Henson - Guahan Web (garth@guahanweb.com)
	 */
	public class Tower extends Sprite
	{
		protected var game :MagicTD;
		protected var timer :Timer;
		
		protected var type :String;
		protected var power :int;
		protected var range :int;
		protected var rate :int; // shots per second
		protected var level :int;
		protected var is_set :Boolean = false;
		
		protected var rangeMC :Sprite;
		protected var towerMC :Sprite;
		
		/**
		 * Constructor method
		 * 
		 * @constructor
		 * @access public
		 * @param {MagicTD} mtd A reference to the current TD game
		 * @return Tower
		 */
		public function Tower(mtd :MagicTD)
		{
			// Set up the defaults
			if (this.type == null) this.type = 'normal';
			if (this.power == 0) this.power = 4;			
			if (this.range == 0) this.range = 80;
			if (this.rate == 0) this.rate = 2;
			if (this.level == 0) this.level = 1;
			
			this.game = mtd;
			
			this.drawRange();
			this.drawTower();
			
			this.towerMC.buttonMode = true;
			this.towerMC.addEventListener(MouseEvent.CLICK, select);
			this.game.addEventListener(MouseEvent.MOUSE_MOVE, trackMouse);
			
			super();
		}
		
		/**
		 * Generates the display for this tower
		 * 
		 * @access protected
		 * @return void
		 */
		protected function drawTower() :void
		{
			this.towerMC = new Sprite();
			var g :Graphics = this.towerMC.graphics;
			g.lineStyle(1, 0x454545);
			g.beginFill(0xaaaaaa);
			g.drawRect(-6, -6, 12, 12);
			g.endFill();
			
			this.addChild(this.towerMC);
		}
		
		/**
		 * "Selects" this tower visually
		 * 
		 * @param {MouseEvent} e the CLICK event
		 * @return void
		 */
		protected function select(e :MouseEvent) :void
		{
			if (this.is_set == false)
			{
				this.is_set = true;
				this.game.removeEventListener(MouseEvent.MOUSE_MOVE, trackMouse);
				this.setupTimer();
			}
			
			this.rangeMC.visible = true;
		}
		
		/**
		 * "Deselects" this tower visually
		 * 
		 * @return void
		 */
		public function deselect() :void
		{
			this.rangeMC.visible = false;
		}
		
		protected function trackMouse(e :MouseEvent) :void
		{
			var x :int = Math.ceil(this.parent.mouseX / this.game.grid_size);
			var y :int = Math.ceil(this.parent.mouseY / this.game.grid_size);
			
			this.x = this.game.getPointToPixels(x, true);
			this.y = this.game.getPointToPixels(y, true);
		}
		
		/**
		 * Draws the range circle
		 * 
		 * @return void
		 */
		protected function drawRange() :void
		{
			this.rangeMC = new Sprite();
			var g :Graphics = this.rangeMC.graphics;
			g.lineStyle(1, 0x333333, 0.4);
			g.beginFill(0xaa0000, 0.1);
			g.drawCircle(0, 0, this.range);
			g.endFill();

			this.addChild(this.rangeMC);
		}
		
		/**
		 * Sets the shot timer for this tower
		 * 
		 * @access protected
		 * @return void
		 */
		protected function setupTimer() :void
		{
			var milli :int = Math.round((1 / this.rate) * 1000);
			this.timer = new Timer(milli);
			this.timer.addEventListener(TimerEvent.TIMER, fire);
			this.timer.start();
		}
		
		/**
		 * Triggers the MagicTD.fire() method with this tower as the target object
		 * 
		 * @access protected
		 * @param {TimerEvent} e The fire timer event
		 * @return void
		 */
		protected function fire(e :TimerEvent) :void
		{
			this.game.fire(this);
		}
		
		/**
		 * Creates a new bullet to be fired from this tower
		 * 
		 * @access public
		 * @param {Creep} t The target creep
		 * @return Bullet
		 */
		public function getNewBullet(t :Creep) :Bullet
		{
			var b :Bullet = new Bullet(t);
			b.x = this.x;
			b.y = this.y;
			b.setPower(this.power);
			return b;
		}
		
		/**
		 * Accessor method to retrieve the range of this tower
		 * 
		 * @access public
		 * @return int
		 */
		public function getRange() :int
		{
			return this.range;
		}
	}
}