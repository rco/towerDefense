package com.rodcez.towerdefense.model {
	import flash.display.Sprite;
	
	
	public class CreepPathModel {
		
		public var gridSize : int = 20;
		
		public function getPointToPixels(pointArray:Number, centerPoint:Boolean) : int {
			
			var r :int = pointArray * gridSize
			if (centerPoint == true) 
				return r - (gridSize / 2);
			
			return r;
		}
	}
}