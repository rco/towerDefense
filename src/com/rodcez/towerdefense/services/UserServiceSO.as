package com.rodcez.towerdefense.services {
	import com.rodcez.towerdefense.model.UserModel;
	import com.rodcez.towerdefense.model.vo.UserVO;
	import com.rodcez.towerdefense.signals.UserUpdate;
	import com.rodcez.towerdefense.signals.UsersListSignal;
	
	import flash.net.SharedObject;
	
	import org.osflash.signals.Signal;
	
	
	public class UserServiceSO implements UserServiceInterface {
		
		[Inject]
		public var userModel : UserModel;
		
		[Inject]
		public var userUpdate : UserUpdate;
		
		private var _so : SharedObject;
		
		private var _usersLoaded : UsersListSignal = new UsersListSignal();
		
		public function loadUsers () : void {
			var users : Array = new Array();
			for each(var tempUser : Object in so.data.users) {
				var user : UserVO = new UserVO();
				user.id = tempUser.id;
				user.name = tempUser.name;
				user.active = tempUser.active;
				users.push(user);
			}
			_usersLoaded.dispatch(users);
		}
		
		public function addUser (user : UserVO) : void {
			user.id = userModel.getLastId();
			so.data.users.push(user);
			so.flush();
			userUpdate.dispatch();
		}
		
		public function updateUser (user : UserVO) : void {
			var i : int = 0;
			for each(var tempUser : Object in so.data.users) {
				if (user.id == tempUser.id) {
					tempUser.name = user.name; 
					tempUser.email = user.email; 
					tempUser.active = user.active; 
					break;
				}
				i++;
			}
			so.flush();
		}
		
		public function removeUser (user : UserVO) : void {
			var i : int = 0;
			for each(var tempUser : Object in so.data.users) {
				if (user.id == tempUser.id) {
					so.data.users.splice(i, 1);
					break;
				}
				i++;
			}
			so.flush();
		}
		
		function get usersLoaded() : UsersListSignal {
			return _usersLoaded;
		}

		public function get so():SharedObject {
			if (_so == null)
				_so = SharedObject.getLocal("dummySO");
			
			if (_so.data.users == null)
				_so.data.users = [];
			
			return _so;
		}
	}
}