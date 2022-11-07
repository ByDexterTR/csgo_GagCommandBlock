#include <sourcemod>
#include <basecomm>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
	name = "Gag Block Command", 
	author = "ByDexter", 
	description = "Gaglı oyuncular belirlediğiniz komutları yazamaz.", 
	version = "1.1", 
	url = "https://steamcommunity.com/id/ByDexterTR - ByDexter#5494"
};

public void OnMapStart()
{
	KeyValues Kv = new KeyValues("ByDexter");
	char sBuffer[256];
	BuildPath(Path_SM, sBuffer, sizeof(sBuffer), "ByDexter/GagBlockCommand.txt");
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
	if (IsClientInGame(client) && BaseComm_IsClientGagged(client))
	{
		ReplyToCommand(client, "[SM] Gaglı oyuncuların bu komuta erişimi yok.");
		return Plugin_Stop;
	}
	return Plugin_Continue;
} 