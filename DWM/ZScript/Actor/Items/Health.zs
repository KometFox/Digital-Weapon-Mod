class RMD_HealthBase : CustomInventory
{
	Default
	{
		-COUNTITEM
		+INVENTORY.ISHEALTH
		Inventory.PickupMessage "Got some health items.";
		Inventory.PickupSound "Items/Water";
	}
	
	
	States
	{
		Spawn:
			TNT1 A 0;
		Spawn1:
			IDLE A 1;
			Loop;
			
		Pickup:
			TNT1 A 0 A_GiveInventory("RMD_HealthAmmo", Invoker.Amount);
			Stop;
	}
}


//------------------------------------------------------------------------------
//Items
//------------------------------------------------------------------------------
class RMD_EnergyCanBonus1 : Health
{
	Default
	{
		-COUNTITEM
		Inventory.Amount 5;
		Inventory.MaxAmount 1000;
		Inventory.PickupMessage "You drink a can of Energy. <+5 HP>";
		Inventory.PickupSound "Items/Water";
	}
	
	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		
		Angle = Random[Angle](0, 360);	
	}
	
	Override Bool TryPickup(in out Actor toucher)
	{
		bool PickedUp = Super.TryPickup(toucher);
		
		if (PickedUp == True)
		{
			Toucher.A_StartSound(Self.PickupSound, CHAN_ITEM, 1.0);
			A_SpawnItemEx("EmptyEnergyCan1", 0, 0, 20, frandom(-8, 8), frandom(-8, 8), frandom(-2, 4));
		}
		Return False; 
	}
	
	States
	{

		Spawn:
			IDLE AA 1;
			Loop;
	}	
	
}

class RMD_BeerBonus1 : Health
{
	Default
	{
		-COUNTITEM
		Inventory.Amount 5;
		Inventory.MaxAmount 1000;
		Inventory.PickupMessage "You drink a bottle of beer. <+5 HP>";
		Inventory.PickupSound "Player/Drink";
	}
	
	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		
		Angle = Random[Angle](0, 360);	
	}
	
	Action void Picked(Actor Toucher)
	{
		A_SpawnItemEx("EmptyBeer1", 0, 0, 20, frandom(-8, 8), frandom(-8, 8), frandom(-2, 4));
	}
	
	override void Touch(Actor toucher)
	{
		Picked(Toucher);

		Super.Touch(toucher);
	}
	
	States
	{

		Spawn:
			IDLE AA 1;
			Loop;
	}	
}


class RMD_Milk : Health
{
	Default
	{
		-COUNTITEM
		Inventory.Amount 10;
		Inventory.MaxAmount 1000;
		Inventory.PickupMessage "You drinked a box of milk. <+10 HP>";
		Inventory.PickupSound "Player/Drink";
	}
	
	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		
		Angle = Random[Angle](0, 360);	
	}
	
	Action void Picked(Actor Toucher)
	{
		A_SpawnItemEx("EmptyMilk", 0, 0, 20, frandom(-8, 8), frandom(-8, 8), frandom(-2, 4));
	}
	
	override void Touch(Actor toucher)
	{
		Picked(Toucher);

		Super.Touch(toucher);
	}
	
	States
	{

		Spawn:
			IDLE AA 1;
			Loop;
	}	
}

class RMD_StimEnergy : RMD_HealthBase
{
	Default
	{
		-COUNTITEM
		Inventory.Amount 25;
		Inventory.PickupMessage "You picked up a can of energy drinks. <+25>";
		Inventory.PickupSound "Items/EnergyDrinkPick";
	}
}

//Medikit
class RMD_MedikitEnergy : RMD_HealthBase
{
	Default
	{
		-COUNTITEM
		Inventory.Amount 75;
		Inventory.PickupMessage "You picked up a pack of energy drinks. <+75>";
		Inventory.PickupSound "Items/EnergyDrinkPick";
	}
}

//Soulsphere
Class RMD_HealthKegBase : Health
{
	Default
	{
		-COUNTITEM
		+INVENTORY.ALWAYSPICKUP;
		Inventory.Amount 200;
		Inventory.MaxAmount 300;		
  	}
	
	States
	{
		Spawn:
			BON1 A 1;
			Loop;
	}
}

Class RMD_Healthkeg : CustomInventory 
{
	Default
	{
		-COUNTITEM
		Scale 1;
		Inventory.PickupMessage "You drink a large keg full of healthy liquid <+200 HP>!";
		Inventory.PickupSound "Items/UTSuperHealth";
	}
	
	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		
		Angle = Random[Angle](0, 360);	
	}
	
	Override Bool TryPickup(in out Actor toucher)
	{
		bool PickedUp = Super.TryPickup(toucher);
	
		If (PickedUp || toucher.health < 300)
		{
			Toucher.A_GiveInventory("RMD_HealthKegBase",1);
			A_SpawnItemEx("RMD_HealthKegLitter");
		
			Destroy();
			Return True;
		}
		
				
		Return False;
	}
  
	States
	{
		Pickup:
			TNT1 A 0; 
			Stop;	
		Spawn:
			IDLE A 1;
			Loop;
	}
}


class RMD_Stimpack : Health
{
	Default
	{
		-COUNTITEM
		Inventory.Amount 15;
		Inventory.MaxAmount 100;
		Inventory.PickupMessage "You picked up a stimpack. <+15 HP>";
		Inventory.PickupSound "Items/UTHealth";
	}

	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		
		Angle = Random[Angle](0, 360);	
	}


	Override Bool TryPickup(in out Actor toucher)
	{
		bool PickedUp = Super.TryPickup(toucher);
	
		if (PickedUp)
		{
			A_SpawnItemEx("StimpackLitter");
			Return True;
		}
	
		Return False; 
	}
	
	States
	{

		Spawn:
			IDLE A -1;
			Stop;
	}	
	
}

class RMD_Medikit : Health
{
	Default
	{
		-COUNTITEM
		Inventory.Amount 30;
		Inventory.MaxAmount 100;
		Inventory.PickupMessage "You picked up a medikit. <+10 HP>";
		Inventory.PickupSound "Items/UTHealth";
	}
	
	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		
		Angle = Random[Angle](0, 360);	
	}	
	
	Override Bool TryPickup(in out Actor toucher)
	{
		bool PickedUp = Super.TryPickup(toucher);
	
		if (PickedUp)
		{
			A_SpawnItemEx("MediKitLitter");
			
			Return True;
		}
	
		Return False; 
	}
	
	States
	{

		Spawn:
			IDLE A -1;
			Stop;	
	}	
	
}

//------------------------------------------------------------------------------
//Shop Items
//------------------------------------------------------------------------------
class RMD_Shop_Medkit1 : RMD_HealthBase
{
	Default
	{
		Inventory.Amount 100;
		Inventory.MaxAmount 200;		
	}
}

class RMD_Shop_Medkit2 : RMD_HealthBase
{
	Default
	{
		Inventory.Amount 50;
		Inventory.MaxAmount 1000;		
	}
}
