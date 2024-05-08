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
	
	void SpawnItem()
	{
		for (int i = 0; i < Container.size(); i++)
		{
			for (int x = 0; x < Container[i].Amount; x++)
			{
				if (ProbabilityFloat(Container[i].Chance) == true)
				{
					A_SpawnItemEx(Container[i].Item, 0, 0, 0, frandom(-1, 1), frandom(-1, 1), frandom(-1, 1));
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
		AddItem("TapeDrive", 0.75, 3);		
		
		Super.PostBeginPlay();
	}

}

Class MoneyDrop_Medium : MultiItemSpawner
{
	override void PostBeginPlay()
	{
		AddItem("TapeDrive", 0.35, 3);
		AddItem("CDRom", 0.85, 1);
		
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
		DropItem "HardDrive", 256, 1;
	}
}

Class Pistol_Replacer : RandomSpawner Replaces Pistol
{
	Default
	{
		DropItem "HardDrive", 256, 1;
	}
}

Class Shotgun_Replacer : RandomSpawner Replaces Shotgun
{
	Default
	{
		DropItem "HardDrive", 256, 1;
	}
}

Class Chaingun_Replacer : RandomSpawner Replaces Chaingun
{
	Default
	{
		DropItem "HardDrive", 256, 1;
	}
}


Class SuperShotgun_Replacer : RandomSpawner Replaces SuperShotgun
{
	Default
	{
		DropItem "HardDrive", 256, 1;
	}
}

Class RocketLauncher_Replacer : RandomSpawner Replaces RocketLauncher
{
	Default
	{
		DropItem "HardDrive", 256, 1;
	}
}

Class PlasmaRifle_Replacer : RandomSpawner Replaces PlasmaRifle
{
	Default
	{
		DropItem "HardDrive", 256, 1;
	}
}

Class BFG9000_Replacer : RandomSpawner Replaces BFG9000
{
	Default
	{
		DropItem "HardDrive", 256, 1;
	}
}


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
		DropItem "RMD_Medikit", 256, 1;
	}
}

Class Stimpack_Replacer : RandomSpawner Replaces Stimpack 
{
	Default
	{
		DropItem "RMD_Stimpack", 256, 1;
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
Class ArmorBonus_Replacer : RandomSpawner Replaces ArmorBonus
{
    Default
	{
		DropItem "RMD_Milk", 256, 1;
	}
}

Class GreenArmor_Replacer : RandomSpawner Replaces GreenArmor 
{
    Default
	{
		DropItem "HardDrive", 256, 1;
	}
}

Class BlueArmor_Replacer : RandomSpawner Replaces BlueArmor
{
    Default
	{
		DropItem "HardDrive", 256, 1;
	}
}

//------------------------------------------------------------------------------
//Bonus
//------------------------------------------------------------------------------
Class HealthBonus_Replacer : RandomSpawner Replaces HealthBonus 
{
    Default
	{
		DropItem "RMD_Milk", 256, 1;
	}
}


//------------------------------------------------------------------------------
//PowerUps
//------------------------------------------------------------------------------
Class BackpackReplacer : Chaingun_Replacer replaces Backpack {}

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
Class BlurSphereReplacer : Chaingun_Replacer replaces BlurSphere {}	

Class InvulnerabilitySphereReplacer : RandomSpawner replaces InvulnerabilitySphere
{
	Default
	{
		Dropitem "RMD_God", 256, 1;
	}
}

Class InfraredReplacer : Chaingun_Replacer replaces Infrared {}

Class BerserkReplacer : Chaingun_Replacer replaces Berserk {} 
