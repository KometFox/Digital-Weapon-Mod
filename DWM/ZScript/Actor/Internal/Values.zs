//Very special
Class SpecialItem : Inventory
{
	Default
	{
		Inventory.MaxAmount 1;
		Inventory.Amount 1;
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		+INVENTORY.HUBPOWER
		+INVENTORY.PERSISTENTPOWER
	}
}

Class CustomSpecialItem : CustomInventory
{
	Default
	{
		Inventory.MaxAmount 1;
		Inventory.Amount 1;
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		+INVENTORY.HUBPOWER
		+INVENTORY.PERSISTENTPOWER
	}
}

//The item tracker for armor regeneration
Class ArmorHitDelay : SpecialItem 
{
	Default
	{
		Inventory.Amount 1;
		Inventory.MaxAmount 210;
		+INVENTORY.KEEPDEPLETED //Needed so that the whole system works.		
	}
}

//The item tracker for armor regeneration
Class MagnetFakeItem : CustomSpecialItem 
{
	Default
	{
		Inventory.Amount 1;
		Inventory.MaxAmount 0;
		-INVENTORY.KEEPDEPLETED;		
	}
}

//The item tracker for grenade throwing
Class GrenadeThrowPower : SpecialItem 
{
	Default
	{
		Inventory.Amount 1;
		Inventory.MaxAmount 100;
	}
}

//State Jumps
Class GotoReload : SpecialItem {}
//Other
Class Reloading : SpecialItem {}
Class NOAMMO : SpecialItem {}
