package com.rodcez.towerdefense.controller {
	import com.rodcez.towerdefense.model.vo.UserVO;
	import com.rodcez.towerdefense.services.UserServiceInterface;
	
	import org.robotlegs.mvcs.Command;
	
	
	public class AddUserCommand extends Command {
		
		[Inject]
		public var user : UserVO;
		
		[Inject]
		public var userService : UserServiceInterface;
		
		override public function execute():void {
			if(user == null){
				user = new UserVO();
				user.name = "User Example";
				user.email = "user@example.com"
				user.active = false;
			}
			userService.addUser(user);
		}
	}
}