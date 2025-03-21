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
	//Used to check if any rounds are left of the mag variable
	Action bool MagLeft(int AmmoCount)
	{
		if (AmmoCount > 0)
		{
			return True;
		}

		return False;
	}
	
	Action state CheckIfAmmo(int Amount, string ToJump)
	{
		//Check for Ammo
		if (Amount <= 0)
		{		
			return Invoker.FindStateByString(ToJump);
		}
		
		return Invoker.ResolveState(Null);
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
		A_TakeInventory("NOAMMO", int.Max);
		A_TakeInventory("GoToReload", int.Max);
		A_TakeInventory("Reloading", int.Max); 
	}
	
	//Used to initalize the weapon.
	Action void InitWeapon(RMD_InitWeapon IWpn)
	{
		TakeCounterItem();

		RMD_BARINFO.Set_Mag(IWpn.Magazine);
		RMD_BARINFO.SetAmmoIcon(IWpn.AmmoIcon);
		RMD_BARINFO.SetAmmo1(IWpn.Ammo1);
	}

	Action state FireCheck()
	{
		//Experimental method for a more reliable and generic
		//State jumper for firing the gun. 
		FiringCheck FCheck = new("FiringCheck");
		
		FCheck.RMDGun = Invoker;
		FCheck.IronSight = Invoker.IronSight;
		FCheck.Init();
		
		return Invoker.FindStateByString(FCheck.FireGun());
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
	

	//Modified script so that it works for various type of weapons including
	//behavior that takes more than 1 unit of ammo 
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
				RMD_BARINFO.Set_Mag(invoker.Magazine);
				break;
			case 1: 
				Invoker.Magazine2 = BaseWeapon.AmmoCount(Player.mo, AmmoItem, AmmoToAdd, AmmoUse, Single, Invoker.Magazine2, Invoker.MagazineMax2);
				RMD_BARINFO.Set_Mag(invoker.Magazine2);
				break;
			default:
				Invoker.Magazine = BaseWeapon.AmmoCount(Player.mo, AmmoItem, AmmoToAdd, AmmoUse, Single, Invoker.Magazine, Invoker.MagazineMax);
				RMD_BARINFO.Set_Mag(invoker.Magazine);
				break;
		}	
	}
	
	Action Void A_ChargeThrow()
	{
		A_GiveInventory("GrenadeThrowPower", 2);
		
		if (CountInv("GrenadeThrowPower") >= 45)
		{
			A_SetInventory("GrenadeThrowPower", 45);
		}
		
		RMD_BARINFO.SetThrowPower(CountInv("GrenadeThrowPower"));
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
	
	
	action void C_SpawnCasing(Class<Actor> Obj = "PistolCase", Vector3 COffset = (0, 0, 0), int PAngle = 0)
	{
		Vector3 x, y, z;
		int Ydir = 1;
		[x, y, z] = dt_Matrix4.GetAxes(pitch, angle, roll);
		Vector3 origin = Vec2OffsetZ(0,0,player.viewz) + 10.0 * x + 3.0 * y - 1.8  * z;

	
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
	
	action void B_WpnRecoil(double Strength) 
	{
		RMD_PitchRecoil Item = RMD_PitchRecoil(GiveInventoryType("RMD_PitchRecoil"));

		Item.RecoilStrength = Strength;	
	}

States
{
	//Default states to fall to.
	Ready:
		CHGG A 0;
		TNT1 A 0 A_Jump(256, "Init");
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
		"####" A 0 
		{
			RMD_BARINFO.SetFireMode("");
		}
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
		MGUN A 0 NoDelay;
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

class RMD_FireInv : Powerup
{
	TranslationID OldTrans;
	String FireParticle; 
	Name SetTrans;
	int OldSpeed; 
	const DMGMFlag = DMG_THRUSTLESS | DMG_NO_PAIN; 

    Default
    {
        +INVENTORY.AUTOACTIVATE
        +INVENTORY.ALWAYSPICKUP
        Inventory.MaxAmount 1;
        Powerup.Duration TICRATE * 8;
    }
	
	static void AttachFire(Actor Victim, Actor DamageSource, String ParticleEffect, Name Trans)
	{
		RMD_FireInv Myself = RMD_FireInv(Victim.GiveInventoryType("RMD_FireInv"));
		
		Myself.Target = DamageSource;
		Myself.FireParticle = ParticleEffect;
		Myself.SetTrans = Trans; 
	}
	
	override bool TryPickup(in out Actor Toucher)
	{
		bool Touched = Super.TryPickup(Toucher);

		if (!Toucher || !Owner)
			return False;

		OldTrans = Owner.Translation;
		OldSpeed = Owner.Speed; 
		//Owner.Speed = 24;
		//Owner.bFRIGHTENED = true;
		//Owner.bFRIGHTENING = true;
		
		Return True; 
	}	
	

	override void Tick()
	{
		Super.Tick();
		
		if (Level.isFrozen() || !Owner) 
			return;
	}


    override void DoEffect()
    {
        Super.DoEffect();
		
        if (!Owner)
			return;
	
		Owner.A_SetTranslation(SetTrans);
			
		if (GetAge() % 3 == 0)
			Spawn(FireParticle, Owner.Pos);
			
		if (GetAge() % 5 == 0)
		{
			if (!Owner)
				return;
		
			Owner.ResolveState("Pain");	
			Owner.DamageMobj(Self, Target, 15 * FRandom(0, 1.8), 'Fire', DMGMFlag);
        }		

    }
	
	override void EndEffect()
	{
		if (!Owner)
			return;

		Owner.A_SetTranslation("Charred");
		Owner.BBuddha = false; 
		Owner.Speed = OldSpeed; 
		Owner.bFRIGHTENED = false;
		Owner.bFRIGHTENING = false;
	
		Super.EndEffect();	
	}
	
}

Class RMD_CorpseEffect : Actor
{
	String ParticleEffect;
	int Timer;

	Property Timer:Timer;
	
	Default
	{
		RMD_CorpseEffect.Timer TICRATE * 5;	
	}
	
	void DoTime()
	{
		Timer -= 1;
		
		if (Timer <= 0)
			Destroy();	
	}

	override void Tick()
	{
		Super.Tick();
		
		if (Level.IsFrozen())
			return;
		
		if (GetAge() % 8 == 0)
			A_SpawnItemEx(ParticleEffect, 0, 0, 0);	
			
		DoTime();
	}

}

Class RMD_InitWeapon 
{
	int Magazine;
	string AmmoIcon;
	string Ammo1;
}

//Scripted Class for a more generic gun firing behavior 
Class FiringCheck
{
	
	//The FireNow state
	string Fire; 
	int IronSight;
	int AltFire;
	BaseWeapon RMDGun; 
	
	void Init()
	{
		//Regular Fire
		Fire = "FireNow";
		//Alternative Fire
	
		//Handle Ironsight mode
		if (RMDGun.IronSight == RMDGun.IRON_ACTIVE)
			Fire = "Iron" .. Fire;
			
		//Handle Alternative fire mode
	}
	

	string FireGun()
	{
		return Fire;	
	}


}

/*
Stuff for Recoil Effect
*/


class RMD_PitchRecoil : Powerup
{
	double RecoilStrength; 
	double RecoilMult;

	Property RecoilStrength:RecoilStrength;
	Property RecoilMult:RecoilMult; 

    Default
    {
        +INVENTORY.AUTOACTIVATE
        +INVENTORY.ALWAYSPICKUP
        Inventory.MaxAmount 1;
        Powerup.Duration 3;
		
		RMD_PitchRecoil.RecoilStrength 1;
		RMD_PitchRecoil.RecoilMult 1;
    }
	
    override void DoEffect()
    {
        Super.DoEffect();
		
		//Failsafe check
        if (!Owner)
			return;
			
		if (GetAge() == 1)
		{
			Owner.A_SetPitch(Owner.Pitch - RecoilStrength);
		}
		
		if (GetAge() == 2)
		{
			Owner.A_SetPitch(Owner.Pitch + RecoilStrength);
		}
	}	
	
}












