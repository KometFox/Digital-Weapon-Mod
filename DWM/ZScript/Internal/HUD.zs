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
	
	//Player
	//PlayerPawn 
	
	//Mana...
	int BlueMana_Amount;
	
	//Weapons
	int CurrentMag;
	TextureID AmmoIcon; 
	String Ammo1;
	
	//Grenades
	int ThrowPower;
	

override void Init()
{
	Super.Init();

	//Init some values
	SetSize(0,320,200);
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
		
		
		int X0 = 800;
		int Y0 = 1032;
		int X1 = X0 + (Length * 4);
		int Y1 = 1032;
		
		
		Screen.DrawThickLine(X0, Y0, X1, Y1, 15, Color(0, 230, 230));	
	}


	//Function for simplified Text display
	ui void AddText(String Text, Int ColorID, int PosX, int PosY, double ScaleX, double ScaleY)
	{
		int Width, Height;
		[Width, Height] = GetResolution();
		
	
		HUDFont BIGNUM = HUDFont.Create("RMDFONT_BIGNUM");

		DrawString(BIGNUM, Text, (PosX, PosY), 0, ColorID, 1.0, -1, 4, (ScaleX, ScaleY));
	}
	
	ui void AddImage(TextureID Tex, int PosX, int PosY, double ScaleX, double ScaleY)
	{
		//Had to borrow from Marisa because I have no hecking clue how the hell I am supposed
		//To retain image position and scale on resolution changes, jesus christ. 
		int Width, Height;
		[Width, Height] = GetResolution();
	
		double sx = 1.0;
		double HScale = Width/1280.;
		double ss = (HScale*sx);
		double dw = (Width/ss), dh = (Height/ss);
		double dx = CurX/ss + PosY, dy = CurY/ss + PosX;
	
		Screen.DrawTexture(Tex, false, dx,  dy, 
		DTA_KeepRatio, true,
		DTA_VirtualWidthF, dw, 
		DTA_VirtualHeightF, dh, 
		DTA_DestWidthF, ScaleX, 
		DTA_DestHeightF, ScaleY);
	}
	
	ui void AddHUDOverlay(TextureID Tex, int PosX, int PosY, double ScaleX, double ScaleY)
	{
		int Width, Height;
		[Width, Height] = GetResolution();
	
		Screen.DrawTexture(Tex, false, PosX,  PosY, 
		DTA_KeepRatio, true, 
		DTA_VirtualWidth, Width, 
		DTA_VirtualHeight, Height, 
		DTA_DestWidthF, Width * ScaleX, 
		DTA_DestHeightF, Height * ScaleY);
	}	
	
	
//UI Scope: you cannot alter data here
	override void Draw(int State, double TicFrac)	// UI scope
	{			
		Super.Draw(State, TicFrac);
	
		PlayerPawn Playa = CPlayer.mo;
		RMD_BARINFO BarInfo = RMD_BARINFO(EventHandler.Find("RMD_BARINFO"));		
		
		
		if (Playa && (state == HUD_StatusBar) || (state == HUD_Fullscreen)
			&& AutoMapDrawn == False)
		{
			int ArmorV = GetArmorAmount(); 
			int Geld = Playa.CountInv("Material");
			int Mag1 = BarInfo.GetMagSize();
			String VAmmo = BarInfo.GetAmmo1();
			int AmmoStash = Playa.CountInv(VAmmo);
			TextureID AmmoIcon = BarInfo.GetAmmoIcon();
			TextureID MuggyShot = GetMugshot(3);
			TextureID VCrosshair = TexMan.CheckForTexture("XHAIRB1", TexMan.Type_Any);
			CVar CCrosshairSize = CVar.FindCVar("CrosshairScale");
			double VCrosshairSize = CCrosshairSize.GetFloat(); 
		
			//The HUD
			AddHUDOverlay(HUDOverlay, 0, 0, 1, 1);
			
			//Crosshair
			AddImage(VCrosshair, Screen.GetWidth() / 2, Screen.GetHeight() / 2, VCrosshairSize, VCrosshairSize);
			
			//Health
			//AddText(String.Format("<1000>"), -20, 157, 0.6, 0.6);
			AddText(String.Format("%d", Playa.Health), Font.CR_CYAN, -20, 160, 0.6, 0.6);
			
			//Armor
			//AddText(String.Format("<2000>"), -20, 180, 0.6, 0.6);
			AddText(String.Format("%d", ArmorV), Font.CR_CYAN, -20, 170, 0.6, 0.6);
			
			//Credits
			AddText(String.Format("<Credit> %d", Geld), Font.CR_CYAN, 128, 195, 0.35, 0.35);
	
			//Ammo Icon
			AddImage(AmmoIcon, 615, 1095, 80, 80);

			//Ammo
			AddText(String.Format("%d", Mag1), Font.CR_CYAN, 282, 160, 0.6, 0.6);
			
			//Ammo in Stash
			if (VAmmo != "None")
			{
				AddText(String.Format("%d", Playa.CountInv(VAmmo)), Font.CR_CYAN, 282, 170, 0.6, 0.6);
			}
			
			//DoomFace 
			AddImage(MuggyShot, 620, 600, 64, 64);
			
			//Keys
			TextureID BlueKey = TexMan.CheckForTexture("STKEYS0", TexMan.Type_Any);
			TextureID YellowKey = TexMan.CheckForTexture("STKEYS1", TexMan.Type_Any);
			TextureID RedKey = TexMan.CheckForTexture("STKEYS2", TexMan.Type_Any);
			//Skulls
			TextureID BlueSkullKey = TexMan.CheckForTexture("STKEYS3", TexMan.Type_Any);
			TextureID YellowSkullKey = TexMan.CheckForTexture("STKEYS4", TexMan.Type_Any);
			TextureID RedSkullkey = TexMan.CheckForTexture("STKEYS5", TexMan.Type_Any);
			
			int KeyPosX = 40;
			int KeyPosY = 800;
			int SkullKeyPosX = 95;
			int SkullKeyPosY = 800;
			
						
			if (Playa.CountInv("BlueCard"))
				AddImage(BlueKey, KeyPosX, KeyPosY + (30), 32, 32);
			if (Playa.CountInv("YellowCard"))
				AddImage(YellowKey, KeyPosX, KeyPosY + (30 * 2), 32, 32);
			if (Playa.CountInv("RedCard"))
				AddImage(RedKey, KeyPosX, KeyPosY + (30 * 3), 32, 32);
			
			if (Playa.CountInv("BlueSkull"))
				AddImage(BlueSkullKey, SkullKeyPosX, SkullKeyPosY + (30), 32, 32);
			if (Playa.CountInv("YellowSkull"))
				AddImage(YellowSkullKey, SkullKeyPosX, SkullKeyPosY + (30 * 2), 32, 32);
			if (Playa.CountInv("RedSkull"))
				AddImage(RedSkullkey, SkullKeyPosX, SkullKeyPosY + (30 * 3), 32, 32);		
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











