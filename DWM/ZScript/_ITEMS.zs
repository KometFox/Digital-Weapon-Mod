//Other
#Include "ZScript/Actor/Items/Aux.zs"
//Items
#Include "ZScript/Actor/Items/Money.zs"
#Include "ZScript/Actor/Items/Items.zs"
#Include "ZScript/Actor/Items/Ammo.zs"
//Decorations
#Include "ZScript/Actor/Decorations/ExplosiveBarrel.zs"
//Health
#Include "ZScript/Actor/Items/Health.zs"
//Armor
#Include "ZScript/Actor/Items/Armor.txt"

Class TestModel : Actor
{
	Default
	{
		Scale 1.0;
	}
	
	States
	{
		Spawn:
			IDLE AA 1;
			Loop;
	
	}


}