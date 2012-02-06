package td
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import td.projectiles.*;

	/**
	 * Base Creep class. This class should be extended to make the different types of creeps
	 * for each wave. Individual attributes should be set via accessor methods when the creep
	 * is created.
	 * 
	 * @author Garth Henson - Guahan Web (garth@guahanweb.com)
	 */
	public class Creep extends Sprite
	{
		protected var game :MagicTD;
		protected var points :Array = new Array();
		protected var next_point :int = 1;
		protected var dx :Number;
		protected var dy :Number;
		
		protected var speed :int;
		protected var color :uint;
		protected var diameter :int;
		
		protected var is_destroyed :Boolean = false;
		protected var max_hp :int = 100;
		protected var hp :int = 100;
		protected var level :int = 1;
		
		protected var health_meter :Sprite = new Sprite();
		protected var health_bar :Sprite = new Sprite();
		
		/**
		 * Constructor method
		 * 
		 * @constructor
		 * @access public
		 * @param {int} posX the X coordinate
		 * @param {int} posY the Y coordinate
		 * @return Creep
		 */
		public function Creep(pts :Array, mtd :MagicTD)
		{
			this.points = pts;
			this.game = mtd;
			
			// Hard code for now
			this.speed = 2;
			this.color = 0xcccccc;
			this.diameter = 12; 
			
			this.draw();
			
			// Set up initial location to the first point
			resetPosition();
			
			this.buttonMode = true;
			this.addEventListener(Event.ENTER_FRAME, move);
			this.addEventListener(MouseEvent.CLICK, select);
			super();
		}
		
		/**
		 * Draws the actual visuals for this object
		 * 
		 * @access protected
		 * @return void
		 */
		protected function draw() :void
		{
			var g :Graphics = this.graphics;
			g.lineStyle(1, 0x999999, 0.8);
			g.beginFill(this.color);
			g.drawCircle(0, 0, Math.round(this.diameter / 2));
			g.endFill();
			
			// Draw the health meter
			this.health_meter.x = -(this.diameter / 2);
			this.health_meter.y = -(this.diameter / 2);
			g = this.health_meter.graphics;
			g.beginFill(0xff0000, 0.6);
			g.drawRect(0, 0, this.diameter, 2);
			g.endFill();
			
			this.health_bar.x = -(this.diameter / 2);
			this.health_bar.y = -(this.diameter / 2);
			g = this.health_bar.graphics;
			g.beginFill(0x00cc00, 0.8);
			g.drawRect(0, 0, this.diameter, 2);
			g.endFill();
			
			this.addChild(this.health_meter);
			this.addChild(this.health_bar);
			
			// Start by hiding
			this.health_meter.visible = false;
			this.health_bar.visible = false;
		}
		
		/**
		 * Moves the creep each frame based on its speed
		 * 
		 * @access protected
		 * @param {Event} e Event.ENTER_FRAME
		 * @return void
		 */
		protected function move(e :Event) :void
		{
			var xdiff :Number = Math.abs(x - dx);
			var ydiff :Number = Math.abs(y - dy);
			var dist :Number  = Math.sqrt(xdiff * xdiff + ydiff * ydiff);
			var vx :Number    = xdiff * ((dx < x ? speed * -1 : speed) / dist);
			var vy :Number    = ydiff * ((dy < y ? speed * -1 : speed) / dist);
			
			this.x += vx;
			this.y += vy;
			
			if (x > (this.dx - (this.speed / 2)) &&
				x < (this.dx + (this.speed / 2)) &&
				y > (this.dy - (this.speed / 2)) &&
				y < (this.dy + (this.speed / 2)))
			{
				this.x = this.dx;
				this.y = this.dy;
				this.loadPoint(this.next_point);
			}
		}
		
		/**
		 * Loads point "n" of the points array as the destination point. If the point is
		 * beyond the range of the points array, the creep has finished the course.
		 * 
		 * @access protected
		 * @param {Number} n
		 * @return void
		 */
		protected function loadPoint(n :Number) :void
		{
			if (n < this.points.length - 1)
			{
				this.next_point = n + 1;
				var p :Array = points[next_point];
				this.dx = this.game.getPointToPixels(p[0], true);
				this.dy = this.game.getPointToPixels(p[1], true);
			}
			else
			{
				// Finished the track
				this.visible = false;
				this.is_destroyed = true;
				this.removeEventListener(Event.ENTER_FRAME, move);
			}
		}
		
		/**
		 * Reset position to the first map point
		 *
		 * @return void
		 */
		protected function resetPosition() :void
		{
			this.next_point = 1;
			this.setGridLocation(this.points[0]);
			this.loadPoint(0);
		}

		/**
		 * Set location to a specific grid coordinate
		 *
		 * @param Array coords an array of [x, y] coordinates
		 * @return void
		 */
		protected function setGridLocation(coords :Array) :void
		{
			this.x = this.game.getPointToPixels(coords[0], true);
			this.y = this.game.getPointToPixels(coords[1], true);
		}

		/**
		 * Visually selects this creep
		 * 
		 * @access protected
		 * @param {MouseEvent} e the click event
		 * @return void
		 */
		protected function select(e :MouseEvent) :void
		{
			this.health_meter.visible = true;
			this.health_bar.visible = true;
		}
		
		/**
		 * Visually deselects this creep
		 * 
		 * @access protected
		 * @return void
		 */
		public function deselect() :void
		{
			this.health_meter.visible = false;
			this.health_bar.visible = false;
		}
		
		/**
		 * Returns whether or not this object has been destroyed
		 * 
		 * @access public
		 * @return Boolean
		 */
		public function isDestroyed() :Boolean
		{
			return this.is_destroyed;
		}
		
		/**
		 * Processes a hit by the provided bullet object
		 *
		 * @access public 
		 * @param {Bullet} b the bullet object
		 * @return void
		 */
		public function hit(b :Bullet) :void
		{
			var pow :int = 5 * b.getPower();
			this.hp -= pow;
			this.health_bar.width = Math.round((this.hp / this.max_hp) * this.diameter);
			
			if (this.hp <= 0)
			{
				// Creep has been killed
				this.visible = false;
				this.is_destroyed = true;
				this.removeEventListener(Event.ENTER_FRAME, move);
			}
		}
		
		/**
		 * Accessor method - sets the max_hp and hp values for this creep
		 * 
		 * @access public
		 * @param {int} i the hp count
		 * @return void
		 */
		public function setHP(i :int) :void
		{
			this.max_hp = i;
			this.hp = this.max_hp;
		}
		
		/**
		 * Accessor method - sets the level for this creep
		 * 
		 * @access public
		 * @param {int} l the level
		 * @return void
		 */
		public function setLevel(l :int) :void
		{
			this.level = l;
		}
	}
}