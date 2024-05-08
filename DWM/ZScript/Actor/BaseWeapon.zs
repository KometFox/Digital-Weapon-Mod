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
	
	Weapon.BobRangeX 0.35;
	Weapon.BobRangeY 0.8;
	Weapon.BobSpeed 1.5;
	Weapon.BobStyle "Alpha";
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
	
	Action state ReloadCheck(int AmmoUse = 1)
	{
		return B_ReloadGoTo(
							"ReadyReal", 
							"IronReady", 
							"IronSightDeselect", 
							"ReloadNow",
							Invoker.AmmoType1,
							Invoker.Magazine,
							Invoker.MagazineMax,
							AmmoUse);
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
		
		//console.printf("%d | %d", Player.mo.CountInv(AmmoClass), AmmoUse);
		
		if ((LoadedAmmo < AmmoMax) && Player.mo.CountInv(AmmoClass) >= AmmoUse) 
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
	
	//For weapons like shotguns or rifles
	//Shotgun like weapons need a different logic so that it properly uses up
	//the ammunition. 
	static int AmmoCount(PlayerPawn Player, Class<Inventory> AmmoItem, int AmmoAdd, int AmmoU, bool Single, int AmmoMag, int AmmoMax)
	{
		
		while (AmmoMag < AmmoMax && Player.CountInv(AmmoItem) >= AmmoU)
		{
			AmmoMag += AmmoAdd;			
			Player.TakeInventory(AmmoItem, AmmoU);
			
			if (Single == True)
			{
				break;
			}
		}
	
		return AmmoMag = clamp(AmmoMag, 0, AmmoMax);
	}	

	Action void ReloadGun(Class<Inventory> AmmoItem, 
						int MagClass = 0,
						int AmmoToAdd = 1, 
						int AmmoUse = 1,
						bool Single = False)
	{
		switch(MagClass)
		{
			case 0: 
				Invoker.Magazine = BaseWeapon.AmmoCount(Player.mo, AmmoItem, AmmoToAdd, AmmoUse, Single, Invoker.Magazine, Invoker.MagazineMax);
				break;
			case 1: 
				Invoker.Magazine2 = BaseWeapon.AmmoCount(Player.mo, AmmoItem, AmmoToAdd, AmmoUse, Single, Invoker.Magazine2, Invoker.MagazineMax2);
				break;
			default:
				Invoker.Magazine = BaseWeapon.AmmoCount(Player.mo, AmmoItem, AmmoToAdd, AmmoUse, Single, Invoker.Magazine, Invoker.MagazineMax);
				break;
		}	
	}
		
	//Marisa Kirisame Flak_M.pk3 code. 
	action Actor B_SpawnCasing(Class<Actor> Obj = "PistolCase", Vector3 COffset = (0, 0, 0), int PAngle = 0)
	{
		Vector3 x, y, z;
		int Ydir = -1;
		[x, y, z] = dt_Matrix4.GetAxes(pitch, angle + PAngle, roll);
		Vector3 origin = Vec2OffsetZ(0,0,player.viewz) + 10.0 * x + 3.0 * y -1.8 * z;

	
		origin += x * (1.0 + COffset.x) + ydir * y * (6.0 + COffset.y) -z * (2.0 + COffset.z);		
		let C = Spawn(Obj, origin);
		C.vel = x*FRandom[Junk](-0.5, 0.5) + y * ydir * FRandom[Junk](1.5,3) + z * FRandom[Junk](1.5,2);
		
		return C;
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
