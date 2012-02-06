package com.rodcez.towerdefense.model {
	import com.rodcez.towerdefense.model.vo.UserVO;
	import com.rodcez.towerdefense.signals.UserUpdated;
	
	public class UserModel {
		
		[Inject]
		public var userUpdated : UserUpdated;
		
		private var _users : Vector.<UserVO> = new Vector.<UserVO>;

		public function get users():Vector.<UserVO> {
			
			return _users;
		}
		
		public function getUserById(id : String):UserVO {
			
			for (var i:int = 0; i < _users.length; i++) {
				if(id == _users[i].id){
					return _users[i];
				}
			}
			return null;
		}
		
		public function getLastId() : int {
			return int(_users[_users].id) + 1;		
		}
	}
}