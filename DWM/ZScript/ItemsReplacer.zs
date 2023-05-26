//-------------------------------------------------------------------------------
//Floppies
//------------------------------------------------------------------------------
Class FloppySpawn_Small : RandomSpawner 
{
	Default
	{
		Dropitem "CoinGreen", 256, 10;
		DropItem "CoinBlue", 256, 5;
	}
}

Class FloppySpawn_Medium : RandomSpawner
{
	Default
	{
		DropItem "CoinBlue", 256, 8;
		DropItem "CoinYellow", 256, 5;
		DropItem "CoinGreen", 256, 1;
	}
}

Class FloppySpawn_Large : RandomSpawner
{
	Default
	{
		DropItem "CoinYellow", 256, 5;
		DropItem "CoinPurple", 256, 2;
	}
}

Class FloppySpawn_VeryLarge : RandomSpawner
{
	Default
	{
		DropItem "CoinPurple", 256, 1;
	}
}

//-------------------------------------------------------------------------------
//Hard Drive
//------------------------------------------------------------------------------
Class HardDriveSpawn_VerySmall : RandomSpawner
{
	Default
	{
		DropItem "EuroGreen", 256, 1;
	}
}

Class HardDriveSpawn_Small : RandomSpawner
{
	Default
	{
		DropItem "EuroGreen", 256, 2;
		DropItem "EuroBlue", 256, 5;
	}
}

Class HardDriveSpawn_Medium : RandomSpawner
{
	Default
	{
		DropItem "EuroBlue", 256, 2;
		DropItem "EuroYellow", 256, 5;
	
	}
}

Class HardDriveSpawn_Large : RandomSpawner
{
	Default
	{
		DropItem "EuroPurple", 256, 1;
	}
}

//------------------------------------------------------------------------------
//Weapons
//------------------------------------------------------------------------------
Class Chainsaw_Replacer: RandomSpawner Replaces Chainsaw
{
	Default
	{
		DropItem "HardDriveSpawn_Small", 256, 1;
	}
}

Class Pistol_Replacer : RandomSpawner Replaces Pistol
{
	Default
	{
		DropItem "HardDriveSpawn_VerySmall", 256, 1;
	}
}

Class Shotgun_Replacer : RandomSpawner Replaces Shotgun
{
	Default
	{
		DropItem "HardDriveSpawn_VerySmall", 256, 1;
	}
}

Class Chaingun_Replacer : RandomSpawner Replaces Chaingun
{
	Default
	{
		DropItem "HardDriveSpawn_VerySmall", 256, 1;
	}
}


Class SuperShotgun_Replacer : RandomSpawner Replaces SuperShotgun
{
	Default
	{
		DropItem "HardDriveSpawn_Medium", 256, 1;
	}
}

Class RocketLauncher_Replacer : RandomSpawner Replaces RocketLauncher
{
	Default
	{
		DropItem "HardDriveSpawn_Medium", 256, 1;
	}
}

Class PlasmaRifle_Replacer : RandomSpawner Replaces PlasmaRifle
{
	Default
	{
		DropItem "HardDriveSpawn_Medium", 256, 1;
	}
}

Class BFG9000_Replacer : RandomSpawner Replaces BFG9000
{
	Default
	{
		DropItem "HardDriveSpawn_Large", 256, 1;
	}
}


//------------------------------------------------------------------------------
//Ammo
//------------------------------------------------------------------------------
Class ClipReplacer : FloppySpawn_Small replaces Clip{}
Class ClipBoxReplacer : FloppySpawn_Medium replaces ClipBox{}


Class ShellReplacer : FloppySpawn_Small replaces Shell{}
Class ShellBoxReplacer : FloppySpawn_Medium replaces ShellBox{}

Class RocketAmmoReplacer : FloppySpawn_Medium replaces RocketAmmo{}
Class RocketBoxReplacer : FloppySpawn_Medium replaces RocketBox{}


Class CellReplacer : FloppySpawn_Large replaces Cell{}
Class CellPackReplacer : FloppySpawn_VeryLarge replaces CellPack{}

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
Class BackpackReplacer : HardDriveSpawn_Large replaces Backpack {}

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

Class InfraredReplacer : HardDriveSpawn_Large replaces Infrared {}

Class BerserkReplacer : RandomSpawner replaces Berserk
{
	Default
	{
		DropItem "RMD_AtomHealth", 256, 1;
	}
} 