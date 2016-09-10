// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT


#include <a_samp>
#include <sscanf>
#include <Thread>
#include "../include/exa_speedometer.pwn"
#include "../include/quicksort.pwn"
#include "../include/binarysearch.pwn"
#include "../include/needs.pwn"




new maxPlayers;
new connectedPlayers = 0;
new players[MAX_PLAYERS] = {MAX_PLAYERS,...};
new maxPlayersRight = MAX_PLAYERS-1;

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
	maxPlayers = GetMaxPlayers();
	//xdfds
	OnGameModeInitNeeds();

	// Don't use these lines if it's a filterscript
	SetGameModeText("eXa");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
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

	SetTimer("onTimer300", 300/maxPlayers, true);




	return 1;
}

forward onTimer300();
public onTimer300()
{
	static timer300Index = 0;
	if (IsPlayerConnected(timer300Index)) {
		speedoUpdate(timer300Index);
	}
	if (timer300Index == maxPlayers){
		timer300Index = 0;
	} else {
		timer300Index++;
	}
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

	OnPlayerConnectNeeds(playerid);

	/* track players */
	players[connectedPlayers] = playerid;
	connectedPlayers++;
	quickSortAsc(players, 0, maxPlayersRight);
	printf("added player: %i, %i players total", playerid, connectedPlayers);
	/* track players */



	createSpeedoMeter(playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	/* track players */
	new playerindex = binarySearch(players, MAX_PLAYERS, playerid);
	if (playerindex == -1) {
		print("[ERROR] binarySearch failed");
	} else {
		players[playerindex] = MAX_PLAYERS;
	}
	connectedPlayers--;
	quickSortAsc(players, 0, maxPlayersRight);
	printf("removed player: %i from index %i, %i players remaining", playerid, playerindex, connectedPlayers);
	/* track players */

	return 1;
}

public OnPlayerSpawn(playerid)
{
	OnPlayerSpawnNeeds(playerid);
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
	    new icon;
		if(!sscanf(params, "d" ,icon))
		{

			new Float:x, Float:y, Float:z;
	    	GetPlayerPos(playerid, x, y, z);
	    	new string[128];
			format(string,sizeof(string),"SetPlayerMapIcon(playerid, 0, %f, %f, %f, %d, 0, MAPICON_LOCAL);\r\n",x, y, z,icon);
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



	if(OnPlayerCommandTextNeeds(playerid, cmd, params)){return 1;}



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
	OnPlayerKeyStateChangeNeeds(playerid, newkeys, oldkeys);

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
