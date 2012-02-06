package com.rodcez.towerdefense.model {
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	
	public class GridBackgroundModel {
		
		// Config variables (all public static)
		/*public static var base_width:Number  = 600;
		public static var base_height:Number = 400;*/
		public static var map_width:Number   = 480;
		public static var map_height:Number  = 300;
		public static var gui_width:Number   = 120;
		
		public static var bg_color:uint      = 0x335072;
		public static var grid_color:uint    = 0x5a7fa8;
		public static var grid_size:Number   = 20;
		
		// Display regions
		private var guiMC:Sprite = new Sprite();
		
		// Member variables of the game
		/*private var ctrl:GuiControls;*/
		
		public function drawBackground(base_width : Number, base_height : Number) : Sprite
		{
			var spr : Sprite = new Sprite ();
			
			// Draw the background color
			spr.graphics.beginFill(bg_color);
			spr.graphics.drawRect(0, 0, base_width, base_height);
			spr.graphics.endFill();
			
			// Draw gridlines
			spr.graphics.lineStyle(1, grid_color);
			for (var i : Number= 0; i < base_width; i += grid_size)
			{
				spr.graphics.moveTo(i, 0);
				spr.graphics.lineTo(i, base_height);
			}
			
			for (var j : Number= 0; j < base_height; j += grid_size)
			{
				spr.graphics.moveTo(0, j);
				spr.graphics.lineTo(base_width, j);
			}
			
			return spr;
		}
		
		public function drawControls() : void
		{
			/*guiMC.x = base_width - gui_width;
			ctrl = new GuiControls(gui_width, base_height);
			guiMC.addChild(ctrl);*/
		}
	}
}