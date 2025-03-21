//Lifted from Unreal RPG mod
Class RMD_BulletImpact : RMD_ParticleSpawner
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
			
			[Bool_Sparky, Sparky] = A_SpawnItemEx("RMD_BulletSpark", flags: PARTICLE_FLAGS);
		
			if (Sparky)
			{
				Sparky.Scale = (0.20, 0.20);			
			}
		
		
			let CVARS = RMD_CVARHandler(StaticEventHandler.Find('RMD_CVARHandler'));
			int CVAR_LowQuality = CVARS.RMDV_ParticleLowQuality;;
		
			if (CVAR_LowQuality == 1)
			{
				Return;
			}
	
			for (int i = 0; i < 6; i++)
			{
				RMD_BaseParticle Particle = RMD_BaseParticle(A_SpawnProjectile("RMD_Sparks", 2, 0, frandom(0,1)*frandom (0, 360), 2, frandom (30, 360)));
				Vector3 PVel = (FRandom[FX](-1.0, 1.0), FRandom[FX](-1.0, 1.0), FRandom[FX](-1.0, 1.0)).unit()*FRandom[FX](6.0, 20.0);
				
				if (Particle)
				{
					Particle.SetShade("ff1d00");
					Particle.Vel = PVel;
					Particle.Scale = (0.04, 0.04);
					Particle.TTL = 7;
				}
			}
		
			for (int i = 0; i < 3; ++i)
			{
				Vector3 PVel = (FRandom[FX](-0.5, 0.5), FRandom[FX](-0.5, 0.5), FRandom[FX](1.0, 2.0)).unit()*FRandom[FX](0.75, 7.0);
				Vector3 RPos = (frandom(-3, 3), frandom(-3, 8), frandom(-1, 1));
				RMD_BaseParticle Particle = RMD_BaseParticle(Spawn("RMD_Smoke", Pos + RPos));
					
				Particle.Vel = PVel;
				Particle.Scale = (0.08, 0.08);
				Particle.ScaleGrowth = 1.08;
				Particle.TTL = 7;
				Particle.Alpha = 0.12;
			}
		
		}	
		Stop;
	}
}


Class RMD_BulletSpark : RMD_BaseParticle
{

	Default
	{
		RenderStyle "Add";
		Alpha 1.0;
		+BRIGHT;
		RMD_BaseParticle.TimeToLife 15;
		RMD_BaseParticle.ScaleGrowth 1.07;
	}
	
	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		
		Roll = Random[FX](0, 360);
		Angle = Random[FX](0, 360);	
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 
			{
				int Dice = random(0, 2);
				
				if (Dice == 0) 
				{
					return ResolveState("Sprite1");
				}
				else if (Dice == 1)
				{
					return ResolveState("Sprite2");
				}
				else if (Dice == 2)
				{
					return ResolveState("Sprite3");
				}

				return ResolveState("Spawn");
			}
			Goto Sprite1;
			
		Sprite1:
			IPF1 A 3;
			Stop;
		Sprite2:
			IPF2 A 3;
			Stop;
		Sprite3:
			IPF3 A 3;
			Stop;
	}
}


