package com.rodcez.towerdefense.view.mediators {
	import com.rodcez.towerdefense.model.CreepPathModel;
	import com.rodcez.towerdefense.signals.CreepPathUpdate;
	import com.rodcez.towerdefense.view.components.CreepPathView;
	
	import flash.display.Sprite;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.core.SpriteVisualElement;
	
	
	public class CreepPathMediator extends Mediator {
		
		[Inject]
		public var view : CreepPathView;
		
		[Inject]
		public var model : CreepPathModel;
		
		[Inject]
		public var creepPathUpdate : CreepPathUpdate;
		
		override public function onRegister():void {
			creepPathUpdate.add(creepPathUpdatehandler);
		}
		
		override public function preRemove():void {
			creepPathUpdate.remove(creepPathUpdatehandler);
			
		}
		
		private function creepPathUpdatehandler() : void {
			var points : Array = [[1, 1], [1, 5]]
			createCreepPath(view.creepPath.width, view.creepPath.height, points)
			
		}
		
		private function createCreepPath(w:Number, h:Number, points:Array) : void {
			for (var i :int = 0; i < points.length; i++) {
				//[1,1],[1,5]
				var startPoint : Array = points[i];
				var endPoint : Array = points[i + 1];
				
				for (var j:int = 0; j < points[i].length; j++) {
					//1,1
					var rectX : Number = startPoint[j];
					var rectY : Number = startPoint[j];
				
					var spr : Sprite = new Sprite();
					spr.graphics.beginFill(0x000000, 0.5);
					spr.graphics.drawRect(0, 0, 20, 20); //-778,20,798,80
					spr.graphics.endFill();
					
					var sprCont:SpriteVisualElement = new SpriteVisualElement();
					
					sprCont.addChild(spr);
					view.creepPath.addElement(sprCont);
				}
				
				
				
				
				/*var startPoint : Array = points[i];
				var endPoint : Array = points[i + 1];
				
				var rectX1 : Number = positionOnGrid(startPoint[0]); //20
				var rectY1 : Number = positionOnGrid(startPoint[1]); //20
				
				var rectX2 : Number = positionOnGrid(endPoint[0]); //20
				var rectY2 : Number = positionOnGrid(endPoint[1]); //100
				*/
			
			/*for (var i :int = 1; i < points.length; i++) {
				var p_point :Array = points[i - 1];
				var c_point :Array = points[i];
				
				var pX :int, pY :int, cX :int, cY :int, rHeight :int, rWidth :int;
				
				if (p_point[0] <= c_point[0] && p_point[1] <= c_point[1]) {
					pX = model.getPointToPixels(p_point[0], false);
					pY = model.getPointToPixels(p_point[1], false);
					cX = model.getPointToPixels(c_point[0], false);
					cY = model.getPointToPixels(c_point[1], false);
					
					rHeight = Math.abs(pX - cX);
					rWidth  = Math.abs(pY - cY);
					
					if (pX == cX)
					{
						pX -= w;
						rHeight = w;
					}
					else if (pY == cY)
					{
						pY -= w;
						rWidth = w;
					}
				} else {
					pX = model.getPointToPixels(c_point[0], false) - w;
					pY = model.getPointToPixels(c_point[1], false) - w;
					cX = model.getPointToPixels(p_point[0], false) - w;
					cY = model.getPointToPixels(p_point[1], false) - w;
					
					rHeight = Math.abs(pX - cX);
					rWidth  = Math.abs(pY - cY);
					
					if (pX == cX)
					{
						rHeight = w;
					}
					else if (pY == cY)
					{
						rWidth = w;
					}
				}*/
				
				// Draw segment
				
			}
		}
		
		private function positionOnGrid(pos : Number) : Number {
			var newPos : Number = pos * 20;			
			return newPos;
		}
	}
}