//-------------------------------------------------------------------------------
//Ingots
//------------------------------------------------------------------------------
Class Ingots_Small : RandomSpawner 
{
	Default
	{
		Dropitem "IngotA", 256, 10;
		DropItem "IngotB", 256, 5;
	}
}

Class Ingots_Medium : RandomSpawner
{
	Default
	{
		DropItem "IngotB", 256, 8;
		DropItem "IngotC", 256, 5;
	}
}

Class Ingots_Large : RandomSpawner
{
	Default
	{
		DropItem "IngotC", 256, 5;
		DropItem "IngotD", 256, 2;
	}
}

Class Ingots_VeryLarge : RandomSpawner
{
	Default
	{
		DropItem "IngotD", 256, 1;
	}
}

//-------------------------------------------------------------------------------
//Ingot Stacks
//------------------------------------------------------------------------------
Class IngotStacks_VerySmall : RandomSpawner
{
	Default
	{
		DropItem "IngotStackA", 256, 1;
	}
}

Class IngotStacks_Small : RandomSpawner
{
	Default
	{
		DropItem "IngotStackA", 256, 2;
		DropItem "IngotStackB", 256, 5;
	}
}

Class IngotStacks_Medium : RandomSpawner
{
	Default
	{
		DropItem "IngotStackB", 256, 2;
		DropItem "IngotStackC", 256, 5;
	
	}
}

Class IngotStacks_Large : RandomSpawner
{
	Default
	{
		DropItem "IngotStackD", 256, 1;
	}
}

//------------------------------------------------------------------------------
//Weapons
//------------------------------------------------------------------------------
Class Chainsaw_Replacer: RandomSpawner Replaces Chainsaw
{
	Default
	{
		DropItem "IngotStacks_Medium", 256, 1;
	}
}

Class Pistol_Replacer : RandomSpawner Replaces Pistol
{
	Default
	{
		DropItem "IngotStacks_VerySmall", 256, 1;
	}
}

Class Shotgun_Replacer : RandomSpawner Replaces Shotgun
{
	Default
	{
		DropItem "IngotStacks_Small", 256, 1;
	}
}

Class Chaingun_Replacer : RandomSpawner Replaces Chaingun
{
	Default
	{
		DropItem "IngotStacks_Small", 256, 1;
	}
}


Class SuperShotgun_Replacer : RandomSpawner Replaces SuperShotgun
{
	Default
	{
		DropItem "IngotStacks_Medium", 256, 1;
	}
}

Class RocketLauncher_Replacer : RandomSpawner Replaces RocketLauncher
{
	Default
	{
		DropItem "IngotStacks_Medium", 256, 1;
	}
}

Class PlasmaRifle_Replacer : RandomSpawner Replaces PlasmaRifle
{
	Default
	{
		DropItem "IngotStacks_Medium", 256, 1;
	}
}

Class BFG9000_Replacer : RandomSpawner Replaces BFG9000
{
	Default
	{
		DropItem "IngotStacks_Large", 256, 1;
	}
}


//------------------------------------------------------------------------------
//Ammo
//------------------------------------------------------------------------------
Class ClipReplacer : Ingots_Small replaces Clip{}
Class ClipBoxReplacer : IngotStacks_Medium replaces ClipBox{}


Class ShellReplacer : Ingots_Small replaces Shell{}
Class ShellBoxReplacer : IngotStacks_Medium replaces ShellBox{}

Class RocketAmmoReplacer : Ingots_Medium replaces RocketAmmo{}
Class RocketBoxReplacer : IngotStacks_Medium replaces RocketBox{}


Class CellReplacer : Ingots_Medium replaces Cell{}
Class CellPackReplacer : IngotStacks_Large replaces CellPack{}

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
		DropItem "ArmorShard", 256, 1;
	}
}

Class GreenArmor_Replacer : RandomSpawner Replaces GreenArmor 
{
    Default
	{
		DropItem "RMD_GreenArmor", 256, 1;
	}
}

Class BlueArmor_Replacer : RandomSpawner Replaces BlueArmor
{
    Default
	{
		DropItem "RMD_BlueArmor", 256, 1;
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
Class BackpackReplacer : IngotStacks_Large replaces Backpack {}

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
Class BlurSphereReplacer : RandomSpawner replaces BlurSphere
{
	Default
	{
		Dropitem "RMD_Invisibility", 256, 1;
	}
}	

Class InvulnerabilitySphereReplacer : RandomSpawner replaces InvulnerabilitySphere
{
	Default
	{
		Dropitem "RMD_God", 256, 1;
	}
}

Class InfraredReplacer : IngotStacks_Large replaces Infrared {}

/*
Class BerserkReplacer : RandomSpawner replaces Berserk
{
	Default
	{
		DropItem "RMD_AtomHealth", 256, 1;
	}
} 
*/