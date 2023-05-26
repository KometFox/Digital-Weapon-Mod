Class PowerIronFeet_Perm : PowerIronFeet
{
	Default
	{
		Powerup.Duration -150;
		Powerup.Color "00 00 00", 0;
	}
}


Class RMD_NBCSuit : PowerupGiver
{
	
	Default
	{
		Height 46;
		+INVENTORY.AUTOACTIVATE
		+INVENTORY.ALWAYSPICKUP
		+INVENTORY.FORCERESPAWNINSURVIVAL
		+INVENTORY.ALWAYSRESPAWN;
		-COUNTITEM
		Inventory.MaxAmount 0;
		Inventory.PickupMessage "You put on the NBC Suit.";
		Inventory.PickupSound "pickup/Suit";
		Powerup.Type "PowerIronFeet_Perm";
	}
	
	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		
		Angle = Random[Angle](0, 360);	
	}
	
	
	States
	{
	Spawn:
		ARM2 A -1 Bright;
		Stop;
	}
}	

//------------------------------------------------------------------------------
//Megasphere 
//------------------------------------------------------------------------------
Class RMD_SuperKegArmor : RMD_ArmorBase
{
	Default
	{
		Inventory.Pickupmessage "Charged up your armor. <+500 Armor>";
		Inventory.PickupSound "Items/MediumArmorCell";
		Armor.Saveamount 500;	
	}
}


Class RMD_SuperKegHealth : Health
{
	Default
	{
		-COUNTITEM
		+INVENTORY.ALWAYSPICKUP;
		Inventory.Amount 300;
		Inventory.MaxAmount 300;		
  	}
	
	States
	{
		Spawn:
			BON1 A 1;
			Loop;
	}
}


Class RMD_SuperKeg : CustomInventory 
{
	Default
	{
		-COUNTITEM
		Scale 1;
		Inventory.PickupMessage "You energized yourself with a super keg! <+300 HP> + <+500 Armor>";
		Inventory.PickupSound "Items/UTSuperHealth";
	}
	
	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		
		Angle = Random[Angle](0, 360);	
	}	
	
	Override Bool TryPickup(in out Actor toucher)
	{
		Bool PickedUp = Super.TryPickUp(Toucher);
		Inventory PArmor = Toucher.FindInventory('BasicArmor', false);
		
		//Don't pickup the item when the player is at maxium health and armor
		if (PickedUp || Toucher.Health < 300 || PArmor.Amount < 500)
		{
			A_SpawnItemEx("RMD_HealthKegLitter");
			Toucher.A_GiveInventory("RMD_SuperKegArmor", 1);
			Toucher.A_GiveInventory("RMD_SuperKegHealth", 1);
			
			Destroy();
			Return True;
		}	
	
		Return False;
	}
  
	States
	{
		PickUp:
			TNT1 A 0;
			Stop;
		Spawn:
			IDLE A 1;
			Loop;
	}
}


//------------------------------------------------------------------------------
//AtomHealth 
//------------------------------------------------------------------------------
Class RMD_AtomHealth : CustomInventory 
{
	Default
	{
		Scale 1;
		Inventory.PickupMessage "You energized yourself with atoms! <+100 HP>";
		Inventory.PickupSound "Items/UTHealth";
	}
	
	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		
		Angle = Random[Angle](0, 360);	
	}
	
	Override Bool TryPickup(in out Actor toucher)
	{
		//Don't pick it up if Health is over that.
		If (toucher.health >= 200)
		{
			Return False;
		}
		
		Bool bHP; //Boolean check
		Actor HP; //The Actor
		
		//Health
		[bHP, HP] = A_SpawnItemEx("RMD_BeerBonus1", 64, 0, 32);
		let HPS = Health(HP);
		let Playa = PlayerPawn(Toucher);
		
		
		if (HPS && Playa)
		{
			HPS.bAlwaysPickup = True;
			HPS.bQuiet = True;
			HPS.Amount = 100;
			HPS.MaxAmount = Playa.MaxHealth;
			HPS.Touch(toucher);
		}
		
		else if (HP)
			HP.Destroy();
			
		Return Super.TryPickup(Toucher);
	}
	
  
	States
	{
		Pickup:
			TNT1 A 0 A_GiveInventory("RMD_BlankItem", 1);
			Stop;
		Spawn:
			IDLE A 1;
			Loop;
	}
}


Class RMD_Invisibility : CustomInventory 
{
	Default
	{
		Scale 1;
		Inventory.PickupMessage "You are now invisible!";
		Inventory.PickupSound "Items/Invisibility";
	}

  
	States
	{
		Pickup:
			TNT1 A 0 A_GiveInventory("BlurSphere", 1);
			Stop;
		Spawn:
			SINV ABCD 2;
			Loop;
	}
}

Class RMD_God : CustomInventory 
{
	Default
	{
		Scale 1;
		Inventory.PickupMessage "You are now invulnerable!";
		Inventory.PickupSound "Items/Invulnerability";
	}

  
	States
	{
		Pickup:
			TNT1 A 0 A_GiveInventory("InvulnerabilitySphere", 1);
			Stop;
		Spawn:
			PUIV ABCD 2;
			Loop;
	}
}
