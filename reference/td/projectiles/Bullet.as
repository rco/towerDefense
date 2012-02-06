package td.projectiles
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import td.*;

	/**
	 * The base Bullet class. This class will be used as the parent to any specific
	 * bullet types we need for this game.
	 * 
	 * @author Garth Henson - Guahan Web (garth@guahanweb.com)
	 */
	public class Bullet extends Sprite
	{
		protected var target :Object;
		protected var is_destroyed :Boolean = false;
		
		// Visual settings
		protected var speed :int  = 8;
		protected var radius :int = 2;
		protected var color :uint = 0x999999;
		protected var line_color :uint     = 0x333333;
		protected var transparency :Number = 0.6;
		
		// Technical specs
		protected var element :String;
		protected var power :int;
		
		/**
		 * Constructor method
		 * 
		 * @constructor
		 * @access public
		 * @param {Object} t the target object
		 * @return Bullet
		 */
		public function Bullet(t :Creep)
		{
			this.target = t;
			
			this.draw();
			this.addEventListener(Event.ENTER_FRAME, trackTarget);			
			super();
		}
		
		/**
		 * Draws the visuals for our bullet
		 * 
		 * @return void
		 */
		protected function draw() :void
		{
			var g :Graphics = this.graphics;
			g.lineStyle(1, this.line_color);
			g.beginFill(this.color, this.transparency);
			g.drawCircle(0, 0, this.radius);
		}
		
		/**
		 * ENTER_FRAME handler that checks to see if we have hit our target and updates our position
		 * or destroys our bullet accordingly.
		 * 
		 * @param {Event} e Event.ENTER_FRAME
		 * @return void
		 */
		protected function trackTarget(e:Event) :void
		{
			var diffX :Number = this.target.x - this.x;
			var diffY :Number = this.target.y - this.y;
			var dist :Number  = Math.abs(Math.sqrt((diffX * diffX) + (diffY * diffY)));
			var ratio :Number = speed / dist;
			
			if (dist <= speed)
			{
				// We hit them!
				this.target.hit(this);
				
				this.alpha = 0;
				this.is_destroyed = true;
				removeEventListener(Event.ENTER_FRAME, trackTarget);
			}
			else
			{
				x += Math.round(diffX * ratio);
				y += Math.round(diffY * ratio);
			}
		}
		
		/**
		 * Accessor method - sets the strength of this shot
		 * 
		 * @public
		 * @param {int} i the power of the shot
		 * @return void
		 */
		public function setPower(i :int) :void
		{
			this.power = i;
		}
		
		/**
		 * Accessor method - retrieves the strength of this shot
		 * 
		 * @public
		 * @return int
		 */
		public function getPower() :int
		{
			return this.power;
		}
		
		/**
		 * Accessor method - sets the element of this shot
		 * 
		 * @public
		 * @param {int} i the element of the shot
		 * @return void
		 */
		public function setElement(s :String) :void
		{
			this.element = s;
		}
		
		/**
		 * Accessor method - retrieves the element of this shot
		 * 
		 * @public
		 * @return String
		 */
		public function getElement() :String
		{
			return this.element;
		}
		
		/**
		 * Returns whether or not the current bullet has been destroyed
		 * 
		 * @return Boolean
		 */
		public function isDestroyed() :Boolean
		{
			return is_destroyed;
		}
	}
}