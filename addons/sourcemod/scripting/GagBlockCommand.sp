#include <sourcemod>
#include <basecomm>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
	name = "Gag Block Command", 
	author = "ByDexter", 
	description = "Gaglı oyuncular belirlediğiniz komutları yazamaz.", 
	version = "1.0", 
	url = "https://steamcommunity.com/id/ByDexterTR - ByDexter#5494"
};

public void OnPluginStart()
{
	LoadConfig();
}

public void OnMapEnd()
{
	LoadConfig();
}

public void LoadConfig()
{
	KeyValues Kv = new KeyValues("ByDexter");
	char sBuffer[256];
	BuildPath(Path_SM, sBuffer, sizeof(sBuffer), "addons/sourcemod/ByDexter/GagBlockCommand.txt");
	if (!FileToKeyValues(Kv, sBuffer))SetFailState("%s dosyası bulunamadı.", sBuffer);
	
	if (Kv.GotoFirstSubKey())
	{
		do
		{
			if (Kv.GetSectionName(sBuffer, sizeof(sBuffer)))
			{
				AddCommandListener(Control_Command, sBuffer);
			}
		}
		while (Kv.GotoNextKey());
	}
	delete Kv;
}

public Action Control_Command(int client, const char[] command, int args)
{
	if (BaseComm_IsClientGagged(client))
	{
		ReplyToCommand(client, "[SM] Gaglı olduğunuz için bu komutu kullanamazsınız.");
		return Plugin_Stop;
	}
	return Plugin_Continue;
} 