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


Class RMD_SuperKegHealth : RMD_Milk
{
	Default
	{
		-COUNTITEM
		+INVENTORY.ALWAYSPICKUP;
		Inventory.Amount 500;	
  	}
	
	States
	{
		Spawn:
			BON1 A 1;
			Loop;
	}
}


Class RMD_SuperKeg : RMD_HealthBase 
{
	Default
	{
		-COUNTITEM
		Scale 1;
		Inventory.Amount 200;
		Inventory.PickupMessage "You energized yourself with a super keg!";
		Inventory.PickupSound "Items/UTSuperHealth";
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
