//Lifted from Unreal RPG mod
Class URPG_RicochetEffect : RMD_ParticleSpawner
{
	const PARTICLE_FLAGS = SXF_TRANSFERTRANSLATION | SXF_USEBLOODCOLOR | SXF_NOCHECKPOSITION | SXF_TRANSFERPOINTERS;

	Default
	{
		+NOBLOCKMAP
		+NOGRAVITY
		+ALLOWPARTICLES
		+ZDOOMTRANS
		+NoExtremeDeath
		-NOINTERACTION
		-BLOODLESSIMPACT 
		
	}
	
	States
	{
	
	Spawn:
		TNT1 A 0;
		TNT1 A 0
		{
			//The Actors
			bool Bool_Sparky;
			Actor Sparky;
			bool Bool_BulletFlare;
			Actor BulletFlare;
				
			Actor USparks1, USparks2;	
			
			[Bool_Sparky, Sparky] = A_SpawnItemEx("U_Spark", flags: PARTICLE_FLAGS);
			[Bool_BulletFlare, BulletFlare] = A_SpawnItemEx("U_BulletFlare", flags: PARTICLE_FLAGS);
		
			if (Bool_BulletFlare)
			{
				BulletFlare.SetShade("khaki");
				BulletFlare.Scale = (0.17, 0.17);
			}	
			
			Sparky.SetShade("ffcc7d");
			
			let CVARS = RMD_CVARHandler(StaticEventHandler.Find('RMD_CVARHandler'));
			int CVAR_LowQuality = CVARS.RMDV_ParticleLowQuality;;
		
			if (CVAR_LowQuality == 1)
			{
				Return;
			}
	
			for (int i = 0; i < 6; i++)
			{
				USparks1 = A_SpawnProjectile("URPG_Sparks", 2, 0, frandom(0,1)*frandom (0, 360), 2, frandom (30, 360));
				
				if (USparks1)
				{
					USparks1.SetShade("fdd9c5");
				}
			}
		
			for (int i = 0; i < 6; i++)
			{
				Actor USparks2;
				USparks2 = A_SpawnProjectile("URPG_Sparks", 2, 0, frandom(0,1)*frandom (0, 360), 2, frandom (30, 360));
				
				if (USparks2)
				{
					USparks2.SetShade("ff8330");
				}
			}		
		
			for (int i = 0; i < 5; ++i)
			{
				Vector3 PVel = (FRandom[FX](-2.5, 2.5), FRandom[FX](-2.5, 2.5), FRandom[FX](1.2, 4.0)).unit()*FRandom[FX](1.0, 3.0);
				Vector3 RPos = (frandom(-3, 3), frandom(-3, 8), frandom(-1, 1));
				let Particle = Spawn("U_BulletSmoke", Pos + RPos);
					
				Particle.Vel = PVel;
				Particle.Scale = (0.045, 0.045);
			}
		
		}	
		Stop;
	}
}

Class URPG_FleshImpact : RMD_ParticleSpawner
{
	const PARTICLE_FLAGS = SXF_TRANSFERTRANSLATION | SXF_USEBLOODCOLOR | SXF_NOCHECKPOSITION | SXF_TRANSFERPOINTERS;

	Default
	{
		+NOBLOCKMAP
		+NOGRAVITY
		+ALLOWPARTICLES
		+ZDOOMTRANS
		-NOINTERACTION
		-BLOODLESSIMPACT 
	}
	
	States
	{
	
	Spawn:
		TNT1 A 0;
		TNT1 A 0
		{
			//The Actors
			bool Bool_Sparky;
			Actor Sparky;
			bool Bool_BulletFlare;
			Actor BulletFlare;
				
			Actor USparks1, USparks2;	
			
			[Bool_Sparky, Sparky] = A_SpawnItemEx("U_Spark", flags: PARTICLE_FLAGS);
			[Bool_BulletFlare, BulletFlare] = A_SpawnItemEx("U_BulletFlare", flags: PARTICLE_FLAGS);
		
			if (Bool_BulletFlare)
			{
				BulletFlare.SetShade("khaki");
				BulletFlare.Scale = (0.17, 0.17);
			}	
			
			Sparky.SetShade("ffcc7d");
			
			let CVARS = RMD_CVARHandler(StaticEventHandler.Find('RMD_CVARHandler'));
			int CVAR_LowQuality = CVARS.RMDV_ParticleLowQuality;;
		
			if (CVAR_LowQuality == 1)
			{
				Return;
			}
	
			for (int i = 0; i < 2; i++)
			{
				USparks1 = A_SpawnProjectile("URPG_Sparks", 2, 0, frandom(0,1)*frandom (0, 360), 2, frandom (30, 360));
				
				if (USparks1)
				{
					USparks1.SetShade("fdd9c5");
				}
			}
		
			for (int i = 0; i < 2; i++)
			{
				Actor USparks2;
				USparks2 = A_SpawnProjectile("URPG_Sparks", 2, 0, frandom(0,1)*frandom (0, 360), 2, frandom (30, 360));
				
				if (USparks2)
				{
					USparks2.SetShade("ff8330");
				}
			}		
		
		}
		Stop;
	}
}

