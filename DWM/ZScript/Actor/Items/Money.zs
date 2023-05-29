//------------------------------------------------------------------------------
//Base
//------------------------------------------------------------------------------
Class Material : SpecialItem 
{
	Default
	{
		Inventory.pickupmessage "Money!";
		Inventory.Amount 1;
		Inventory.MaxAmount 2000000000; 
	}
}

Class MaterialBase : CustomInventory 
{
	int Money; //How much money it has
	int TTL;
	bool Temp; //Temporary
	int MagnetType;
	//0 = Collision
	//1 = Magnet
	
	Property Money:Money;
	Property MagnetType:MagnetType;
	Property TimeToLife:TTL;

	Default
	{
		Inventory.PickupMessage "You obtained no data.";
		MaterialBase.Money 0;
		MaterialBase.TimeToLife 3000; //3k Tics
		MaterialBase.MagnetType 0;

		speed 0;
		Gravity 0.6;
		RenderStyle "Normal";
		BounceType "Doom";
		BounceFactor 0.25;
		WallBounceFactor 0.25;
		Alpha 1;
		Mass 500;
		-NOGRAVITY
		+NOTELEPORT
		+FORCEXYBILLBOARD
	}
		
	void SaveMoney()
	{
		let MoneyH = RMD_MoneyHandler(StaticEventHandler.Find('RMD_MoneyHandler'));
		
		MoneyH.SaveMoney();	
	}
	
	Action State CheckMagnetType()
	{
		if (invoker.MagnetType == 0)
		{
			return ResolveState("CollisionLoop");
		}
		
		else if (invoker.MagnetType == 1)
		{
			return ResolveState("MagnetLoop");
		}
		
		return ResolveState("Delay");
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
		bool Picked = Super.TryPickup(toucher);
		
		if (Picked == true)
		{
			SaveMoney();
			return true;
		}
		else
		{
			return false;
		}
		
		return false;
	}
	
	States
	{

		Spawn:
			IDLE A 0;
			IDLE A 1
			{
				//A_SpawnItemEx("RMD_ItemShineSpawner", 0, 0, 0);
			
				if (Invoker.Temp == True)
				{
					A_JumpIf(waterlevel >= 1, "CondCheck");
					Angle += 8;
					Pitch += 8;
				}
			}
			IDLE A 0 A_CheckFloor("Death");
			Loop;
			
		Death:
			"####" "#" 1
			{
				//A_SpawnItemEx("RMD_ItemShineSpawner", 0, 0, 0);
				Pitch = 0;
				Angle = random(0, 360);
			}
			Goto CondCheck;
	
		
		//Expensive Option
		MagnetLoop:
			"####" "#" 1 A_CheckProximity("Magnet","RMD_Player", 130, 1, CPXF_CHECKSIGHT|CPXF_SETTARGET|CPXF_ANCESTOR);
			Goto CondCheck;
		
		//Cheap option
		CollisionLoop:
			"####" "#" 1 
			{
				if (A_RadiusGive("Material", 130, RGF_PLAYERS, Invoker.Money))
				{
					A_StartSound(Invoker.PickupSound);
					
					return ResolveState("Ded");
				}
				
				return ResolveState("Delay");
			}
			Goto CondCheck;


		CondCheck:
			"####" "#" 0
			{			
				//Allow for ingame changes 
				Invoker.MagnetType = CVar.FindCVar("RMDC_MoneyMagnetType").GetInt();
			
				//Angle += 6;		
			}
			"####" "#" 1 CheckMagnetType();
			Loop;
			
		Delay:
			"####" "#" 1;
			Goto CondCheck;
			
		
		
		Magnet:
			"####" "#" 1
			{		
				A_FaceTarget();
				A_recoil(-5.0);
				A_ChangeVelocity (0, 0, frandom(0.4,0.6),CVF_RELATIVE );
			}
			"####" "#" 0 A_CheckRange(130, "CondCheck");
			Loop;
			
		PickUp:
			TNT1 A 0 A_GiveInventory("Material", Invoker.Money);
			Stop;
		
		Ded:
			TNT1 A 0;
			Stop;
	}
}

