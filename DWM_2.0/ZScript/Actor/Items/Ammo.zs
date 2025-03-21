/*
The Actors for Ammo items.
TODO: Max Amount is currently set to a large number, decrease it to a smaller
value once macros for purchasing ammo is done. 
*/
Class RMD_BlueMana : Ammo 
{
	Default
	{
	Inventory.PickupMessage "Collected mana spheres";
	Inventory.Amount 1;
	Inventory.MaxAmount 1000;
	Ammo.BackpackAmount 0;
	Ammo.BackpackMaxAmount 10000;
	Inventory.Icon "BMANA0";
	+INVENTORY.UNDROPPABLE;
	+INVENTORY.UNCLEARABLE;
	}
	
	States
	{
	Spawn:
		APAM A -1;
		Stop;
	}
}


Class RMD_HealthAmmo : Ammo 
{
	Default
	{
	Inventory.PickupMessage "You picked up some Health (Ammo).";
	Inventory.Amount 1;
	Inventory.MaxAmount 3;
	Ammo.BackpackAmount 0;
	Ammo.BackpackMaxAmount 3;
	Inventory.Icon "BMANA0";
	+INVENTORY.UNDROPPABLE;
	+INVENTORY.UNCLEARABLE;
	}
	
	States
	{
	Spawn:
		APAM A -1;
		Stop;
	}
}

//------------------------------------------------------------------------------
//Bullets
//------------------------------------------------------------------------------
Class RMD_PistolBullets : Ammo 
{
	Default
	{
	Inventory.PickupMessage "You picked up some pistol bullets.";
	Inventory.Amount 20;
	Inventory.MaxAmount 2000;
	Ammo.BackpackAmount 0;
	Ammo.BackpackMaxAmount 2000;
	Inventory.Icon "BMANA0";
	+INVENTORY.UNDROPPABLE;
	+INVENTORY.UNCLEARABLE;
	}
	
	States
	{
	Spawn:
		APAM A -1;
		Stop;
	}
}

Class RMD_MediumBullets : Ammo 
{
	Default
	{
	Inventory.PickupMessage "You picked up some medium bullets.";
	Inventory.Amount 20;
	Inventory.MaxAmount 2000;
	Ammo.BackpackAmount 0;
	Ammo.BackpackMaxAmount 2000;
	Inventory.Icon "BMANA0";
	+INVENTORY.UNDROPPABLE;
	+INVENTORY.UNCLEARABLE;
	}
	
	States
	{
	Spawn:
		APAM A -1;
		Stop;
	}
}

//------------------------------------------------------------------------------
//Shells
//------------------------------------------------------------------------------
Class RMD_Shells : Ammo 
{
	Default
	{
	Inventory.PickupMessage "You picked up some Shells.";
	Inventory.Amount 10;
	Inventory.MaxAmount 400;
	Ammo.BackpackAmount 0;
	Ammo.BackpackMaxAmount 400;
	Inventory.Icon "BMANA0";
	+INVENTORY.UNDROPPABLE;
	+INVENTORY.UNCLEARABLE;
	}
	
	States
	{
	Spawn:
		APAM A -1;
		Stop;
	}
}

//------------------------------------------------------------------------------
//Explosives
//------------------------------------------------------------------------------
Class RMD_Explosives : Ammo 
{
	Default
	{
	Inventory.PickupMessage "You picked up a Grenade.";
	Inventory.Amount 1;
	Inventory.MaxAmount 200;
	Ammo.BackpackAmount 0;
	Ammo.BackpackMaxAmount 200;
	Inventory.Icon "BMANA0";
	+INVENTORY.UNDROPPABLE;
	+INVENTORY.UNCLEARABLE;
	}
	
	States
	{
	Spawn:
		APAM A -1;
		Stop;
	}
}

Class RMD_Cells : Ammo 
{
	Default
	{
	Inventory.PickupMessage "You picked up some Cells.";
	Inventory.Amount 1;
	Inventory.MaxAmount 2000;
	Ammo.BackpackAmount 0;
	Ammo.BackpackMaxAmount 2000;
	Inventory.Icon "AMMOCELL";
	+INVENTORY.UNDROPPABLE;
	+INVENTORY.UNCLEARABLE;
	}
	
	States
	{
	Spawn:
		APAM A -1;
		Stop;
	}
}

Class RMD_Fuel : Ammo 
{
	Default
	{
	Inventory.PickupMessage "You picked up some Fuel.";
	Inventory.Amount 1;
	Inventory.MaxAmount 2000;
	Ammo.BackpackAmount 0;
	Ammo.BackpackMaxAmount 2000;
	Inventory.Icon "AMMOCELL";
	+INVENTORY.UNDROPPABLE;
	+INVENTORY.UNCLEARABLE;
	}
	
	States
	{
	Spawn:
		APAM A -1;
		Stop;
	}
}

