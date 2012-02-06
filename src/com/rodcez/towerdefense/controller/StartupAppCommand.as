package com.rodcez.towerdefense.controller {

	
	import com.rodcez.towerdefense.signals.ApplicationInitialized;
	
	import org.robotlegs.mvcs.Command;

	/**
	 * @author Rafael Belvederese
	 */
	public class StartupAppCommand extends Command {
		
		[Inject]
		public var appInitialized : ApplicationInitialized;
		
		override public function execute() : void {
			this.loadPreferences();
		}
		
		private function loadPreferences() : void {
			appInit();
		}
		
		private function appInit() : void {
			appInitialized.dispatch();
		}
	}
}