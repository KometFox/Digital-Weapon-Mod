/*
TODO: Improve position and scale so that it changes properly according to resolution

*/
Class RMD_BARHUD : BaseStatusBar
{
	TextureID BlueMana;
	TextureID HUDOverlay; 
	
	bool AutoMapDrawn;
	
	//Resolution Shit
	double CurX;
	double CurY;
	double HScale;
	double HudSize;
	
	//Player
	//PlayerPawn 
	
	//Mana...
	int BlueMana_Amount;
	
	//Weapons
	int CurrentMag;
	TextureID AmmoIcon; 
	String Ammo1;
	String FireMode; 
	
	//Grenades
	int ThrowPower;
	

override void Init()
{
	Super.Init();

	//Init some values
	SetSize(0, 320, 200);
	BlueMana = TexMan.CheckForTexture("BMANA0", TexMan.Type_Any);
	HUDOverlay = TexMan.CheckForTexture("TDHUD", TexMan.Type_Any);

	Ammo1 = "";
}

	ui int, int GetResolution()
	{
		int ScreenWidth = Screen.GetWidth();
		int Screenheight = Screen.GetHeight();
		
		return ScreenWidth, ScreenHeight;
	}
	
	
	ui void AddBar(int Length)
	{
		int ScreenWidth = Screen.GetWidth();
		int Screenheight = Screen.GetHeight();
		
		
		int X0 = 735;
		int Y0 = 475;
		int X1 = 735;
		int Y1 = 480 + (Length * 4);
		
		Screen.DrawThickLine(Y0, X0, Y1, X1, 15, Color(0, 230, 230));	
	}


	//Function for simplified Text display
	ui void AddText(String Text, Int ColorID, int PosX, int PosY, double ScaleX, double ScaleY)
	{
		//HUDFont BIGNUM = HUDFont.Create("RMDFONT_BIGNUM");
		HUDFont BIGNUM = HUDFont.Create("BIGUPPER");

		DrawString(BIGNUM, Text, (PosX, PosY), DI_Text_Align_Right|DI_NoShadow, Font.CR_CYAN, 1, -1, 4, (ScaleX, ScaleY));
	}
	
	ui void AddImage(String Tex, int PosX, int PosY, double ScaleX, double ScaleY)
	{
		ScaleX = ScaleX / 2;
		ScaleY = ScaleY / 2;
	
		DrawImage(Tex, (PosX, PosY), DI_SCREEN_CENTER, 1, (-1, -1), (ScaleX, ScaleY));
	}
	
//UI Scope: you cannot alter data here
	override void Draw(int State, double TicFrac)	// UI scopeTextureID 
	{			
		Super.Draw(State, TicFrac);
	
		HScale = Screen.GetWidth()/1280.;
		hudsize = 1.0;
	
		PlayerPawn Playa = CPlayer.mo;
		RMD_BARINFO BarInfo = RMD_BARINFO(EventHandler.Find("RMD_BARINFO"));		
		
		
		if (Playa && (state == HUD_StatusBar) || (state == HUD_Fullscreen)
			&& AutoMapDrawn == False)
		{
			int ArmorV = GetArmorAmount(); 
			int Geld = Playa.CountInv("Material");
			int Mag1 = BarInfo.GetMagSize();
			int VThrowPower = BarInfo.GetThrowPower();
			String VAmmo = BarInfo.GetAmmo1();
			String VFireMode = BarInfo.GetFireMode();
			int AmmoStash = Playa.CountInv(VAmmo);
			String AmmoIcon = TexMan.GetName(BarInfo.GetAmmoIcon());
			String MuggyShot = TexMan.GetName(GetMugshot(3));
			String VCrosshair = "XHAIRB1";
			String HUDe1 = "BOX1";
			String HUDe2 = "BOX2";
			String MiniBox = "MiniBox";
			CVar CCrosshairSize = CVar.FindCVar("CrosshairScale");
			double VCrosshairSize = CCrosshairSize.GetFloat(); 

		
			//The HUD
			AddImage(HUDe1, -10, 200, 1.0, 1.0);
			AddImage(HUDe2, 69, 200, 1.0, 1.0);
			
			//HUD Face
			AddImage(MiniBox, 150, 200, 1.0, 1.0);
			
			//Item Box
			AddImage(MiniBox, 65, 150, 1.0, 1.0); 
			
			//Ammo Box
			AddImage(MiniBox, 90, 150, 1.0, 1.0); 
			
			//Crosshair
			AddImage(VCrosshair, Screen.GetWidth() / 2, Screen.GetHeight() / 2, VCrosshairSize / 10, VCrosshairSize / 10);
			
			//Health
			int FormHealth;
			
			if (FormHealth > 10000)
				FormHealth = 9999;
			else
				FormHealth = Playa.HealtH;
			
			AddText(String.Format("%d", FormHealth), Font.CR_CYAN, 20, 157, 1.0, 1.0);
			
			//Armor
			AddText(String.Format("%d", ArmorV), Font.CR_CYAN, 20, 175, 1.0, 1.0);
			
			//Credits
			AddText(String.Format("%d", Geld), Font.CR_CYAN, 40, 193, 0.5, 0.5);

			//Firemode
			AddText(String.Format("<FM> %s", VFireMode), Font.CR_CYAN, 85, 152, 0.25, 0.25);

			//Grenade Bar
			AddBar(VThrowPower); 

			//Ammo Icon
			AddImage(AmmoIcon, 90, 150, 0.6, 0.6);

			//Ammo
			AddText(String.Format("%d", Mag1), Font.CR_CYAN, 80, 163, 0.75, 0.75);
			
			//Ammo in Stash
			if (VAmmo != "None")
			{
				AddText(String.Format("%d", Playa.CountInv(VAmmo)), Font.CR_CYAN, 80, 180, 0.75, 0.75);
			}
			
			//DoomFace 
			AddImage(MuggyShot, 150, 200, 0.8, 0.8);
			
			//Selected Inventory
			if (Playa.InvSel)
			{
				AddText(String.Format("%d", Playa.InvSel.Amount), Font.CR_CYAN, 73, 143, 0.4, 0.4);
				AddImage(TexMan.GetName(Playa.InvSel.Icon), 65, 145, 0.5, 0.5);
			}
			
			
			//Keys
			String BlueKey = "STKEYS0";
			String YellowKey = "STKEYS1";
			String RedKey = "STKEYS2";
			//Skulls
			String BlueSkullKey = "STKEYS3";
			String YellowSkullKey = "STKEYS4";
			String RedSkullkey = "STKEYS5";
			
			int KeyPosX = -40;
			int KeyPosY = 150;
			int SkullKeyPosX = 10;
			int SkullKeyPosY = 150;
			
						
			if (Playa.CountInv("BlueCard"))
				AddImage(BlueKey, KeyPosX + (18), KeyPosY, 1, 1);
			if (Playa.CountInv("YellowCard"))
				AddImage(YellowKey, KeyPosX + (18 * 1.5), KeyPosY, 1, 1);
			if (Playa.CountInv("RedCard"))
				AddImage(RedKey, KeyPosX + (18 * 2.0), KeyPosY, 1, 1);
				
			if (Playa.CountInv("BlueSkull"))
				AddImage(BlueSkullKey, SkullKeyPosX + (18), SkullKeyPosY, 1, 1);
			if (Playa.CountInv("YellowSkull"))
				AddImage(YellowSkullKey, SkullKeyPosX + (18 * 1.5), SkullKeyPosY, 1, 1);
			if (Playa.CountInv("RedSkull"))
				AddImage(RedSkullKey, SkullKeyPosX + (18 * 2.0), SkullKeyPosY, 1, 1);				
				
		}

	}
		
	override void DrawAutomapHUD(double Ticfrac)
	{
		Super.DrawAutomapHUD(Ticfrac);
			
			
		
	
	}
		
}


