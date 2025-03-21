/*
Used for testing purpose
*/
Class DebugZombiePoint : ZombieMan
{
	Default
	{
		Speed 0;
		DamageFunction 0;
	}

	override void BeginPlay()
	{
		Super.BeginPlay();
		
		Console.PrintF("DebugZombie Pointer: %p", self);
		
		//A_Die();
	}
}


Class DebugZombieNB : ZombieMan
{
	Default
	{
		Speed 0;
		DamageFunction 0;
		Health 1000;
		+NOBLOOD;
	}
}

Class DebugZombie : ZombieMan
{
	Default
	{
		Speed 0;
		DamageFunction 0;
		Health 100;
	}
}