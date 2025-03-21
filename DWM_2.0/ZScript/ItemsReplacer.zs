//-------------------------------------------------------------------------------
//ItemSpawner 
//-------------------------------------------------------------------------------
Class ItemBag 
{
	string Item;
	float Chance;
	int Amount;
}

Class MultiItemSpawner : Actor
{
	Array<ItemBag> Container;
	

	void AddItem(String Item, float Chance, int Amount)
	{
		ItemBag Bag = New("ItemBag");
		
		Bag.Item = Item;
		Bag.Chance = Chance;
		Bag.Amount = Amount;	
		
		Container.Push(Bag);
	}
	
	bool ProbabilityFloat(Float Chance)
	{
		Chance = Clamp(Chance, 0, 1.0);
		float Coin_ = frandom(0, 1.0);
		float Calculation = 1.0 - Chance;

		if (Chance == 0)
		{
			return false;
		}
			
		if (Coin_ >= Calculation)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	void PassMapStuff(Actor Obj)
	{
		//Variosu special variables that needs to be passed
		//to the item
		Obj.Args[0] = Args[0];
		Obj.Args[1] = Args[1];
		Obj.Args[2] = Args[2];
		Obj.Args[3] = Args[3];
		Obj.Args[4] = Args[4];
		Obj.Special1 = Special1;
		Obj.Special2 = Special2;
		Obj.Specialf1 = Specialf1;
		Obj.Specialf2 = Specialf2;
		Obj.Special = Special;
		Obj.BArgsDefined = BArgsDefined;
		//MTF_SECRET needs special treatment to avoid incrementing the secret counter twice. It had already been processed for the spawner itself.
		Obj.SpawnFlags = SpawnFlags & ~MTF_SECRET;    
		Obj.HandleSpawnFlags();
		//Obj.SpawnFlags = SpawnFlags;
		//"Transfer" count secret flag to spawned actor
		Obj.bCountSecret = SpawnFlags & MTF_SECRET;    
		Obj.ChangeTid(tid);
	}
	
	
	void SpawnItem()
	{
		for (int i = 0; i < Container.size(); i++)
		{
			for (int x = 0; x < Container[i].Amount; x++)
			{
				if (ProbabilityFloat(Container[i].Chance) == true)
				{
					Actor Item;
					Bool Spawned;
					
					[Spawned, Item] = A_SpawnItemEx(Container[i].Item, 0, 0, 0, frandom(-1.2, 1.2), frandom(-1.2, 1.2), frandom(1.0, 4.0));
					
					if (Spawned && Item)
					{
						PassMapStuff(Item);
					}
					
				}
			}
		}
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 2;
			TNT1 A 1 SpawnItem();
			Stop;	
	}
	
}


//-------------------------------------------------------------------------------
//Money Drop Generic Actors 
//TODO: Different items for power ups 
//------------------------------------------------------------------------------
Class MoneyDrop_Small : MultiItemSpawner
{
	override void PostBeginPlay()
	{
		AddItem("RMD_CoinPile", 0.37, 2);
		AddItem("RMD_SilverRing", 0.12, 1);
		AddItem("RMD_SmallPearl", 0.20, 1);

		Super.PostBeginPlay();
	}
}

Class MoneyDrop_Medium : MultiItemSpawner
{
	override void PostBeginPlay()
	{
		AddItem("RMD_GoldGoblet", 0.72, 2);
		AddItem("RMD_CoinPile", 0.30, 2);
		AddItem("RMD_SilverRing", 0.65, 1);

		Super.PostBeginPlay();
	}
}

Class MoneyDrop_Large : MultiItemSpawner
{
	override void PostBeginPlay()
	{
		AddItem("RMD_GoldBar", 0.40, 2);
		AddItem("RMD_LatniumBar", 0.10, 1);
		AddItem("RMD_GoldGoblet", 0.45, 1);
		Super.PostBeginPlay();
	}
}

Class MoneyDrop_VeryLarge : MultiItemSpawner
{
	override void PostBeginPlay()
	{
		AddItem("RMD_Diamond", 1.0, 1);
		AddItem("RMD_GoldBar", 0.20, 2);
		AddItem("RMD_LatniumBar", 0.20, 2);
		Super.PostBeginPlay();
	}
}

//------------------------------------------------------------------------------
//Weapons
//------------------------------------------------------------------------------
Class Chainsaw_Replacer: RandomSpawner Replaces Chainsaw 
{
	Default
	{
		DropItem "RMD_GoldBar", 256, 1;
	}
}

Class Pistol_Replacer : RandomSpawner Replaces Pistol 
{
	Default
	{
		DropItem "RMD_GoldBar", 256, 1;
	}
}

Class Shotgun_Replacer : RandomSpawner Replaces Shotgun 
{
	Default
	{
		DropItem "RMD_GoldBar", 256, 1;
	}
}

Class Chaingun_Replacer : RandomSpawner Replaces Chaingun
{
	Default
	{
		DropItem "RMD_GoldBar", 256, 1;
	}
}


Class SuperShotgun_Replacer : RandomSpawner Replaces SuperShotgun 
{
	Default
	{
		DropItem "RMD_Treasure", 256, 1;
	}
}

Class RocketLauncher_Replacer : RandomSpawner Replaces RocketLauncher 
{
	Default
	{
		DropItem "RMD_Treasure", 256, 1;
	}
}


Class PlasmaRifle_Replacer : RandomSpawner Replaces PlasmaRifle 
{
	Default
	{
		DropItem "RMD_Diamond", 256, 1;
	}
}

Class BFG9000_Replacer : RandomSpawner Replaces BFG9000 
{
	Default
	{
		DropItem "RMD_Diamond", 256, 1;
	}
}



//------------------------------------------------------------------------------
//Ammo
//------------------------------------------------------------------------------
Class ClipReplacer : MoneyDrop_Small replaces Clip {}
Class ClipBoxReplacer : MoneyDrop_Medium replaces ClipBox {}


Class ShellReplacer : MoneyDrop_Small replaces Shell {}
Class ShellBoxReplacer : MoneyDrop_Medium replaces ShellBox {}

Class RocketAmmoReplacer : MoneyDrop_Small replaces RocketAmmo {}
Class RocketBoxReplacer : MoneyDrop_Medium replaces RocketBox {}


Class CellReplacer : MoneyDrop_Small replaces Cell {}
Class CellPackReplacer : MoneyDrop_Medium replaces CellPack {}

//------------------------------------------------------------------------------
//Health
//------------------------------------------------------------------------------
Class Medikit_Replacer : MoneyDrop_Small Replaces Medikit {}

Class Stimpack_Replacer : MoneyDrop_Small Replaces Stimpack {}

Class SoulSphere_Replacer : MoneyDrop_Large Replaces SoulSphere {}


//------------------------------------------------------------------------------
//Armor
//------------------------------------------------------------------------------
Class GreenArmor_Replacer : MoneyDrop_Large Replaces GreenArmor {}

Class BlueArmor_Replacer : MoneyDrop_Large Replaces BlueArmor {}

//------------------------------------------------------------------------------
//Bonus
//------------------------------------------------------------------------------
Class ArmorBonus_Replacer : MoneyDrop_Small Replaces ArmorBonus {}
Class HealthBonus_Replacer : MoneyDrop_Small Replaces HealthBonus {}


//------------------------------------------------------------------------------
//PowerUps
//------------------------------------------------------------------------------
Class BackpackReplacer : MoneyDrop_VeryLarge replaces Backpack {}

Class RadsuitReplacer : RandomSpawner replaces RadSuit 
{

    Default
	{
		DropItem "RMD_NBCSuit", 256, 1;
	}
} 

Class MegasphereReplacer : MoneyDrop_VeryLarge replaces Megasphere {}

Class BlurSphereReplacer : MoneyDrop_VeryLarge replaces BlurSphere {}	

Class InvulnerabilitySphereReplacer : MoneyDrop_VeryLarge replaces InvulnerabilitySphere {}

Class InfraredReplacer : MoneyDrop_Large replaces Infrared {}

Class BerserkReplacer : MoneyDrop_Large replaces Berserk {} 