Class RMD_BARINFO : EventHandler
{
	//Weapons
	int CurrentMag;
	TextureID AmmoIcon; 
	String Ammo1;
	String FireMode;
	
	//Grenades
	int ThrowPower;
	
	static void SetAmmoIcon(string Icon)
	{
		RMD_BARINFO RMD_BARINFO;
		RMD_BARINFO = RMD_BARINFO(EventHandler.Find("RMD_BARINFO"));
	
		if (RMD_BARINFO)
		{
			RMD_BARINFO.AmmoIcon = TexMan.CheckForTexture(Icon, TexMan.Type_Any);
		}
	}
	
	static void SetAmmo1(String Type)
	{
		RMD_BARINFO RMD_BARINFO;
		RMD_BARINFO = RMD_BARINFO(EventHandler.Find("RMD_BARINFO"));
	
		if (RMD_BARINFO)
		{
			RMD_BARINFO.Ammo1 = Type;
		}
	
	}
	
	static void Set_Mag(int Amount)
	{
		RMD_BARINFO RMD_BARINFO;
		RMD_BARINFO = RMD_BARINFO(EventHandler.Find("RMD_BARINFO"));
	
		if (RMD_BARINFO)
		{
			RMD_BARINFO.CurrentMag = Amount;
		}
	}
	
	static void SetThrowPower(int Amount)
	{
		RMD_BARINFO RMD_BARINFO;
		RMD_BARINFO = RMD_BARINFO(EventHandler.Find("RMD_BARINFO"));
	
		if (RMD_BARINFO)
		{
			RMD_BARINFO.ThrowPower = Amount;
		}
	}
	
	static void SetFireMode(string Mode)
	{
		RMD_BARINFO RMD_BARINFO;
		RMD_BARINFO = RMD_BARINFO(EventHandler.Find("RMD_BARINFO"));
	
		if (RMD_BARINFO)
		{
			RMD_BARINFO.FireMode = Mode;
		}	
	}
	
	
	ui string GetAmmo1()
	{
		return Ammo1;	
	}
	
	ui int GetMagSize()
	{
		return CurrentMag;
	}
	
	ui TextureID GetAmmoIcon()
	{
		return AmmoIcon;
	}
	
	ui string GetFireMode()
	{
		return FireMode; 
	}
	
	ui int GetThrowPower()
	{
		return ThrowPower; 
	}

}