//------------------------------------------------------------------------------
//Ingot Stacks
//------------------------------------------------------------------------------
Class RMD_EuroBase : MaterialBase 
{
	Default
	{
		Inventory.PickupMessage "";
		Inventory.PickupSound "Items/IngotTake";
		Inventory.PickupFlash "";
		MaterialBase.Money 0;
		+INVENTORY.ALWAYSPICKUP;
	}
	
	override void PostBeginPlay()
	{
		Super.PostBeginPlay();

		//Don't count towards item tally when dropped. 
		//Got some help from Jarewill
		//Notes: Using the "LootBox" weighted roll system I have done causes issues.
		if (bTossed == True || bDropped == True && Temp == True)
		{
			//level.total_items--; 
			bCountItem = False;
		}
		/*
		else 
		{
			level.total_items++;
			bCountItem = True;
		}
		*/
	}
}

Class EuroGreen : RMD_EuroBase 
{
	Default
	{
		//Inventory.PickupMessage "Picked up a black hard drive <+10 Data>";
		Inventory.PickupMessage "";
		MaterialBase.Money 50;
	}
}

Class EuroBlue : RMD_EuroBase 
{
	Default
	{
		//Inventory.PickupMessage "Picked up a blue hard drive <+20 Data>";
		Inventory.PickupMessage "";
		MaterialBase.Money 100;
	}
}

Class EuroYellow : RMD_EuroBase 
{
	Default
	{
		//Inventory.PickupMessage "Picked up a yellow hard drive <+50 Data>";
		Inventory.PickupMessage "";
		MaterialBase.Money 200;
	}
}

Class EuroPurple : RMD_EuroBase 
{
	Default
	{
		//Inventory.PickupMessage "Picked up a purple hard drive <+100 Data>";
		Inventory.PickupMessage "";
		MaterialBase.Money 400;
	}
}


//------------------------------------------------------------------------------
//Ingots
//------------------------------------------------------------------------------
Class RMD_CoinBase : MaterialBase 
{
	Default
	{
		Inventory.PickupMessage "";
		Inventory.PickupSound "Items/IngotTake2";
		Inventory.PickupFlash "";
		MaterialBase.Money 0;
		-COUNTITEM;
	}
}


Class CoinGreen : RMD_CoinBase 
{
	Default
	{
		//Inventory.PickupMessage "Picked up a black floppy <+5 Data>";
		Inventory.PickupMessage "";
		MaterialBase.Money 10;
	}
}

Class CrystalGreen : CoinGreen 
{
	Default
	{
		Inventory.PickupSound "Items/CrystalTake";
	}

}

Class CoinBlue : RMD_CoinBase 
{
	Default
	{
		//Inventory.PickupMessage "Picked up a blue floppy <+10 Data>";
		Inventory.PickupMessage "";
		MaterialBase.Money 30;
	}
}

Class CrystalBlue : CoinBlue 
{
	Default
	{
		Inventory.PickupSound "Items/CrystalTake";
	}

}


Class CoinYellow : RMD_CoinBase 
{
	Default
	{
		//Inventory.PickupMessage "Picked up a yellow floppy <+25 Data>";
		Inventory.PickupMessage "";
		MaterialBase.Money 50;
	}
}

Class CrystalYellow : CoinYellow 
{
	Default
	{
		Inventory.PickupSound "Items/CrystalTake";
	}

}


Class CoinPurple : RMD_CoinBase 
{
	Default
	{
		//Inventory.PickupMessage "Picked up a purple floppy <+50 Data>";
		Inventory.PickupMessage "";
		MaterialBase.Money 100;
	}
}

Class CrystalPurple : CoinPurple 
{
	Default
	{
		Inventory.PickupSound "Items/CrystalTake";
	}

}

