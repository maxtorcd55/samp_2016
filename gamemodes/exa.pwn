// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT


#include <a_samp>
#include <sscanf>
#include <Thread>
#include "../include/exa_speedometer.pwn"
#include "../include/quicksort.pwn"
#include "../include/binarysearch.pwn"

enum needs
{
	Float:food,
	Float:drink,
	Float:pee,
	Float:poo,
	Float:energy,
	Float:hygiene,
	Float:fun

};

new Float:mapIcons[100][5];
new ActivePlayerNeeds = 0;
new playerNeeds[MAX_PLAYERS][needs];
new PlayerText:needShow[6][3][10];
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


	// Don't use these lines if it's a filterscript
	SetGameModeText("eXa");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);

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

	CreateObject(1567, 252.32227, -40.7998, 1001, 0, 0, 270);//object (Gen_wardrobe) (1)
	CreateObject(2523, 254.69901, -19.715, 1001.023, 0, 0, 0);//object (CJ_B_SINK3) (1)
	CreateObject(2518, 258.922, -21.095, 1001.023, 0, 0, 268);//object (CJ_B_SINK2) (1)
	CreateObject(2136, 259.28799, -40.803, 1001.022, 0, 0, 270);//object (CJ_K3_SINK) (2)
	CreateObject(2526, 257.14801, -39.15, 1001.016, 0, 0, 0);//object (CJ_BATH4) (1)
	CreateObject(13007, 250.537, -41.887, 998.86102, 0, 0, 0);//object (sw_bankbits) (2)
	CreateObject(2136, 259.28799, -42.772, 1001.022, 0, 0, 270);//object (CJ_K3_SINK) (4)
	CreateObject(2395, 259.70999, -40.313, 999.55298, 0, 0, 270);//object (CJ_SPORTS_WALL) (2)
	CreateObject(2395, 259.70996, -36.59668, 999.55298, 0, 0, 270);//object (CJ_SPORTS_WALL) (3)
	CreateObject(2395, 259.70999, -37.319, 1002.286, 0, 0, 270);//object (CJ_SPORTS_WALL) (4)
	CreateObject(2395, 259.70996, -43.56445, 1002.286, 0, 0, 270);//object (CJ_SPORTS_WALL) (5)
	CreateObject(2395, 259.70499, -40.165, 1003.661, 0, 0, 270);//object (CJ_SPORTS_WALL) (6)
	CreateObject(13007, 250.537, -41.887, 1006.133, 0, 0, 0);//object (sw_bankbits) (1)
	CreateObject(8656, 253.207, -41.319, 1002.154, 0, 0, 0);//object (shbbyhswall09_lvs) (1)
	CreateObject(8656, 253.201, -40.808, 1003.382, 0, 0, 0);//object (shbbyhswall09_lvs) (2)
	CreateObject(8656, 244.547, -43.828, 1002.154, 0, 0, 90);//object (shbbyhswall09_lvs) (3)
	CreateObject(8656, 244.547, -43.839, 1003.393, 0, 0, 90);//object (shbbyhswall09_lvs) (4)
	CreateObject(8656, 244.502, -38.157, 1002.154, 0, 0, 270);//object (shbbyhswall09_lvs) (5)
	CreateObject(8656, 245.019, -38.146, 1003.387, 0, 0, 270);//object (shbbyhswall09_lvs) (6)
	CreateObject(8656, 259.379, -25.045, 1002.154, 0, 0, 180);//object (shbbyhswall09_lvs) (7)
	CreateObject(8656, 259.38501, -25.039, 1003.393, 0, 0, 179.995);//object (shbbyhswall09_lvs) (8)
	CreateObject(2528, 254.83299, -39.185, 1001.033, 0, 0, 0);//object (CJ_TOILET3) (1)
	CreateObject(2707, 259.25601, -41.019, 1004.321, 0, 0, 0);//object (CJ_LIGHT_FIT) (1)
	CreateObject(2707, 259.25601, -42.64, 1004.321, 0, 0, 0);//object (CJ_LIGHT_FIT) (2)
	CreateObject(2818, 256.96201, -40.896, 1001.033, 0, 0, 0);//object (gb_bedrug02) (1)


	SetTimer("needsTimer", 10, true);
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

