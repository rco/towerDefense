package com.rodcez.towerdefense.view.mediators {
	import com.rodcez.towerdefense.model.GridBackgroundModel;
	import com.rodcez.towerdefense.signals.ApplicationInitialized;
	import com.rodcez.towerdefense.signals.CreepPathUpdate;
	import com.rodcez.towerdefense.view.components.GridMapView;
	
	import flash.display.Graphics;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.core.SpriteVisualElement;
	
	
	public class GridMapMediator extends Mediator {
		
		[Inject]
		public var view : GridMapView;
		
		[Inject]
		public var gridMap : GridBackgroundModel;
		
		[Inject]
		public var appInitialized : ApplicationInitialized;
		
		[Inject]
		public var creepPathUpdate : CreepPathUpdate;
		
		override public function onRegister():void {
			appInitialized.add(appInitializedHandler)
				
		}
		
		override public function preRemove():void {
			appInitialized.remove(appInitializedHandler)
			
		}
		
		private function appInitializedHandler() : void {
			var sprCont:SpriteVisualElement = new SpriteVisualElement();
			
			sprCont.addChild(gridMap.drawBackground(view.gridMapContainer.width, view.gridMapContainer.height));
			view.gridMapContainer.addElement(sprCont);
			creepPathUpdate.dispatch();
		}
	}
}