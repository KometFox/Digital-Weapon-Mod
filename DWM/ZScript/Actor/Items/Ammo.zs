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
	Inventory.Amount 10;
	Inventory.MaxAmount 600;
	Ammo.BackpackAmount 0;
	Ammo.BackpackMaxAmount 600;
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
	Inventory.PickupMessage "You picked up some Pistol bullets.";
	Inventory.Amount 20;
	Inventory.MaxAmount 4000;
	Ammo.BackpackAmount 0;
	Ammo.BackpackMaxAmount 4000;
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


Class RMD_SMGBullets : Ammo 
{
	Default
	{
	Inventory.PickupMessage "You picked up some Submachine Gun bullets.";
	Inventory.Amount 20;
	Inventory.MaxAmount 5000;
	Ammo.BackpackAmount 0;
	Ammo.BackpackMaxAmount 5000;
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

Class RMD_ARBullets : Ammo 
{
	Default
	{
	Inventory.PickupMessage "You picked up some Assault Rifle bullets.";
	Inventory.Amount 20;
	Inventory.MaxAmount 4000;
	Ammo.BackpackAmount 0;
	Ammo.BackpackMaxAmount 4000;
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

Class RMD_MGBullets : Ammo 
{
	Default
	{
	Inventory.PickupMessage "You picked up some Machine Gun bullets.";
	Inventory.Amount 20;
	Inventory.MaxAmount 4000;
	Ammo.BackpackAmount 0;
	Ammo.BackpackMaxAmount 4000;
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
	Inventory.MaxAmount 500;
	Ammo.BackpackAmount 0;
	Ammo.BackpackMaxAmount 500;
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
Class RMD_Grenades : Ammo 
{
	Default
	{
	Inventory.PickupMessage "You picked up a Grenade.";
	Inventory.Amount 1;
	Inventory.MaxAmount 300;
	Ammo.BackpackAmount 0;
	Ammo.BackpackMaxAmount 300;
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

Class RMD_Rockets : Ammo 
{
	Default
	{
	Inventory.PickupMessage "You picked up a Rocket.";
	Inventory.Amount 1;
	Inventory.MaxAmount 100;
	Ammo.BackpackAmount 0;
	Ammo.BackpackMaxAmount 100;
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
	Inventory.MaxAmount 4000;
	Ammo.BackpackAmount 0;
	Ammo.BackpackMaxAmount 4000;
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

