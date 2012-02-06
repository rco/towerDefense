package com.rodcez.towerdefense.view.mediators {
	import com.rodcez.towerdefense.model.GridBackgroundModel;
	import com.rodcez.towerdefense.signals.ApplicationInitialized;
	
	import flash.display.Graphics;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.core.SpriteVisualElement;
	
	
	public class MainAppMediator extends Mediator {
		
		[Inject]
		public var view : MainApp;
		
		[Inject]
		public var appInitialized : ApplicationInitialized;
		
		override public function onRegister():void {
			view.appComplete.add(appInitializedHandler);
		}
		
		override public function preRemove():void {
			view.appComplete.remove(appInitializedHandler);
			
		}
		
		private function appInitializedHandler() : void {
			appInitialized.dispatch();
		}
	}
}