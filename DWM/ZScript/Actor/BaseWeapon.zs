/*
The main part of this mod, the weapon base class that every shooter fans like to
use, blam blam. 
TODO: Refactor the functions and simplifiy it. 
*/
Class BaseWeapon : DoomWeapon
{
	//Constants
	Const BULLETFIRE = FBF_NORANDOM;
	Const MUZZLEFLAGS = SXF_TRANSFERPITCH;
	//Variables
	//Ammunition
	int Magazine, MagazineMax;
	int Magazine2, MagazineMax2;
	bool Reloading;
	//Firemode
	int IronSight;
	int FireMode;
	int BurstCount;
	
	//Default definition
	//Magazine
	Property Magazine:Magazine;
	Property MagazineMax:MagazineMax;
	Property Magazine2:Magazine2;
	Property MagazineMax2:MagazineMax2;
	//Reload
	Property Reloading:Reloading;
	//Firemode
	Property FireMode:FireMode;
	//Ironsight
	Property IronSight:IronSight;

Default
{
	BaseWeapon.Reloading false;
	Weapon.AmmoType1 "Clip";
	Weapon.AmmoType2 "Clip";
	+Weapon.NoAlert;
	
	Weapon.BobRangeX 0.5;
	Weapon.BobRangeY 0.75;
	Weapon.BobSpeed 1.66;
	Weapon.BobStyle "InverseSmooth";
}

Enum E_Ammo
{
	PRIMARY,
	SECONDARY,
	TERITARY,
}


Enum E_IronSight
{
	IRON_INACTIVE,
	IRON_ACTIVE,
}


static int Get_Magazine()
{
	BaseWeapon BW;
	
	if (BW != null)
	{
		return BW.Magazine;
	}
	return 0;
}

	override void Tick()
	{
		Super.Tick();

		if ( !Owner || !Owner.player || (Owner.player.ReadyWeapon != self) ) 
			return;
		
		if (IronSight == IRON_ACTIVE)
		{
			Owner.player.WeaponState &= ~WF_WEAPONBOBBING; 
		}
		else
		{
			Owner.player.WeaponState |= WF_WEAPONBOBBING; // UT weapons always bob
		}
	}
	
	//Code from Matt
    action void SetWeaponState(statelabel st, int layer=PSP_WEAPON)
    {
        if(player) 
			player.setpsprite(layer, invoker.findstate(st));
    }
	
	//Buttons Check
	action bool PressFire()
	{
		return player.cmd.buttons & BT_ATTACK;
	}
	
    action bool PressReload()
	{
		return player.cmd.buttons & BT_RELOAD;
	}
	
	action bool PressUse()
	{
		return player.cmd.buttons & BT_USE;
	}
	
	//Used to clear off counter items
	Action void TakeCounterItem()
	{
		A_TakeInventory("NOAMMO", 999);
		A_TakeInventory("GoToReload", 999);
		A_TakeInventory("Reloading", 999); 
	}
	
	//Used to check if any rounds are left of the mag variable
	Action bool MagLeft(int AmmoCount)
	{
		if (AmmoCount > 0)
		{
			return True;
		}

		return False;
	}
	
	Action state ReloadCheck()
	{
		return B_ReloadGoTo(
							"ReadyReal", 
							"IronReady", 
							"IronSightDeselect", 
							"ReloadNow",
							Invoker.AmmoType1,
							Invoker.Magazine,
							Invoker.MagazineMax,
							1);
	}
	

	//Check if there is enough ammo left to consume
	bool AmmoCheck(Class<Ammo> VAmmo = "Clip", int AmmoUse = 0)
	{
		if (Owner.CountInv(VAmmo) >= AmmoUse)
		{
			return true;
		}
		
		return false;
	}

	//Check which state to jump into if ironsight is on or not
	action state ReloadIronCheck(statelabel IronDeselect, statelabel ReloadState)
	{
	
		if (Invoker.IronSight == IRON_ACTIVE)
		{
			A_GiveInventory("GotoReload", 1);
			return ResolveState(IronDeselect);
		}
		else
		{
			return ResolveState(ReloadState);
		}
		
	
		return ResolveState("ReadyReal");
	}

	//Check if the gun needs reload
	action state B_ReloadGoTo(statelabel ReadyState = "ReadyReal", 
							statelabel IronReadyState = "ReadyReal",  
							statelabel IronDeselectState = "ReadyReal", 
							statelabel ReloadState = "ReadyReal",
							Class<Ammo> AmmoClass = "Clip",
							int LoadedAmmo = 0,
							int AmmoMax = 1,
							int AmmoUse = 1)
	{
		
		if ((LoadedAmmo < AmmoMax) && invoker.AmmoCheck(AmmoClass, AmmoUse)) 
			return invoker.ReloadIronCheck(IronDeselectState, ReloadState);		
		
		return ResolveState("ReadyReal");
	}
	
	//Goes to ironsight or normal sight mode. 
	action state B_GoToIronSight(statelabel IronAnim, statelabel IronDeselect)
	{
		if (Invoker.IronSight == IRON_INACTIVE)
		{
			Invoker.IronSight = IRON_ACTIVE;
				
			Return ResolveState(IronAnim);
		}
		else
		{
			Invoker.IronSight = IRON_INACTIVE;
			
			Return ResolveState(IronDeselect);
		}
		
		Return ResolveState("ReadyReal");
	}
	
	//Function for reloading magazine based weapons
	Action void ReloadMagazine(int AmmoType = PRIMARY, int AmmoToAdd = 1, int AmmoUse = 1)
	{

		//Primary Ammo
		if (AmmoType == PRIMARY)
		{
			if (CountInv(Invoker.AmmoType1) > 0)
			{
				int AmmoUsed = Invoker.MagazineMax - Invoker.Magazine;
			
				Invoker.Magazine += AmmoToAdd;
				TakeInventory(invoker.AmmoType1, AmmoUsed);
			}
			
		}

		//Secondary Ammo
		else if (AmmoType == SECONDARY)
		{
			if (CountInv(Invoker.AmmoType2) > 0)
			{
				int AmmoUsed = Invoker.MagazineMax2 - Invoker.Magazine2;
			
				Invoker.Magazine2 += AmmoToAdd;
				TakeInventory(invoker.AmmoType2, AmmoUsed);
			}			
		}
		

		//Failsafe to make the Magazine not become larger than its maximum.
		if (Invoker.Magazine > Invoker.MagazineMax)
		{
			Invoker.Magazine = Invoker.MagazineMax;
		}			

		if (Invoker.Magazine2 > Invoker.MagazineMax2)
		{
			Invoker.Magazine2 = Invoker.MagazineMax2;
		}
	}
	
	//For weapons like shotguns or rifles
	//Shotgun like weapons need a different logic so that it properly uses up
	//the ammunition. 
	Action void ReloadSingle(int AmmoType = Primary, int AmmoToAdd = 1, int AmmoUse = 1)
	{
	
		//Primary Ammo
		if (AmmoType == PRIMARY)
		{		
			if (CountInv(Invoker.AmmoType1) >= AmmoUse)
			{
				int AmmoConsumed = Invoker.MagazineMax - Invoker.Magazine;
				
				if (AmmoConsumed > AmmoUse)
					AmmoConsumed = AmmoUse;
			
				Invoker.Magazine += AmmoToAdd;
				TakeInventory(invoker.AmmoType1, AmmoConsumed);
			}
			
			else if (CountInv(Invoker.AmmoType1) < AmmoUse)
			{
				Invoker.Magazine += CountInv(Invoker.AmmoType1);
				TakeInventory(invoker.AmmoType1, CountInv(Invoker.AmmoType1));
			}		
		}
	
		else if (AmmoType == SECONDARY)
		{		
			if (CountInv(Invoker.AmmoType2) >= AmmoUse)
			{
				int AmmoConsumed = Invoker.MagazineMax2 - Invoker.Magazine2;
				
				if (AmmoConsumed > AmmoUse)
					AmmoConsumed = AmmoUse;
					
				Invoker.Magazine2 += AmmoToAdd;
				TakeInventory(invoker.AmmoType2, AmmoConsumed);
			}
			
			else if (CountInv(Invoker.AmmoType2) < AmmoUse)
			{
				Invoker.Magazine2 += CountInv(Invoker.AmmoType2);
				TakeInventory(invoker.AmmoType1, CountInv(Invoker.AmmoType2));
			}		
		}	
	
		//Failsafe to make the Magazine not become larger than its maximum.
		if (Invoker.Magazine > Invoker.MagazineMax)
		{
			Invoker.Magazine = Invoker.MagazineMax;
		}			

		if (Invoker.Magazine2 > Invoker.MagazineMax2)
		{
			Invoker.Magazine2 = Invoker.MagazineMax2;
		}	
	}
		
	//Marisa Kirisame Flak_M.pk3 code. 
	action void B_SpawnCasing(Class<Actor> Obj = "PistolCase", Vector3 COffset = (0, 0, 0), int PAngle = 0)
	{
		Vector3 x, y, z;
		int Ydir = -1;
		[x, y, z] = dt_Matrix4.GetAxes(pitch, angle + PAngle, roll);
		Vector3 origin = Vec2OffsetZ(0,0,player.viewz) + 10.0 * x + 3.0 * y -1.8 * z;

	
		origin += x * (1.0 + COffset.x) + ydir * y * (6.0 + COffset.y) -z * (2.0 + COffset.z);		
		let C = Spawn(Obj, origin);
		C.vel = x*FRandom[Junk](-0.5, 0.5) + y * ydir * FRandom[Junk](1.5,3) + z * FRandom[Junk](1.5,2);	
	}		
		
	action void B_MuzzleFlash(Class<RMD_WeaponMuzzleFlash> Particle = "RMD_BulletMuzzleFLash", Vector3 POffset = (0, 0, 0))
	{
		Vector3 x, y, z;
		[x, y, z] = dt_Matrix4.GetAxes(pitch, angle, roll);
		Vector3 Origin = Vec2OffsetZ(0,0,player.viewz) + 10.0 * x +3.0 * y -1.8 * z;

		let Obj = Spawn(Particle, Origin);
		Obj.Target = self;
		RMD_WeaponMuzzleFlash(Obj).SpawnMuzzleFlash(Self, Origin, POffset);
	}

States
{
	//Default states to fall to.
	Ready:
		CHGG A 0;
		TNT1 A 0 
		{
			A_Jump(256, "Init");
		
		}
		Goto Init;
		
	Init:
		CHGG A 0 A_Jump(256, "ReadyReal");
		Goto ReadyReal;
	
	ReadyReal:
		CHGG A 0;
		IDLE A 1 A_WeaponReady(WRF_NOBOB | WRF_ALLOWRELOAD);
		Loop;
		
	IronReady:
		TNT1 A 0; //A_Jump(256, "IronReady");
		"####" A 1;
		Loop;
	Deselect:
		"####" A 1 A_Lower;
		Loop;
	Select:
		"####" A 1 A_Raise;
		Loop;
	Fire:
		"####" A 4;
		"####" B 6 A_FirePistol;
		"####" C 4;
		"####" B 5 A_ReFire;
		Goto Ready;
	Flash:
		"####" A 7 Bright A_Light1;
		Goto LightDone;
		"####" A 7 Bright A_Light1;
		Goto LightDone;
 	
	Spawn:
		MGUN AA 0;
		Stop;
	
	Drop:
		TNT1 A 0;
		Stop;
	//End of Default States


	Delay:
		"####" "#" 8
		{
			if (Invoker.FireMode == IRON_ACTIVE)
			{
				Return A_Jump(256, "IronReady");
			}
			else if (Invoker.FireMode == IRON_INACTIVE)
			{
				Return A_Jump(256, "Ready");
			}
			
			Return A_Jump(256, "Ready");
		}
		Goto Ready;

}
}
