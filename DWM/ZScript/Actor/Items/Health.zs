class RMD_HealthBase : CustomInventory
{
	Default
	{
		-COUNTITEM
		Inventory.Amount 3;
		Inventory.MaxAmount 0x7D2B7500;
		Inventory.PickupMessage "You drink a box of milk. <+3 HP>";
		Inventory.PickupSound "Items/Drink";
	}
	
	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		
		Angle = Random[Angle](0, 360);	
	}
	
	override void Touch(Actor Toucher)
	{
		RMD_Player Player = RMD_Player(Toucher);
		
		if (Player)
		{
			//Print out the pickup message
			PrintPickupMessage(toucher.CheckLocalView(), PickupMessage());

			//temporary
			Toucher.A_GiveInventory("RMD_HealthTakeDelay", 1);
			
			//Do the effects now
			Player.HRegenAmount += Amount;
			Player.A_StartSound(PickupSound, CHAN_ITEM, CHANF_UI);
			Player.A_TakeInventory(Self.GetClassName(), 0xFFFFFF);			
		}
		
		Super.Touch(Toucher);
		Destroy();
	}
	
	States
	{

		Spawn:
			IDLE A -1;
			Stop;
	}	
}

Class RMD_Milk : RMD_HealthBase
{
	Default
	{
		Inventory.Amount 4;
		Inventory.PickupMessage "You drink a box of milk.";
		Inventory.PickupSound "Items/Drink";	
	}
}


Class RMD_Beef : RMD_HealthBase
{
	Default
	{
		Inventory.Amount 2;
		Inventory.PickupMessage "You ate a beef.";
		Inventory.PickupSound "Items/Eat";	
	}
}

Class RMD_Fishmeat : RMD_HealthBase
{
	Default
	{
		Inventory.Amount 3;
		Inventory.PickupMessage "You ate a Fish.";
		Inventory.PickupSound "Items/Eat";	
	}
}


Class RMD_Baltika3 : RMD_HealthBase
{
	Default
	{
		Inventory.Amount 3;
		Inventory.PickupMessage "You drink a Beer.";
		Inventory.PickupSound "Items/Drink";	
	}
}

Class RMD_MiniHealthVial : RMD_HealthBase
{
	Default
	{
		Inventory.Amount 2;
		Inventory.PickupMessage "You drink a mini potion.";
		Inventory.PickupSound "Items/Potion";
	}
}

class RMD_Stimpack : RMD_HealthBase
{
	Default
	{
		-COUNTITEM
		Inventory.Amount 8;
		Inventory.PickupMessage "You drink a small potion.";
		Inventory.PickupSound "Items/Potion";
	}
}

class RMD_Medikit : RMD_HealthBase
{
	Default
	{
		-COUNTITEM
		Inventory.Amount 20;
		Inventory.PickupMessage "You injected yourself with medicine.";
		Inventory.PickupSound "Items/UTHealth";
	}
}

class RMD_Healthkeg : RMD_HealthBase 
{
	Default
	{
		-COUNTITEM
		Scale 1;
		Inventory.Amount 100;
		Inventory.PickupMessage "You drink a large keg full of healthy liquid!";
		Inventory.PickupSound "Items/UTSuperHealth";
	}
}

class RMD_StimEnergy : RMD_HealthBase
{
	Default
	{
		-COUNTITEM
		Inventory.Amount 2;
		Inventory.PickupMessage "You picked up a can of energy drinks. <+2>";
		Inventory.PickupSound "Items/EnergyDrinkPick";
	}
}

//Medikit
class RMD_MedikitEnergy : RMD_HealthBase
{
	Default
	{
		-COUNTITEM
		Inventory.Amount 6;
		Inventory.PickupMessage "You picked up a pack of energy drinks. <+6>";
		Inventory.PickupSound "Items/EnergyDrinkPick";
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

Class RMD_Health_Small : RandomSpawner
{
	Default
	{

		Dropitem "RMD_MiniHealthVial", 256, 10;
		DropItem "RMD_Stimpack", 256, 6;
		DropItem "RMD_Milk", 256, 1;
		DropItem "RMD_Baltika3", 256, 1;
	}
}

Class RMD_Health_Medium : RandomSpawner
{
	Default
	{
		DropItem "RMD_Stimpack", 256, 10;
		DropItem "RMD_Medikit", 256, 3;
		DropItem "RMD_Fishmeat", 256, 5;
		DropItem "RMD_Beef", 256, 5;
	}
}


