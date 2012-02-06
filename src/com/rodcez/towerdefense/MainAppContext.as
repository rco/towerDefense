package com.rodcez.towerdefense
{
	
	import com.rodcez.towerdefense.controller.StartupAppCommand;
	import com.rodcez.towerdefense.model.CreepPathModel;
	import com.rodcez.towerdefense.model.GridBackgroundModel;
	import com.rodcez.towerdefense.signals.ApplicationInitialized;
	import com.rodcez.towerdefense.signals.CreepPathUpdate;
	import com.rodcez.towerdefense.signals.StartupApp;
	import com.rodcez.towerdefense.view.components.CreepPathView;
	import com.rodcez.towerdefense.view.components.GridMapView;
	import com.rodcez.towerdefense.view.mediators.CreepPathMediator;
	import com.rodcez.towerdefense.view.mediators.GridMapMediator;
	import com.rodcez.towerdefense.view.mediators.MainAppMediator;
	
	import org.robotlegs.mvcs.SignalInterceptionContext;
	
	public class MainAppContext extends SignalInterceptionContext
	{
		override public function startup():void {
			// Controller
			/*commandMap.mapEvent(SystemEvent.CLEAR_MESSAGES_REQUESTED, TryClearMessages);*/
			
			//Commands
			signalCommandInterceptionMap.mapSignalClass(StartupApp, StartupAppCommand);
			
			// Model
			/*injector.mapSingleton(UserModel);*/
			injector.mapSingleton(GridBackgroundModel);
			injector.mapSingleton(CreepPathModel);
			
			// Services
			/*injector.mapClass(IUserService, );*/
			
			// Signals
			injector.mapSingleton(StartupApp);
			injector.mapSingleton(ApplicationInitialized);
			injector.mapSingleton(CreepPathUpdate);
			/*injector.mapSingleton(UserUpdate);
			injector.mapSingleton(UserUpdated);*/
			
			// View
			/*mediatorMap.mapView(DummyDataView, DummyDataMediator);*/
			mediatorMap.mapView(MainApp, MainAppMediator);
			mediatorMap.mapView(GridMapView, GridMapMediator);
			mediatorMap.mapView(CreepPathView, CreepPathMediator);
			
			// Startup complete
			super.startup();
		}
	}
}