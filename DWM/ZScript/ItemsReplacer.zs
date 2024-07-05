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
		Obj.Args[0] = Args[0];
		Obj.Args[1] = Args[1];
		Obj.Args[2] = Args[2];
		Obj.Args[3] = Args[3];
		Obj.Args[4] = Args[4];
		Obj.BArgsDefined = BArgsDefined;
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
					
					[Spawned, Item] = A_SpawnItemEx(Container[i].Item, 0, 0, 0, frandom(-2.0, 2.0), frandom(-2.0, 2.0), frandom(1.0, 4.0));
					
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
//Ingots
//------------------------------------------------------------------------------
Class MoneyDrop_Small : MultiItemSpawner
{
	override void PostBeginPlay()
	{
		AddItem("TapeDrive", 0.33, 2);	
		AddItem("CDRom", 0.5, 1);
		AddItem("FloppyDisc", 0.75, 2);
		AddItem("GraphicCardT2", 0.33, 1);
		AddItem("Motherboard", 0.15, 1);
		AddItem("Harddrive", 0.17, 1);
		
		Super.PostBeginPlay();
	}

}

Class MoneyDrop_Medium : MultiItemSpawner
{
	override void PostBeginPlay()
	{
		AddItem("CDRom", 0.75, 1);
		AddItem("GraphicCardT2", 0.5, 1);
		AddItem("PowerSupply", 0.2, 1);
		AddItem("GraphicCardT5", 0.05, 1);
		AddItem("Motherboard", 0.33, 1);
		
		Super.PostBeginPlay();
	}
}

Class MoneyDrop_Large : MultiItemSpawner
{
	override void PostBeginPlay()
	{
		AddItem("CDRom", 0.25, 3);
		AddItem("GraphicCardT2", 0.35, 2);
		AddItem("PowerSupply", 0.4, 1);
		AddItem("GraphicCardT5", 0.25, 1);
		AddItem("Motherboard", 0.45, 1);
		
		Super.PostBeginPlay();
	}
}

//------------------------------------------------------------------------------
//Weapons
//------------------------------------------------------------------------------
Class Chainsaw_Replacer: MoneyDrop_Large Replaces Chainsaw {}

Class Pistol_Replacer : MoneyDrop_Large Replaces Pistol {}

Class Shotgun_Replacer : MoneyDrop_Large Replaces Shotgun {}

Class Chaingun_Replacer : MoneyDrop_Large Replaces Chaingun {}

Class SuperShotgun_Replacer : RandomSpawner Replaces SuperShotgun {}

Class RocketLauncher_Replacer : MoneyDrop_Large Replaces RocketLauncher {}

Class PlasmaRifle_Replacer : MoneyDrop_Large Replaces PlasmaRifle {}

Class BFG9000_Replacer : MoneyDrop_Large Replaces BFG9000 {}


//------------------------------------------------------------------------------
//Ammo
//------------------------------------------------------------------------------
Class ClipReplacer : MoneyDrop_Small replaces Clip{}
Class ClipBoxReplacer : MoneyDrop_Medium replaces ClipBox{}


Class ShellReplacer : MoneyDrop_Small replaces Shell{}
Class ShellBoxReplacer : MoneyDrop_Medium replaces ShellBox{}

Class RocketAmmoReplacer : MoneyDrop_Small replaces RocketAmmo{}
Class RocketBoxReplacer : MoneyDrop_Medium replaces RocketBox{}


Class CellReplacer : MoneyDrop_Small replaces Cell{}
Class CellPackReplacer : MoneyDrop_Medium replaces CellPack{}

//------------------------------------------------------------------------------
//Health
//------------------------------------------------------------------------------
Class Medikit_Replacer : RandomSpawner Replaces Medikit 
{
	Default
	{
		DropItem "RMD_Beef", 256, 6;
		DropItem "RMD_Fishmeat", 256, 6;
		DropItem "RMD_Medikit", 256, 4;
	}
}

Class Stimpack_Replacer : RandomSpawner Replaces Stimpack 
{
    Default
	{
		DropItem "RMD_Beef", 256, 6;
		DropItem "RMD_Fishmeat", 256, 6;
		DropItem "RMD_Stimpack", 256, 4;
	}
}


Class SoulSphere_Replacer : RandomSpawner Replaces SoulSphere 
{
    Default
	{
		DropItem "RMD_Healthkeg", 256, 1;
	}
}
//------------------------------------------------------------------------------
//Armor
//------------------------------------------------------------------------------
Class GreenArmor_Replacer : MoneyDrop_Medium Replaces GreenArmor {}

Class BlueArmor_Replacer : MoneyDrop_large Replaces BlueArmor {}

//------------------------------------------------------------------------------
//Bonus
//------------------------------------------------------------------------------
Class HealthBonus_Replacer : RandomSpawner Replaces HealthBonus 
{
    Default
	{
		DropItem "RMD_Milk", 256, 10;
		DropItem "RMD_Baltika3", 256, 4;
		DropItem "RMD_Stimpack", 256, 4;
		DropItem "RMD_Beef", 256, 3;
		DropItem "RMD_Fishmeat", 256, 3;
	}
}

Class ArmorBonus_Replacer : RandomSpawner Replaces ArmorBonus
{
    Default
	{
		DropItem "RMD_Milk", 256, 10;
		DropItem "RMD_Baltika3", 256, 3;
		DropItem "RMD_Stimpack", 256, 4;
		DropItem "RMD_Beef", 256, 5;
		DropItem "RMD_Fishmeat", 256, 3; 
	}
}



//------------------------------------------------------------------------------
//PowerUps
//------------------------------------------------------------------------------
Class BackpackReplacer : MoneyDrop_Large replaces Backpack {}

Class RadsuitReplacer : RandomSpawner replaces RadSuit 
{

    Default
	{
		DropItem "RMD_NBCSuit", 256, 1;
	}
} 

Class MegasphereReplacer : RandomSpawner replaces Megasphere
{
	Default
	{
		DropItem "RMD_SuperKeg", 256, 1;
	}
}

//TODO different items for those 
Class BlurSphereReplacer : MoneyDrop_Large replaces BlurSphere {}	

Class InvulnerabilitySphereReplacer : RandomSpawner replaces InvulnerabilitySphere
{
	Default
	{
		Dropitem "RMD_God", 256, 1;
	}
}

Class InfraredReplacer : MoneyDrop_Large replaces Infrared {}

Class BerserkReplacer : MoneyDrop_Large replaces Berserk {} 
