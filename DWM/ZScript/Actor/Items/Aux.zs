//Lazy way to disable items.
Class NullItem : Actor
{

	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0;
			Stop;
	}
}

//Ugly hack to enforce items pickup
class RMD_BlankItem : Inventory  //Grosshack
{
	Default
	{
		-COUNTITEM
		Inventory.Amount 1;
		Inventory.MaxAmount 2000000000;

	}
}

Class DebugGun : CustomInventory
{
	Default
	{
		+INVENTORY.AUTOACTIVATE;
	}
	
	States
	{
		Use:
			TNT1 A 0
			{
					A_GiveInventory("RMD_Shells", 9999);
					A_GiveInventory("RMD_SMGBullets", 9999);
					A_GiveInventory("RMD_Fuel", 9999);
					A_GiveInventory("RMD_Cells", 9999);
					A_GiveInventory("RMD_ARBullets", 9999);
					A_GiveInventory("RMD_Grenades", 9999);
					A_GiveInventory("RMD_Rockets", 9999);
					
					A_GiveInventory("CBM3", 1);
			}
	}
}