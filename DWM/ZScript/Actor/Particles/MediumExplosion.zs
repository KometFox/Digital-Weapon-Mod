//------------------------------------------------------------------------------
//Medium Explosion
//------------------------------------------------------------------------------
Class RMD_MediumExplosion : Actor
{

	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 
			{
				//A_PlaySound("MISSEX2", CHAN_6);
				

				for (int i = 0; i < 14; ++i)
				{
					Vector3 PVel = (FRandom[FX](-0.25, 0.25), FRandom[FX](-0.25, 0.25), FRandom[FX](-0.25, 0.25)).unit()*FRandom[FX](1.25, 3.0);
					Vector3 RPos = (frandom(-8, 8), frandom(-8, 8), frandom(-4, 4));
					let Particle = Spawn("RMD_Boom6", Pos + RPos);
					
					Particle.Vel = PVel;
					Particle.Scale = (1.2, 1.2);
				}

			}
			Stop;
			
	}
}
