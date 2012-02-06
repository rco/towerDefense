package com.rodcez.towerdefense.services {
	import com.rodcez.towerdefense.model.vo.UserVO;
	
	import org.osflash.signals.Signal;
	
	public interface UserServiceInterface {	
		
		public function loadUsers () : void;
		
		public function addUser (user : UserVO) : void;
		
		public function updateUser (user : UserVO) : void;
		
		public function removeUser (user : UserVO) : void;
		
		function get usersLoaded() : Signal;
	}
}