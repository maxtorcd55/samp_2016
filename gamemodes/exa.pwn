// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT


#include <a_samp>
#include <sscanf>
#include <Thread>
#include "../include/player_tracker.pwn"
new connectedPlayers = 0;
new players[MAX_PLAYERS] = {MAX_PLAYERS,...};

#include "../include/quicksort.pwn"
#include "../include/binarysearch.pwn"
#include "../include/needs.pwn"
#include "../include/exa_speedometer.pwn"

#if defined FILTERSCRIPT


public OnFilterScriptInit()
{
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{

}

#endif


public OnGameModeInit()
{
	needs_OnGameModeInit();
	// Don't use these lines if it's a filterscript
	SetGameModeText("eXa");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	createSpeedometerTimer();
	/*
	new mapiconsData[64], mapIconIndex = 0;
	new File:mapicons = fopen("checkpoint.data", io_read);
	while(fread(mapicons, mapiconsData))
	{
	    new findings[10][64];
	    split(mapiconsData,findings);
		mapIcons[mapIconIndex][0] = floatstr(findings[2]);
		mapIcons[mapIconIndex][1] = floatstr(findings[3]);
		mapIcons[mapIconIndex][2] = floatstr(findings[4]);
		mapIcons[mapIconIndex][3] = floatstr(findings[5]);
	}
	fclose(mapicons);
	*/
	CreateObject(9116, 2067.6641, 1182.1591, 65.682, 0, 0, 0);//object (VegasEroad139) (1)
	CreateObject(9116, 2067.6641, 982.37903, 65.682, 0, 0, 0);//object (VegasEroad139) (2)
	CreateObject(9116, 2067.6641, 1380.979, 65.682, 0, 0, 0);//object (VegasEroad139) (3)
	CreateObject(9116, 2067.6641, 1580.5389, 65.682, 0, 0, 0);//object (VegasEroad139) (4)
	CreateObject(9116, 2067.6641, 1779.859, 65.682, 0, 0, 0);//object (VegasEroad139) (5)
	CreateObject(9116, 2067.6641, 1979.319, 65.682, 0, 0, 0);//object (VegasEroad139) (6)
	CreateObject(8048, 2033.62, 966.82202, 66.246, 0, 0, 0);//object (VegasSroad047) (1)
	CreateObject(8048, 2033.62, 1085.922, 66.246, 0, 0, 0);//object (VegasSroad047) (2)
	CreateObject(8048, 2033.62, 1204.812, 66.246, 0, 0, 0);//object (VegasSroad047) (3)
	CreateObject(8048, 2033.62, 1323.882, 66.246, 0, 0, 0);//object (VegasSroad047) (4)
	CreateObject(8048, 2033.62, 1443.092, 66.246, 0, 0, 0);//object (VegasSroad047) (5)
	CreateObject(8048, 2033.62, 1562.552, 66.246, 0, 0, 0);//object (VegasSroad047) (6)
	CreateObject(8048, 2033.62, 1681.582, 66.246, 0, 0, 0);//object (VegasSroad047) (7)
	CreateObject(8048, 2033.62, 1800.042, 66.246, 0, 0, 0);//object (VegasSroad047) (8)
	CreateObject(8048, 2033.62, 1918.582, 66.246, 0, 0, 0);//object (VegasSroad047) (9)
	CreateObject(8048, 2033.62, 2037.722, 66.246, 0, 0, 0);//object (VegasSroad047) (10)
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	addPlayerToTracker(connectedPlayers, players);
	createPlayerSpeedometer(playerid);
	needs_OnPlayerConnect(playerid);


	SetPlayerMapIcon(playerid, 41, 927.419372, 2007.497680, 11.460937, 31, 0, MAPICON_LOCAL);//huis
	SetPlayerMapIcon(playerid, 42, 927.359741, 2006.507080, 11.460937, 31, 0, MAPICON_LOCAL);//house_w_giant_airco
	SetPlayerMapIcon(playerid, 43, -368.495910, 1168.395629, 20.271875, 31, 0, MAPICON_LOCAL);//huis11
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	removePlayerFromTracker(connectedPlayers, players);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	needs_OnPlayerSpawn(playerid);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[64],params[64];
	sscanf(cmdtext, "ss", cmd, params);
	if (strcmp("/car", cmd, true, 10) == 0)
	{
		new Float:x, Float:y, Float:z;
    	GetPlayerPos(playerid, x, y, z);
		new vehicleid = CreateVehicle(451, x, y+2.0, z, 0, -1, -1, 60);
        SetVehicleHealth(vehicleid, 999999999);
		return 1;
	}

	if (strcmp("/icon", cmd, true, 10) == 0)
	{
	    new icon, comme[80];
		if(!sscanf(params, "ds" ,icon,comme))
		{
			new Float:x, Float:y, Float:z;
	    	GetPlayerPos(playerid, x, y, z);
	    	new string[128];
			format(string,sizeof(string),"SetPlayerMapIcon(playerid, 0, %f, %f, %f, %d, 0, MAPICON_LOCAL);//%s\r\n",x, y, z,icon,comme);
			static playerindexA = 50;
			for(new i=0; i<MAX_PLAYERS; i++)
			{
				SetPlayerMapIcon(playerid, playerindexA, x, y, z, icon, 0, MAPICON_LOCAL);
			}
			playerindexA++;
			new File:handle = fopen("checkpoint.data", io_append);
			if(handle)
			{
				fwrite(handle, string);
				fclose(handle);
			}
			else
			{
				print("Failed to open file \"file.txt\".");
			}
		}
		else
		{
			SendClientMessage(playerid,-1,"Use /icon <id> <text>");
		}
		return 1;
	}

	if (strcmp("/add", cmd, true, 10) == 0)
	{
	    new comme[80];
		if(!sscanf(params, "s" ,comme))
		{
			new Float:x, Float:y, Float:z;
			new Float:Angle;
			GetPlayerFacingAngle(playerid, Angle);
	    	GetPlayerPos(playerid, x, y, z);
	    	new string[128];
			format(string,sizeof(string),"%f, %f, %f, %f (%d)//%s\r\n",x, y, z,Angle,GetPlayerInterior(playerid),comme);
			new File:handle = fopen("add.data", io_append);
			if(handle)
			{
				fwrite(handle, string);
				fclose(handle);
			}
			else
			{
				print("Failed to open file \"file.txt\".");
			}
		}
		else
		{
			SendClientMessage(playerid,-1,"Use /add <action>");
		}
		return 1;
	}

	if (strcmp("/armour", cmd, true, 10) == 0)
	{
		SetPlayerArmour(playerid, 100.0);
		return 1;
	}

	if (strcmp("/getplayerpos", cmd, true, 10) == 0)
	{
		new Float:x, Float:y, Float:z, string[60];

		GetPlayerPos(playerid, x, y, z);
		format(string,sizeof(string),"%f, %f, %f - %d",x, y, z,GetPlayerInterior(playerid));
		SendClientMessage(playerid,0xFFFFFAA,string);
		return 1;
	}
	if(needs_OnPlayerCommandText(playerid, cmd, params)){return 1;}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	needs_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}




stock split(string[],array[10][64])
{
	new i = 0, index = 0;
	while (i < strlen(string) && i >= 0)
	{
	    new find[64];
	    i = token_by_delim(string,find,',',i+1);
	    array[index] = find;
	    index ++;
	}
}

stock string_replace(string[], find, replace)
{
    for(new i=0; string[i]; i++)
    {
        if(string[i] == find)
        {
            string[i] = replace;
        }
    }
}

stock token_by_delim(const string[], return_str[], delim, start_index)
{
	new x=0;
	while(string[start_index] != EOS && string[start_index] != delim) {
	    return_str[x] = string[start_index];
	    x++;
	    start_index++;
	}
	return_str[x] = EOS;
	if(string[start_index] == EOS) start_index = (-1);
	return start_index;
}
stock IsNumeric(const string[]) //By Jan "DracoBlue" Schï¿½tze (edited by Gabriel "Larcius" Cordes
{
	new length=strlen(string);
	if(length==0)
	{
		return 0;
	}
	for (new i=0; i<length; i++)
	{
		if (!((string[i] <= '9' && string[i] >= '0') || (i==0 && (string[i]=='-' || string[i]=='+'))))
		{
			return false;
		}
	}
	return 0;
}


stock numberToStipes(Float: num)
{
	new strip[64];
	print("ok");
	for (new i=0; i<floatround(num, floatround_floor); i++)
	{
        format(strip,sizeof(strip), "%s|",strip);
	}
	return strip;
}
