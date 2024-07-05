Class RMD_BaseParticle : Actor
{
	float TTL;
	float TTLInit;
	float ScaleGrowth; 

	Property TimeToLife:TTL;
	Property ScaleGrowth:ScaleGrowth; 

	Default
	{
		+NOINTERACTION
		+FORCEXYBILLBOARD
		+ROLLSPRITE
		+CLIENTSIDEONLY
		+DONTSPLASH
		-ROLLCENTER;
		Gravity 0;
		
		RMD_BaseParticle.TimeToLife 50;
		RMD_BaseParticle.ScaleGrowth 1.05;
	}
	
	override void Tick()
	{
		super.Tick();
		
		if (Level.IsFrozen())
			return;
		
		Fade();
		ReduceTTL();
		
		Scale.X = Scale.X * ScaleGrowth;
		Scale.Y = Scale.Y * ScaleGrowth;
		
	}
	
	override void BeginPlay()
	{
		Super.BeginPlay();
	
		TTLInit = TTL;
	}
	
	void ReduceTTL()
	{
		TTL = TTL - 1;
		
		if (TTL <= 0)
		{
			TTL = 0;
			Destroy();
		}
	}
	
	void Fade()
	{
		float TTLDiv = TTLInit / 2;
	
		if (TTL <= TTLDiv)
			A_FadeOut(Alpha - (TTL / 14));	
	}
	
}


Mixin Class Mix_ParticleSpawner 
{
	const FXFLAG = SXF_TRANSFERPOINTERS | SXF_TRANSFERTRANSLATION;
}



Class RMD_BaseMuzzleFlash : RMD_BaseParticle
{
	//Code from Flak_M.pk3
	Vector3 ofs, vvel;
	
	override void Tick()
	{
		Actor.Tick();
		
		if (!target)
		{
			Destroy();
			return;
		}
		
		Vector3 x, y, z;
		[x, y, z] = dt_Matrix4.GetAxes(target.pitch,target.angle,target.roll);
		Vector3 origin = x*ofs.x+y*ofs.y+z*ofs.z+(0,0,target.player.viewz);
		SetOrigin(target.Vec2OffsetZ(origin.x,origin.y,origin.z),true);
		bInvisible = (players[consoleplayer].camera != target);
		if ( Level.isfrozen()) return;
		ofs += vvel;
		vvel *= 0.9;
		scale *= 0.8;
		if ( scale.x <= 0.01 ) Destroy();
	}
}


Class RMD_ParticleSpawner : Actor
{
	Default
	{
		-COUNTKILL
		-SHOOTABLE
		+CLIENTSIDEONLY
		+BLOODLESSIMPACT 
		+FORCEXYBILLBOARD
		+THRUACTORS
		+NOCLIP
		+NOGRAVITY
		+ROLLSPRITE
		Speed 0;
		Radius 1;
		Height 1;
	}

}

Class RMD_ModelSparks : RMD_BaseParticle
{
	Default
	{
		+MISSILE
		+NOBLOCKMAP
		+DONTSPLASH
		+FORCEXYBILLBOARD
		+CLIENTSIDEONLY
		+THRUACTORS
		+GHOST
		+THRUGHOST
		+NOTELEPORT
		+ROLLSPRITE
		-NOINTERACTION
		-NOGRAVITY
		-NOCLIP
		Mass 0;
		speed 7;
		Scale 0.02;
		Gravity 0.7;
		RADIUS 1;
		HEIGHT 1;
		BounceType "Hexen";
		BounceFactor 1.25;
		WallBounceFactor 1.25;
		
	}
}

Class RMD_TrailBase : RMD_ModelSparks 
{
	Default
	{
	
		+NOCLIP
		-SOLID
		Gravity 0;
		BounceType "None";
		BounceFactor 0;
		WallBounceFactor 0;
	
	}

}

