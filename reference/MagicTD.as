package {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import td.*;
	import td.projectiles.*;
	import td.towers.*;
	import td.utils.*;

	[SWF(width="560", height="320", frameRate="30", backgroundColor="#ffffff")]
	/**
	 * The actual TD class that runs the entire logic of the game
	 * 
	 * @author Garth Henson - Guahan Web (garth@guahanweb.com)
	 */
	public class MagicTD extends Sprite
	{
		// Timers
		protected var creep_timer :Timer;
		protected var cleanup_timer :Timer;
		
		// Sprites
		protected var backgroundMC :Sprite = new Sprite();
		protected var bulletMC :Sprite     = new Sprite();
		protected var creepMC :Sprite      = new Sprite();
		protected var towerMC :Sprite      = new Sprite();
		
		// Objects
		protected var bullets :Array = new Array();
		protected var creeps :Array  = new Array();
		protected var towers :Array  = new Array();
		protected var map :Map;
		
		// Other variables
		protected var starting_point :Array;
		protected var ending_point :Array;
		protected var points :Array;
		protected var full_width :int  = 560;
		protected var full_height :int = 320;
		public var grid_size :int;
		
		/**
		 * Constructor method for our application
		 * 
		 * @constructor
		 * @access public
		 * @return void
		 */
		public function MagicTD()
		{
			// for testing
			this.points = [[2, -1], [2, 5], [6, 5], [6, 16], [28, 16], [28, 4], [12, 4], [12, 19], [22, 19], [22, 12], [36, 12]];
			this.grid_size = 16;

			// this.setupTarget();
			this.drawBackground();
			this.setupMap();
			this.setupTimers();
			this.setupListeners();
			
			this.addChild(this.creepMC);
			this.addChild(this.bulletMC);
			this.addChild(this.towerMC);
			
			this.test();
		}
		
		/**
		 * Used for testing purposes - sets up a test environment for our app
		 * 
		 * @access protected
		 * @return void
		 */
		protected function test() :void
		{
			// Set up buttons for towers
			var a :Sprite = new Sprite();
			a.graphics.lineStyle(1, 0x444444);
			a.graphics.beginFill(0xcccccc);
			a.graphics.drawCircle(0, 0, 6);
			a.graphics.endFill();
			a.x = 500;
			a.y = 15;
			a.buttonMode = true;
			a.addEventListener(MouseEvent.CLICK, testNormal);
			this.addChild(a);
			
			var b :Sprite = new Sprite();
			b.graphics.lineStyle(1, 0x770000);
			b.graphics.beginFill(0xffaaaa);
			b.graphics.drawCircle(0, 0, 6);
			b.graphics.endFill();
			b.x = 520;
			b.y = 15;
			b.buttonMode = true;
			b.addEventListener(MouseEvent.CLICK, testFire);
			this.addChild(b);
			
			var c :Sprite = new Sprite();
			c.graphics.lineStyle(1, 0x000077);
			c.graphics.beginFill(0xaaaaff);
			c.graphics.drawCircle(0, 0, 6);
			c.graphics.endFill();
			c.x = 540;
			c.y = 15;
			c.buttonMode = true;
			c.addEventListener(MouseEvent.CLICK, testIce);
			this.addChild(c);
		}
		
		protected function testNormal(e :MouseEvent) :void
		{
			var t :Tower = new Tower(this);
			t.x = this.parent.mouseX;
			t.y = this.parent.mouseY;
			this.towers.push(t);
			this.towerMC.addChild(t);
		}
		
		protected function testFire(e :MouseEvent) :void
		{
			var t3 :Tower = new FireTower(this);
			t3.x = this.parent.mouseX;
			t3.y = this.parent.mouseY;
			this.towers.push(t3);
			this.towerMC.addChild(t3);
		}
		
		protected function testIce(e :MouseEvent) :void
		{
			var t2 :Tower = new IceTower(this);
			t2.x = this.parent.mouseX;
			t2.y = this.parent.mouseY;
			this.towers.push(t2);
			this.towerMC.addChild(t2);
		}
		
		/**
		 * Draw the background graphics for this game
		 * 
		 * @return void
		 */
		protected function drawBackground() :void
		{
			var g :Graphics = this.backgroundMC.graphics;
			g.beginFill(0xe4e4e4);
			g.drawRect(0, 0, this.full_width, this.full_height);
			g.endFill();
			
			// Draw vertical hash marks
			g.lineStyle(1, 0xaaaaaa);
			for (var i :int = 0; i < Math.round(this.full_width / this.grid_size); i++)
			{
				g.moveTo(i * this.grid_size, 0);
				g.lineTo(i * this.grid_size, this.full_height);
			}
			
			// Draw horizontal hash marks
			for (i = 0; i < Math.round(this.full_height / this.grid_size); i++)
			{
				g.moveTo(0, i * this.grid_size);
				g.lineTo(this.full_width, i * this.grid_size);
			}
			
			this.addChild(this.backgroundMC);
		}
		
		/**
		 * Set up the map with the points assigned to this member variable
		 * 
		 * @return void
		 */
		protected function setupMap() :void
		{
			this.map = new Map(this.points, this.grid_size, this);
			this.map.drawRoad();
			this.addChild(this.map);
		}
		
		/**
		 * Set up any timers we need and start them
		 * 
		 * @access protected
		 * @return void
		 */
		protected function setupTimers() :void
		{
			this.creep_timer = new Timer(1000);
			this.creep_timer.start();
			
			this.cleanup_timer = new Timer(15000);
			this.cleanup_timer.start();
		}
		
		/**
		 * Set up any listeners we need for this application
		 * 
		 * @access protected
		 * @return void
		 */
		protected function setupListeners() :void
		{
			this.creep_timer.addEventListener(TimerEvent.TIMER, createCreep);
			this.cleanup_timer.addEventListener(TimerEvent.TIMER, cleanup);
			this.addEventListener(MouseEvent.CLICK, handleGlobalClick, true);
		}
		
		/**
		 * Creates a new creep with every timer tic
		 * 
		 * @access protected
		 * @param {TimerEvent} e The creep timer
		 * @return void
		 */
		protected function createCreep(e :TimerEvent) :void
		{
			var c :Creep = new Creep(this.points, this);
			this.creeps.push(c);
			this.creepMC.addChild(c);
		}
		
		/**
		 * Handles the user's clicking on anything not handled within an object
		 * 
		 * @access protected
		 * @param {MouseEvent} e the click event
		 * @return void
		 */
		protected function handleGlobalClick(e :MouseEvent) :void
		{
			clearSelections();
		}
		
		/**
		 * Fires a bullet from the provided tower towards the next creep in range
		 * 
		 * @access public
		 * @param {Tower} the tower from which to fire
		 * @return void
		 */
		public function fire(t :Tower) :void
		{
			try {
				var c :Creep  = this.obtainTarget(t.x, t.y, t.getRange());
				var b :Bullet = t.getNewBullet(c);
			
				this.bullets.push(b);
				this.bulletMC.addChild(b);
			}
			catch (e :Error)
			{
				// Do nothing, since we have no targets in range
			}
		}
		
		/**
		 * Time for resource cleanup
		 * 
		 * @access protected
		 * @param {TimerEvent} e The timer event calling this method
		 * @return void
		 */
		protected function cleanup(e :TimerEvent) :void
		{
			var i :int = 0;
			
			// First, let's clean up the dead bullets
			for (i = 0; i < this.bullets.length; i++)
			{
				var b :Bullet = this.bullets[i];
				if (b.isDestroyed())
				{
					this.bulletMC.removeChild(b);
					this.bullets.splice(i, 1);
				}
			}
			
			// Now, let's clean up dead creeps
			for (i = 0; i < this.creeps.length; i++)
			{
				var c :Creep = this.creeps[i];
				if (c.isDestroyed())
				{
					this.creepMC.removeChild(c);
					this.creeps.splice(i, 1);
				}
			}
		}
		
		/**
		 * Finds and returns the first creep that is within the given radius from the position provided
		 * 
		 * @access public
		 * @param {int} posX the X coordinate
		 * @param {int} posY the Y coordinate
		 * @param {int} radius the range to scan
		 * @return Creep
		 */
		public function obtainTarget(posX :int, posY :int, radius :int) :Creep
		{
			targetLoop: for (var i :int = 0; i < this.creeps.length; i++)
			{
				// Calculate distance to creep
				var diffX :int = Math.abs(posX - this.creeps[i].x);
				var diffY :int = Math.abs(posY - this.creeps[i].y);
				var dist :int = Math.round(Math.sqrt((diffX * diffX) + (diffY * diffY)));
				
				if (dist <= radius && !this.creeps[i].isDestroyed())
				{
					// return this creep
					return this.creeps[i];
				}
			}
			throw new Error('No targets available');
		}
		
		/**
		 * Since this is the global click handler, we want to deselect anything that was previously selected
		 * 
		 * @access public
		 * @return void
		 */
		public function clearSelections() :void
		{
			// Deselect towers
			for (var i :int = 0; i < this.towers.length; i++)
			{
				towers[i].deselect();
			}
			
			// Deselect creeps
			for (i = 0; i < this.creeps.length; i++)
			{
				creeps[i].deselect();
			}
		}
		
		/**
		 * Calculates the pixels to the given point on the grid
		 * 
		 * @access public
		 * @param {Number} x the point to calculate
		 * @param {Boolean} b whether or not to center the point
		 * @return Number
		 */
		public function getPointToPixels(x :Number, b :Boolean) :Number
		{
			var r :int = x * this.grid_size;
			if (b == true)
			{
				return r - (this.grid_size / 2);
			}
			
			return r;
		}
	}
}
