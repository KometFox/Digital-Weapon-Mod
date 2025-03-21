//------------------------------------------------------------------------------
//Base
//------------------------------------------------------------------------------
Class Material : SpecialItem 
{
	Default
	{
		Inventory.pickupmessage "Money!";
		Inventory.Amount 1;
		Inventory.MaxAmount 10000000; 
	}
}

Class MaterialBase : CustomInventory 
{
	int Money; //How much money it has
	int TTL;
	bool Temp; //Temporary
	Color ItemColor;

	const RG_FLAGS = RGF_PLAYERS;


	Property Money:Money;
	Property TimeToLife:TTL;
	Property ItemColor:ItemColor;

	Default
	{
		Inventory.PickupMessage "";
		Inventory.PickupSound "Items/MoneyTake";
		Inventory.PickupFlash "";
		MaterialBase.Money 0;
		MaterialBase.TimeToLife TICRATE * 45;

		speed 0;
		Gravity 0.6;
		RenderStyle "Normal";
		BounceType "Doom";
		BounceFactor 0.25;
		WallBounceFactor 0.25;
		Alpha 1;
		Mass 500;
		-NOGRAVITY
		+BRIGHT
		+NOTELEPORT
		+FORCEXYBILLBOARD
		+COUNTITEM
		+INVENTORY.ALWAYSPICKUP;
	}
			
	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
	
		Angle = Random(0, 360);
	}
	
	override void Tick()
	{
		Super.Tick();
		
		//Make dropped Money not last forever
		if (!isFrozen())
		{
			if (Temp == True)
			{
				TTL--;
			
			
				//Fadeout effect
				if (TTL <= 10)
				{
					A_FadeOut(0.1);
				}
			
				//When timer runs out, just die.
				if (TTL <= 0)
				{
					Die(self, self);
				}
			}
		}
	}
	
	override bool TryPickup(in out Actor toucher)
	{
		let MoneyH = RMD_MoneyHandler(StaticEventHandler.Find('RMD_MoneyHandler'));
		MoneyH.SaveMoney();
		
		Toucher.A_GiveInventory("Material", Money);
		
		return Super.TryPickup(toucher);
	}
	
	States
	{

		Spawn:
			IDLE A 0 NoDelay 
			{
				
				//Actor Flare;		
				//Flare = Spawn("FX_ItemShineFlare", Pos, ALLOW_REPLACE);
						
				//If (Flare)
				//{
				//	Flare.Target = Self;
				//	Flare.Scale = (0.85, 0.85);
				//	Flare.SetShade(Invoker.ItemColor);	
				//}
			
			}
			Goto Spawn2;

		Spawn2:
			IDLE A 0;
			IDLE A 1
			{			
				if (Invoker.Temp == True)
				{
					A_JumpIf(waterlevel >= 1, "Idle");
					Angle += 10;
					Pitch += 10;
					Angle += 10;
				}
			}
			IDLE A 0 A_CheckFloor("Ground");
			Loop;
			
		Ground:
			"####" "#" 1
			{
				Pitch = 0;
				Angle = random(0, 360);
			}
			Goto Idle;
	
		
		Idle:
			"####" "#" 1;
			"####" "#" 1
			{
				
			
				if (A_RadiusGive("Material", 60, RG_FLAGS, Invoker.Money))
				{
					A_PlaySound(Invoker.PickupSound, 0, 0.75);
					Return ResolveState("Null");
				}
			
				Return ResolveState("Idle");
			}
			Loop;
	}
}


Class RMD_Diamond : MaterialBase 
{
	Default
	{
		MaterialBase.Money 1000;
		MaterialBase.ItemColor "e6e6e6";
		Inventory.pickupmessage "Diamond! +1000C";
	}
}

Class RMD_Treasure : MaterialBase 
{
	Default
	{
		MaterialBase.Money 400;
		MaterialBase.ItemColor "e6e6e6";
		Inventory.pickupmessage "Treasure! +400C";
	}
}

Class RMD_LatniumBar : MaterialBase 
{
	Default
	{
		MaterialBase.Money 500;
		MaterialBase.ItemColor "e6e6e6";
		Inventory.pickupmessage "Latnium Bar! +500C";
	}
}

Class RMD_GoldBar : MaterialBase 
{
	Default
	{
		MaterialBase.Money 100;
		MaterialBase.ItemColor "e6e6e6";
		Inventory.pickupmessage "Gold bar +100c";
	}
}

Class RMD_GoldGoblet : MaterialBase 
{
	Default
	{
		MaterialBase.Money 50;
		MaterialBase.ItemColor "e6e6e6";
		Inventory.pickupmessage "Gold Goblet +50C";
	}
}

Class RMD_CoinPile : MaterialBase 
{
	Default
	{
		MaterialBase.Money 10;
		MaterialBase.ItemColor "e6e6e6";
		Inventory.pickupmessage "Coin pile +10C";
	}
}

Class RMD_SmallPearl : MaterialBase 
{
	Default
	{
		MaterialBase.Money 15;
		MaterialBase.ItemColor "e6e6e6";
		Inventory.pickupmessage "Small Pearl +15C";
	}
}

Class RMD_SilverRing : MaterialBase 
{
	Default
	{
		MaterialBase.Money 25;
		MaterialBase.ItemColor "e6e6e6";
		Inventory.pickupmessage "Silver Ring +25C";
	}
}


//------------------------------------------------------------------------------
//Ingots
//------------------------------------------------------------------------------
Class RMD_IngotBase : MaterialBase 
{
	Default
	{
		Inventory.PickupMessage "";
		Inventory.PickupSound "Items/MoneyTake";
		Inventory.PickupFlash "";
		MaterialBase.Money 0;
		-COUNTITEM;
	}
}


Class RMD_PurpleCrystal : RMD_IngotBase 
{
	Default
	{
		MaterialBase.Money 300;
		MaterialBase.ItemColor "ffa400";
		Inventory.pickupmessage "Purple Crystal +250C";
	}
}


Class RMD_BlueCrystal : RMD_IngotBase 
{
	Default
	{
		MaterialBase.Money 100;
		MaterialBase.ItemColor "21e500";
		Inventory.pickupmessage "Blue Crystal +80C";
	}
}

Class RMD_GreenCrystal : RMD_IngotBase 
{
	Default
	{
		MaterialBase.Money 30;
		MaterialBase.ItemColor "0005f6";
		Inventory.pickupmessage "Green Crystal +30C";
	}

}

Class RMD_YellowCrystal : RMD_IngotBase 
{
	Default
	{
		MaterialBase.Money 12;
		MaterialBase.ItemColor "bf00ff";
		Inventory.pickupmessage "Yellow Crystal +12C";
	}

}




