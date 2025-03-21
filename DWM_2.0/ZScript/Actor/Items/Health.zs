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
			//Player.HRegenAmount += Amount;
			
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
//Random Spawner
//------------------------------------------------------------------------------
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

//------------------------------------------------------------------------------
//Health Inventory Items 
//------------------------------------------------------------------------------
Class BaseHealthItem : HealthPickup
{
	int MaxHeal;

	property MaxHeal:MaxHeal;

	Default
	{
		//Some default flags
		+INVENTORY.INVBAR;
		+FLOORCLIP;
		BaseHealthItem.MaxHeal 100;
		Inventory.Amount 1;
		Inventory.PickupSound "pickups/flask";
	}
		
	override bool Use (bool pickup)
	{
		//Setup the variable and do some casting
		let Item = RMD_ProgHeal(Spawn("RMD_ProgHeal"));
		
		
		//Some basic check
		if (Owner.Health >= MaxHeal || 
			Owner.FindInventory("RMD_ProgHeal"))
		{
			Item.Destroy();
			return false;
		}
		
		if (Item)
		{
			//Give the actual progressive health item	
			Item.Amount = Health;
			Item.MaxHeal = MaxHeal;		
			Item.Touch(Owner);
			
			return true;
		}
		
		//Destroy the object
		Item.Destroy();
		return false;
	}


}


class RMD_ProgHeal : PowerUp
{
	int MaxHeal;
	int AmountGiven; 
	
	property MaxHeal:MaxHeal;
	
	Default
	{
		-COUNTITEM
		RMD_ProgHeal.MaxHeal 100;
		Inventory.Amount 0;
		Inventory.MaxAmount 1;
		Inventory.PickupMessage "";
		Inventory.PickupSound "";
		PowerUp.Duration 1;
	}
	
	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		
		EffectTics = EffectTics * Amount;
	}
	
	override void DoEffect()
	{
		if (!Owner)
			return;

		if (Owner.Health <= MaxHeal)
		{
			//Stop doing anything when there is nothing left to give
			if (Amount <= 0)
			{
				Owner.TakeInventory("RMD_ProgHeal", 1000);
				return;
			}

			int ToGive = 3;
			
			//Do some magic number calculation because else there is a case
			//2 units of HP gets given too much. 
			if (Amount <= 2)
			{
				ToGive = 1;
			}			
			
			int ToHeal = Owner.Health + ToGive;

			Amount -= ToGive;

			Owner.A_SetHealth(ToHeal);
			Owner.Health = clamp(Owner.Health, 1, MaxHeal);
		}
		
	}
		
	States
	{
		Spawn:
			IDLE A 0;
			Stop;
	}	
}


Class RMD_HPVial : BaseHealthItem 
{
	Default
	{
		//Scale 0.75
		Inventory.Amount 1;
		Inventory.MaxAmount 12;
		Inventory.InterhubAmount 12;
		BaseHealthItem.MaxHeal 200;
		Health 50;
		Inventory.PickupMessage "Picked up a Health Vial";
		Inventory.UseSound "Items/Potion";
		Inventory.Icon "ITHPVL";
		Tag "Health Vial +50 HP (200 Max)";
	}
}

Class RMD_HPPotentVial : BaseHealthItem 
{
	Default
	{
		//Scale 0.75
		Inventory.Amount 1;
		Inventory.MaxAmount 6;
		Inventory.InterhubAmount 6;
		BaseHealthItem.MaxHeal 200;
		Health 200;
		Inventory.PickupMessage "Picked up a Potent Health Vial";
		Inventory.UseSound "Items/Potion";
		Inventory.Icon "ITPHPVL";
		Tag "Potent Health Vial +200 (200)";
	}
}


Class RMD_HPMediKit : BaseHealthItem 
{
	Default
	{
		//Scale 0.75
		Inventory.Amount 1;
		Inventory.MaxAmount 20;
		Inventory.InterhubAmount 20;
		BaseHealthItem.MaxHeal 100;
		Health 100;
		Inventory.PickupMessage "Picked up a Medikit";
		Inventory.UseSound "Items/Potion";
		Inventory.Icon "ITHPMED";
		Tag "Medikit +100 HP (100 Max)";
	}
}

Class RMD_HPKeg : BaseHealthItem 
{
	Default
	{
		//Scale 0.75
		Inventory.Amount 1;
		Inventory.MaxAmount 3;
		Inventory.InterhubAmount 3;
		BaseHealthItem.MaxHeal 500;
		Health 500;
		Inventory.PickupMessage "Picked up a Health Keg";
		Inventory.UseSound "Items/Potion";
		Inventory.Icon "ITHPKEG";
		Tag "Health Keg +500 HP (500 Max)";
	}
}