Class URPG_BulletArmorImpact : URPG_RicochetEffect
{

	const PARTICLE_FLAGS = SXF_TRANSFERTRANSLATION | SXF_USEBLOODCOLOR | SXF_NOCHECKPOSITION | SXF_TRANSFERPOINTERS;


	States
	{
	
	Spawn:	
		TNT1 A 0;
		TNT1 A 0 
		{
			//The Actors
			bool Bool_Sparky;
			Actor Sparky;
			bool Bool_BulletFlare;
			Actor BulletFlare;
				
			Actor USparks1, USparks2;	
			
			[Bool_Sparky, Sparky] = A_SpawnItemEx("U_Spark", flags: PARTICLE_FLAGS);
			[Bool_BulletFlare, BulletFlare] = A_SpawnItemEx("U_BulletFlare", flags: PARTICLE_FLAGS);
		
			if (Bool_Sparky)
			{
				Sparky.SetShade("deep sky blue");
			}
		
			if (Bool_BulletFlare)
			{
				BulletFlare.SetShade("steel blue");
				BulletFlare.Scale = (0.18, 0.18);
			}	
			
			let CVARS = RMD_CVARHandler(StaticEventHandler.Find('RMD_CVARHandler'));
			int CVAR_LowQuality = CVARS.RMDV_ParticleLowQuality;;
		
			if (CVAR_LowQuality == 1)
			{
				Return;
			}
	
			for (int i = 0; i < 6; i++)
			{
				USparks1 = A_SpawnProjectile("URPG_Sparks", 2, 0, frandom(0,1)*frandom (0, 360), 2, frandom (30, 360));
				
				if (USparks1)
				{
					USparks1.SetShade("8efcff");
				}
			}
		
			for (int i = 0; i < 6; i++)
			{
				Actor USparks2;
				USparks2 = A_SpawnProjectile("URPG_Sparks", 2, 0, frandom(0,1)*frandom (0, 360), 2, frandom (30, 360));
				
				if (USparks2)
				{
					USparks2.SetShade("3a9dfe");
				}
			}		
		
			for (int i = 0; i < 2; ++i)
			{
				Vector3 PVel = (FRandom[FX](-2.5, 2.5), FRandom[FX](-2.5, 2.5), FRandom[FX](1.2, 4.0)).unit()*FRandom[FX](1.0, 3.0);
				Vector3 RPos = (frandom(-3, 3), frandom(-3, 8), frandom(-1, 1));
				let Particle = Spawn("U_BulletSmoke", Pos + RPos);
					
				Particle.Vel = PVel;
				Particle.Scale = (0.045, 0.045);
			}
		
		}	
		Stop;
  }

}


Class URPG_Sparks : RMD_ModelSparks
{
	Default
	{
		+BRIGHT;
		RenderStyle "AddShaded";
		Alpha 1.0;
	}

	override void BeginPlay()
	{
		Scale.X = Frandom(0.05, 0.08);
		Scale.Y = Frandom(0.05, 0.08);
		Speed = random(5, 10);
		Gravity = frandom(0.7,0.95);
	}

    States
    {
    Spawn:
	   SPKO S 2 BRIGHT;
       SPKO SSSSSSSSSS 1 Bright A_FadeOut(0.1);
       stop;
    Death:
       TNT1 A 0;
       Stop;
    }
}

Class U_BulletSmoke : RMD_BaseParticle
{
	Default
	{
		RenderStyle "Translucent";
		Alpha 0.17;
	}
	
	Override void BeginPlay()
	{
		Super.BeginPlay();
		
		Roll = frandom(0, 360);	
	}
	
	Override void Tick()
	{
		Super.Tick();
		
		if (!isFrozen())
		{
			A_SetScale(Scale.X * 1.08, Scale.Y * 1.08);	
		}
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Jump(256, "Smoke1", "Smoke2", "Smoke3", "Smoke4");
		Smoke1:
			SMOA A 17;
			SMOA AAAAAAAAAA 1 A_FadeOut(0.017);
			Stop;
		Smoke2:
			SMOB A 17;
			SMOB AAAAAAAAAA 1 A_FadeOut(0.017);
			Stop;
		Smoke3:
			SMOC A 17;
			SMOC AAAAAAAAAA 1 A_FadeOut(0.017);
			Stop;
		Smoke4:
			SMOD A 17;
			SMOD AAAAAAAAAA 1 A_FadeOut(0.017);
			Stop;
	}
}


Class U_Spark : RMD_BaseParticle
{
	Default
	{
		Renderstyle "AddShaded";
		Alpha 0.85;
		Scale 0.12;
		+Bright;
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Jump(256,"Spawn1", "Spawn2", "Spawn3");
			Goto Spawn1;
		Spawn1:
			IPF1 AB 2;
			Stop;
		Spawn2:
			IPF2 AB 2;
			Stop;
		Spawn3:
			IPF3 AB 2;
			Stop;

	}
}


Class U_BulletFlare : RMD_BaseParticle
{
	Default
	{
		RenderStyle "AddShaded";
		Scale 1.0;
		Alpha 1.0;
		+Bright;
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
			LENS CCCCC 1 A_FadeOut(0.2);
			Stop;	
	}
}



Class RMD_BulletSmoke : RMD_BaseParticle
{
	Default
	{
		RenderStyle "Translucent";
		Alpha 0.35;
		YScale 0.045;
		XScale 0.045;
		Gravity 0.35;
		-NoGravity
	}
	
	Override void BeginPlay()
	{
		Super.BeginPlay();
		
		Roll = frandom(0, 360);
		Translation = 0xEAD7B3;
	}
	
	Override void Tick()
	{
		Super.Tick();
		
		if (!isFrozen())
		{
			A_SetScale(Scale.X * 1.065, Scale.Y * 1.065);	
		}
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Jump(256, "Smoke1", "Smoke2", "Smoke3", "Smoke4");
		Smoke1:
			SMOA A 3;
			SMOA AAA 1 A_FadeOut(0.116);
			Stop;
		Smoke2:
			SMOB A 3;
			SMOB AAA 1 A_FadeOut(0.116);
			Stop;
		Smoke3:
			SMOC A 3;
			SMOC AAA 1 A_FadeOut(0.116);
			Stop;
		Smoke4:
			SMOD A 3;
			SMOD AAA 1 A_FadeOut(0.116);
			Stop;
	}
}