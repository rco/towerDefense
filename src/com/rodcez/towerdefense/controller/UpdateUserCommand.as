package com.rodcez.towerdefense.controller {
	import com.rodcez.towerdefense.model.vo.UserVO;
	
	import org.robotlegs.mvcs.Command;
	import com.rodcez.towerdefense.services.UserServiceInterface;
	
	
	public class UpdateUserCommand extends Command {
		
		[Inject]
		public var updateUser : UserVO;
		
		[Inject]
		public var userService : UserServiceInterface;
		
		override public function execute():void {
			userService.updateUser(updateUser);
		}
	}
}