package com.rodcez.towerdefense.signals {
	import com.rodcez.towerdefense.model.vo.UserVO;
	
	import org.osflash.signals.Signal;
	
	
	public class UserUpdate extends Signal{
		
		public function UserUpdate() {
			super(UserVO);
		}
	}
}