//------------------------------------------------------------------------------
//List of Player weapons and ammo.
//------------------------------------------------------------------------------
Class Player_Weapons : EventHandler
{
	S_Weapons Weapons[5];

Struct S_Weapons
{
	String WeaponID, AmmoType1, AmmoType2;
}

override void WorldLoaded(WorldEvent e)
{
	Weapons[0].WeaponID = "HRF10";
	Weapons[0].AmmoType1 = "RM_BlueMana";
	Weapons[0].AmmoType2 = "RM_BlueMana";
}

}



Class WelcomeScreen : StaticEventHandler
{
	int TimeOut;

	ui void AddText(String Text, float pos_x, float pos_y)
	{
		Font BIGNUM = Font.FindFont("SMALLFONT");
		
		Screen.DrawText(BIGNUM, Font.CR_LightBlue, pos_x, pos_y, Text,
		DTA_KeepRatio, true,
		DTA_VirtualWidth, 800, 
		DTA_VirtualHeight, 600);
	}
	
	override void NewGame()
	{
		TimeOut = 150;	
	}
	
	override void WorldTick()
	{
		TimeOut--;
	}
	
	override void RenderOverlay(RenderEvent e)
	{
		if (TimeOut > 0)
		{
			AddText("Welcome
			This mod utilizes a shop menu to buy items instead of looting it.
			Check the options menu for the keybinds of it.", 150, 130);
		}
	}
	
	
}











