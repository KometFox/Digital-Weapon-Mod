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
	Color ItemColor;
	//0 = Collision
	//1 = Magnet
	
	Property Money:Money;
	Property MagnetType:MagnetType;
	Property TimeToLife:TTL;
	Property ItemColor:ItemColor;

	Default
	{
		Inventory.PickupMessage "";
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
		+BRIGHT
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
					A_JumpIf(waterlevel >= 1, "CondCheck");
					Angle += 10;
					Pitch += 10;
					Angle += 10;
				}
			}
			IDLE A 0 A_CheckFloor("Death");
			Loop;
			
		Death:
			"####" "#" 1
			{
				Pitch = 0;
				Angle = random(0, 360);
			}
			Goto CondCheck;
	
		
		//Expensive Option
		MagnetLoop:
			"####" "#" 7 A_CheckProximity("Magnet","RMD_Player", 130, 1, CPXF_CHECKSIGHT|CPXF_SETTARGET|CPXF_ANCESTOR);
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
			}
			"####" "#" 1 CheckMagnetType();
			//"####" "#" 1;
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
			"####" "#" 0 A_CheckRange(130, "MagnetLoop");
			Loop;
			
		PickUp:
			TNT1 A 0 A_GiveInventory("Material", Invoker.Money);
			Stop;
		
		Ded:
			TNT1 A 0;
			Stop;
	}
}


Class FloppyDisc : MaterialBase 
{
	Default
	{
		MaterialBase.Money 50;
		MaterialBase.ItemColor "e6e6e6";
	}
}

Class HardDrive : MaterialBase 
{
	Default
	{
		MaterialBase.Money 500;
		MaterialBase.ItemColor "e6e6e6";
	}
}

Class TapeDrive : MaterialBase 
{
	Default
	{
		MaterialBase.Money 10;
		MaterialBase.ItemColor "e6e6e6";
	}
}

Class CDRom : MaterialBase 
{
	Default
	{
		MaterialBase.Money 100;
		MaterialBase.ItemColor "e6e6e6";
	}
}



//------------------------------------------------------------------------------
//Ingot Stacks
//------------------------------------------------------------------------------
Class RMD_IngotStackBase : MaterialBase 
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

Class IngotStackA : RMD_IngotStackBase 
{
	Default
	{
		//Inventory.PickupMessage "Picked up a black hard drive <+10 Data>";
		Inventory.PickupMessage "";
		MaterialBase.Money 50;
		MaterialBase.ItemColor "e6e6e6";
	}
}

Class IngotStackB : RMD_IngotStackBase 
{
	Default
	{
		//Inventory.PickupMessage "Picked up a blue hard drive <+20 Data>";
		Inventory.PickupMessage "";
		MaterialBase.Money 100;
		MaterialBase.ItemColor "e6e6e6";
	}
}

Class IngotStackC : RMD_IngotStackBase 
{
	Default
	{
		//Inventory.PickupMessage "Picked up a yellow hard drive <+50 Data>";
		Inventory.PickupMessage "";
		MaterialBase.Money 200;
		MaterialBase.ItemColor "ef5b0c";
	}
}

Class IngotStackD : RMD_IngotStackBase 
{
	Default
	{
		//Inventory.PickupMessage "Picked up a purple hard drive <+100 Data>";
		Inventory.PickupMessage "";
		MaterialBase.Money 400;
		MaterialBase.ItemColor "14dbff";
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
		Inventory.PickupSound "Items/IngotTake2";
		Inventory.PickupFlash "";
		MaterialBase.Money 0;
		-COUNTITEM;
	}
}


Class IngotA : RMD_IngotBase 
{
	Default
	{
		//Inventory.PickupMessage "Picked up a black floppy <+5 Data>";
		Inventory.PickupMessage "";
		MaterialBase.Money 30;
		MaterialBase.ItemColor "e6e6e6";
	}
}

Class CrystalGreen : RMD_IngotBase 
{
	Default
	{
		MaterialBase.Money 10;
		Inventory.PickupSound "Items/CrystalTake";
		MaterialBase.ItemColor "21e500";
	}

}

Class IngotB : RMD_IngotBase 
{
	Default
	{
		//Inventory.PickupMessage "Picked up a blue floppy <+10 Data>";
		Inventory.PickupMessage "";
		MaterialBase.Money 50;
		MaterialBase.ItemColor "e6e6e6";
	}
}

Class CrystalBlue : RMD_IngotBase 
{
	Default
	{
		MaterialBase.Money 30;
		Inventory.PickupSound "Items/CrystalTake";
		MaterialBase.ItemColor "0005f6";
	}

}


Class IngotC : RMD_IngotBase 
{
	Default
	{
		//Inventory.PickupMessage "Picked up a yellow floppy <+25 Data>";
		Inventory.PickupMessage "";
		MaterialBase.Money 100;
		MaterialBase.ItemColor "ef5b0c";
	}
}

Class CrystalYellow : RMD_IngotBase 
{
	Default
	{
		MaterialBase.Money 50;
		Inventory.PickupSound "Items/CrystalTake";
		MaterialBase.ItemColor "ffa400";
	}

}


Class IngotD : RMD_IngotBase 
{
	Default
	{
		//Inventory.PickupMessage "Picked up a purple floppy <+50 Data>";
		Inventory.PickupMessage "";
		MaterialBase.Money 200;
		MaterialBase.ItemColor "14dbff";
	}
}

Class CrystalPurple : RMD_IngotBase 
{
	Default
	{
		MaterialBase.Money 100;
		Inventory.PickupSound "Items/CrystalTake";
		MaterialBase.ItemColor "bf00ff";
	}

}