forward needsTimer();
public needsTimer()
{
	new plyid = ActivePlayerNeeds;
	ActivePlayerNeeds++;
	if(ActivePlayerNeeds > 100){ActivePlayerNeeds = 0;}
	if(IsPlayerConnected(plyid))
	{
		new Float: health=100.0;
		GetPlayerHealth(plyid,health);
	    playerNeeds[plyid][food] -= 0.3;
		playerNeeds[plyid][drink] -= 0.7;
		playerNeeds[plyid][pee] -= 0.5;
		playerNeeds[plyid][poo] -= 0.1;
		playerNeeds[plyid][energy] -= 0.08;
		playerNeeds[plyid][hygiene] -= 0.06;

		if(playerNeeds[plyid][food] < 0){playerNeeds[plyid][food]=0.0;health-=1.0;}
		if(playerNeeds[plyid][drink] < 0){playerNeeds[plyid][drink]=0.0;health-=2.0;}
		if(playerNeeds[plyid][pee] < 0){playerNeeds[plyid][pee]=100.0;playerNeeds[plyid][hygiene]-=70.0;}
		if(playerNeeds[plyid][poo] < 0){playerNeeds[plyid][poo]=100.0;playerNeeds[plyid][hygiene]-=85.0;}
		if(playerNeeds[plyid][energy] < 0){playerNeeds[plyid][energy]+=5.0;ApplyAnimation(plyid,  "INT_HOUSE", "BED_Loop_L", 4.1, 1, 1, 1, 0, 7000, 0);}
		if(playerNeeds[plyid][hygiene] < 0){playerNeeds[plyid][hygiene]=0.0;health-=0.5;}
		SetPlayerHealth(plyid,health);

		if(playerNeeds[plyid][food] > 100.0){playerNeeds[plyid][food] = 100.0;}
		if(playerNeeds[plyid][drink] > 100.0){playerNeeds[plyid][drink] = 100.0;}
		if(playerNeeds[plyid][pee] > 100.0){playerNeeds[plyid][pee] = 100.0;}
		if(playerNeeds[plyid][poo] > 100.0){playerNeeds[plyid][poo] = 100.0;}
		if(playerNeeds[plyid][energy] > 100.0){playerNeeds[plyid][energy] = 100.0;}
		if(playerNeeds[plyid][hygiene] > 100.0){playerNeeds[plyid][hygiene] = 100.0;}

		for(new need=0; need<6; need++)
		{
		    for(new cols=0; cols<3; cols++)
			{
            	PlayerTextDrawHide(plyid, needShow[need][cols][plyid]);
            }
        }
        new freeTextDraw = 0;

		if(playerNeeds[plyid][food] < 30.0)
	 	{
            PlayerTextDrawTextSize(plyid, needShow[freeTextDraw][2][plyid], 501+(103*(playerNeeds[plyid][food]/100)), 480.0);
            PlayerTextDrawSetString(plyid, needShow[freeTextDraw][2][plyid], "food");
			for(new cols=0; cols<3; cols++)
			{
            	PlayerTextDrawShow(plyid, needShow[freeTextDraw][cols][plyid]);
            }
            freeTextDraw++;
	 	}
		if(playerNeeds[plyid][drink] < 30.0)
	 	{
            PlayerTextDrawTextSize(plyid, needShow[freeTextDraw][2][plyid], 501+(103*(playerNeeds[plyid][drink]/100)), 480.0);
            PlayerTextDrawSetString(plyid, needShow[freeTextDraw][2][plyid], "drink");
			for(new cols=0; cols<3; cols++)
			{
            	PlayerTextDrawShow(plyid, needShow[freeTextDraw][cols][plyid]);
            }
            freeTextDraw++;
	 	}
		if(playerNeeds[plyid][pee] < 30.0)
	 	{
            PlayerTextDrawTextSize(plyid, needShow[freeTextDraw][2][plyid], 501+(103*(playerNeeds[plyid][pee]/100)), 480.0);
            PlayerTextDrawSetString(plyid, needShow[freeTextDraw][2][plyid], "pee");
            for(new cols=0; cols<3; cols++)
			{
            	PlayerTextDrawShow(plyid, needShow[freeTextDraw][cols][plyid]);
            }
            freeTextDraw++;
	 	}
		if(playerNeeds[plyid][poo] < 30.0)
	 	{
            PlayerTextDrawTextSize(plyid, needShow[freeTextDraw][2][plyid], 501+(103*(playerNeeds[plyid][poo]/100)), 480.0);
            PlayerTextDrawSetString(plyid, needShow[freeTextDraw][2][plyid], "poo");
            for(new cols=0; cols<3; cols++)
			{
            	PlayerTextDrawShow(plyid, needShow[freeTextDraw][cols][plyid]);
            }
            freeTextDraw++;
	 	}
		if(playerNeeds[plyid][energy] < 30.0)
	 	{
            PlayerTextDrawTextSize(plyid, needShow[freeTextDraw][2][plyid], 501+(103*(playerNeeds[plyid][energy]/100)), 480.0);
            PlayerTextDrawSetString(plyid, needShow[freeTextDraw][2][plyid], "energy");
            for(new cols=0; cols<3; cols++)
			{
            	PlayerTextDrawShow(plyid, needShow[freeTextDraw][cols][plyid]);
            }
            freeTextDraw++;
	 	}
		if(playerNeeds[plyid][hygiene] < 30.0)
	 	{
            PlayerTextDrawTextSize(plyid, needShow[freeTextDraw][2][plyid], 501+(103*(playerNeeds[plyid][hygiene]/100)), 480.0);
            PlayerTextDrawSetString(plyid, needShow[freeTextDraw][2][plyid], "hygiene");
            for(new cols=0; cols<3; cols++)
			{
            	PlayerTextDrawShow(plyid, needShow[freeTextDraw][cols][plyid]);
            }
            freeTextDraw++;
	 	}






    	if(IsPlayerInRangeOfPoint(plyid, 6, 258.7220,-41.7669,1002.0333))
		{
	       	if(IsPlayerInRangeOfPoint(plyid, 0.5, 258.7220,-41.7669,1002.0333))
		    {
	            GameTextForPlayer(plyid, "Press \"~k~~CONVERSATION_YES~\"", 1100, 3);
		    }
		    else if(IsPlayerInRangeOfPoint(plyid, 0.5, 257.7963,-39.9567,1002.0333))
		    {
	            GameTextForPlayer(plyid, "Press \"~k~~CONVERSATION_YES~\"", 1100, 3);
		    }
		    else if(IsPlayerInRangeOfPoint(plyid, 0.5,  254.8486,-39.8989,1002.0333))
		    {
	            GameTextForPlayer(plyid, "Press \"~k~~CONVERSATION_YES~\"", 1100, 3);
		    }
		}


	}


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
	/* track players */
	players[connectedPlayers] = playerid;
	connectedPlayers++;
	quickSortAsc(players, 0, maxPlayersRight);
	printf("added player: %i, %i players total", playerid, connectedPlayers);
	/* track players */

    resetNeeds(playerid);
	SetPlayerMapIcon(playerid, 0, 2816.40625, 2132.8125, 0, 31, 0, MAPICON_LOCAL);
	SetPlayerMapIcon(playerid, 1, 2367.1875, 2160.15625, 0, 31, 0, MAPICON_LOCAL);
	SetPlayerMapIcon(playerid, 2, 2214.84375, 1837.890625, 0, 31, 0, MAPICON_LOCAL);
	SetPlayerMapIcon(playerid, 3, 1962.890625, 1623.046875, 0, 31, 0, MAPICON_LOCAL);
	SetPlayerMapIcon(playerid, 4, 2248.046875, 1289.0625, 0, 31, 0, MAPICON_LOCAL);
	SetPlayerMapIcon(playerid, 5, 2453.125, 687.5, 0, 31, 0, MAPICON_LOCAL);
	SetPlayerMapIcon(playerid, 6, 1404.296875, 1884.765625, 0, 31, 0, MAPICON_LOCAL);
	SetPlayerMapIcon(playerid, 7, -1529.296875, 2656.25, 0, 31, 0, MAPICON_LOCAL);

	RemoveBuildingForPlayer(playerid, 18088, 257.38281, -40.95312, 1002.9141, 1);
	RemoveBuildingForPlayer(playerid, 2295, 259.23438, -39.74219, 1001.0234, 1);
	RemoveBuildingForPlayer(playerid, 2295, 258.65625, -42.75781, 1001.0234, 1);
	RemoveBuildingForPlayer(playerid, 2406, 259.46744, -43.08805, 1002.0896, 1);
	RemoveBuildingForPlayer(playerid, 2087, 257.80469, -43.84375, 1001.0313, 1);
	RemoveBuildingForPlayer(playerid, 2103, 258.19531, -43.74219, 1002.6953, 1);
	RemoveBuildingForPlayer(playerid, 2654, 258.97656, -36.11719, 1001.2344, 1);
	RemoveBuildingForPlayer(playerid, 2689, 258.82031, -36.14844, 1002.9922, 1);
	RemoveBuildingForPlayer(playerid, 18088, 257.38281, -40.95312, 1002.9141, 1);



	for(new need=0; need<6; need++)
	{

		needShow[need][0][playerid] = CreatePlayerTextDraw(playerid, 498.5,110.0+(need*20), "_");


		PlayerTextDrawTextSize(playerid, needShow[need][0][playerid], 606.3, 480.0);
		PlayerTextDrawLetterSize(playerid, needShow[need][0][playerid],0.4,1.6);
		PlayerTextDrawUseBox(playerid, needShow[need][0][playerid], 1);
	    PlayerTextDrawBoxColor(playerid, needShow[need][0][playerid], 0x000000AA);
	    PlayerTextDrawShow(playerid, needShow[need][0][playerid]);

    	needShow[need][1][playerid] = CreatePlayerTextDraw(playerid, 501.0,112.5+(need*20), "_");
		PlayerTextDrawTextSize(playerid, needShow[need][1][playerid], 604.2, 480.0);
		PlayerTextDrawLetterSize(playerid, needShow[need][1][playerid],0.3,1.0);
		PlayerTextDrawUseBox(playerid, needShow[need][1][playerid], 1);
	    PlayerTextDrawBoxColor(playerid, needShow[need][1][playerid], 0xCC0000AA);
	    PlayerTextDrawShow(playerid, needShow[need][1][playerid]);

		needShow[need][2][playerid] = CreatePlayerTextDraw(playerid, 501.0,112.5+(need*20), "_");
		PlayerTextDrawTextSize(playerid, needShow[need][2][playerid], 504.2, 480.0);
		PlayerTextDrawLetterSize(playerid, needShow[need][2][playerid],0.3,1.0);
		PlayerTextDrawUseBox(playerid, needShow[need][2][playerid], 1);
	    PlayerTextDrawBoxColor(playerid, needShow[need][2][playerid], 0xFF0000AA);
	    PlayerTextDrawShow(playerid, needShow[need][2][playerid]);

		printf("need: %d", needShow[need][0][playerid]);
		printf("need: %d", needShow[need][1][playerid]);
		printf("need: %d", needShow[need][2][playerid]);
	}

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
    resetNeeds(playerid);
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

	if (strcmp("/playerPos", cmd, true, 10) == 0)
	{
		new Float:x, Float:y, Float:z, Float:a;
    	GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
		printf("%f, %f, %f, %f, %d", x, y, z, a, GetPlayerInterior(playerid));
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

	if (strcmp("/food", cmd, true, 10) == 0)
	{
		playerNeeds[playerid][food] += 50.0;
		SendClientMessage(playerid, -1, "food+");
		return 1;
	}
	if (strcmp("/sleep", cmd, true, 10) == 0)
	{
		playerNeeds[playerid][energy] += 50.0;
		SendClientMessage(playerid, -1, "energy+");
		return 1;
	}

	if (strcmp("/reset", cmd, true, 10) == 0)
	{
		resetNeeds(playerid);
		return 1;
	}



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
	if(newkeys == KEY_YES)
	{
       	if(IsPlayerInRangeOfPoint(playerid, 0.5, 258.7220,-41.7669,1002.0333))
	    {
            playerNeeds[playerid][hygiene] += 10.0;
            playerNeeds[playerid][drink] += 25.0;
            SendClientMessage(playerid, -1, "hygiene+\ndrink+");
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 0.5, 257.7963,-39.9567,1002.0333))
	    {
            playerNeeds[playerid][hygiene] += 100.0;
            SendClientMessage(playerid, -1, "hygiene++");
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 0.5,  254.8486,-39.8989,1002.0333))
	    {
            playerNeeds[playerid][pee] += 100.0;
            playerNeeds[playerid][poo] += 100.0;
            SendClientMessage(playerid, -1, "pee++\npoo++");
	    }
	    SendClientMessage(playerid, -1, "kry press");
	}


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

stock resetNeeds(plyid)
{
    playerNeeds[plyid][food] = 100.0;
	playerNeeds[plyid][drink] = 100.0;
	playerNeeds[plyid][pee] = 100.0;
	playerNeeds[plyid][poo] = 100.0;
	playerNeeds[plyid][energy] = 100.0;
	playerNeeds[plyid][hygiene] = 100.0;
	return 1;
}
