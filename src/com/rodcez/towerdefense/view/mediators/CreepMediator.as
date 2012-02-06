package com.rodcez.towerdefense.view.mediators {
	import com.rodcez.towerdefense.view.components.CreepView;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	public class CreepMediator extends Mediator {
		
		[Inject]
		public var view : CreepView;
		
		override public function onRegister():void {
			
		}
		
		override public function preRemove():void {
			
		}
	}
}