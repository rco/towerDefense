package td.utils
{
	import flash.display.Graphics;
	import flash.display.Sprite;

	public class Map extends Sprite
	{
		protected var game :MagicTD;
		protected var starting_point :Array;
		protected var ending_point :Array;
		
		public var points :Array;
		public var road_width :int;
		
		public function Map(pts :Array, width :int, mtd :MagicTD)
		{
			super();
			this.game = mtd;
			this.points = pts;
			this.road_width = width;
		}
		
		public function setPoints(pts :Array) :void
		{
			this.points = pts;
		}
		
		public function drawRoad() :void
		{
			// Set up the starting point
			this.starting_point = this.points[0];
			this.ending_point = this.points[this.points.length - 1];
			
			var g :Graphics = this.graphics;
			this.drawRoadPath(this.points, this.road_width, g);
		}
		
		protected function drawRoadPath(points :Array, width :int, g :Graphics) :void
		{
			for (var i :int = 1; i < points.length; i++)
			{
				var p_point :Array = points[i - 1];
				var c_point :Array = points[i];
				
				var pX :int, pY :int, cX :int, cY :int, rHeight :int, rWidth :int;
				
				if (p_point[0] <= c_point[0] && p_point[1] <= c_point[1])
				{
					pX = this.game.getPointToPixels(p_point[0], false);
					pY = this.game.getPointToPixels(p_point[1], false);
					cX = this.game.getPointToPixels(c_point[0], false);
					cY = this.game.getPointToPixels(c_point[1], false);

					rHeight = Math.abs(pX - cX);
					rWidth  = Math.abs(pY - cY);
				
					if (pX == cX)
					{
						pX -= width;
						rHeight = width;
					}
					else if (pY == cY)
					{
						pY -= width;
						rWidth = width;
					}
				}
				else
				{
					pX = this.game.getPointToPixels(c_point[0], false) - width;
					pY = this.game.getPointToPixels(c_point[1], false) - width;
					cX = this.game.getPointToPixels(p_point[0], false) - width;
					cY = this.game.getPointToPixels(p_point[1], false) - width;

					rHeight = Math.abs(pX - cX);
					rWidth  = Math.abs(pY - cY);
				
					if (pX == cX)
					{
						rHeight = width;
					}
					else if (pY == cY)
					{
						rWidth = width;
					}
				}
				
				// Draw segment
				g.beginFill(0x000000, 0.5);
				g.drawRect(pX, pY, rHeight, rWidth);
				g.endFill();
			}
		}
	}
}