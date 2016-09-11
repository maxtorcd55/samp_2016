
new Float:mapIcons[100][5];
new Float:playerNeeds[MAX_PLAYERS][6]; //Behoeftes van player
new PlayerText:needShow[6][3][10]; //Textdraws van Behoeftes
new toggleNeedsTextDraw[MAX_PLAYERS]; //Aan,uit zetten Behoeftes textdraw
new lastPlayerKey[MAX_PLAYERS];
new lastMoney[MAX_PLAYERS];




forward needs_OnGameModeInit();
public needs_OnGameModeInit() {
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
	SetTimer("needsTimer", 300, false);
	return 1;
}



updateNeeds(plyid)
{
	new playerState = GetPlayerState(plyid);
	if(IsPlayerConnected(plyid) && (playerState == 1 || playerState == 2 || playerState == 3))//Is player connected and onfoot,driver,PASSENGER
	{

		new msg[128];
		format(msg, 128, "Running anim: %d", GetPlayerAnimationIndex(plyid));
		SendClientMessage(plyid, -1, msg);

		new Float: health=100.0;
		GetPlayerHealth(plyid,health);

	    playerNeeds[plyid][0] -= 0.2;//food
		playerNeeds[plyid][1] -= 0.6;//drink
		playerNeeds[plyid][2] -= 0.4;//pee
		playerNeeds[plyid][3] -= 0.1;//poo
		if(playerState == 1)//Is player onfoot
		{
			playerNeeds[plyid][4] -= 0.08;//energy
			playerNeeds[plyid][5] -= 0.06;//hygiene
		}
		else
		{
			playerNeeds[plyid][4] -= 0.06;//energy
			playerNeeds[plyid][5] -= 0.04;//hygiene
		}

		if(playerNeeds[plyid][0] < 0){playerNeeds[plyid][0]=0.0;health-=1.0;}//food
		if(playerNeeds[plyid][1] < 0){playerNeeds[plyid][1]=0.0;health-=2.0;}//drink
		if(playerNeeds[plyid][2] < 0){playerNeeds[plyid][2]=100.0;playerNeeds[plyid][5]-=70.0;}//pee
		if(playerNeeds[plyid][3] < 0){playerNeeds[plyid][3]=100.0;playerNeeds[plyid][5]-=85.0;}//poo
		if(playerNeeds[plyid][4] < 0){playerNeeds[plyid][4]+=5.0;ApplyAnimation(plyid,  "INT_HOUSE", "BED_Loop_L", 4.1, 1, 1, 1, 0, 7000, 0);}
		if(playerNeeds[plyid][5] < 0){playerNeeds[plyid][5]=0.0;health-=0.5;}
		SetPlayerHealth(plyid,health);
		new needName[][] = {"food","drink","pee","poo","energy","hygiene"};
		new freeTextDraw = 0;
		for(new need=0; need<=5; need++)
		{

			for(new cols=0; cols<3; cols++)
			{
				PlayerTextDrawHide(plyid, needShow[need][cols][plyid]);
			}

			if(playerNeeds[plyid][need] > 100.0){playerNeeds[plyid][need] = 100.0;}
			if(playerNeeds[plyid][need] < 30.0 || (lastPlayerKey[plyid] & KEY_NO))
			{
				toggleNeedsTextDraw[plyid] = 1;
				PlayerTextDrawTextSize(plyid, needShow[freeTextDraw][2][plyid], 498+(101*(playerNeeds[plyid][need]/100)), 480.0);
				PlayerTextDrawSetString(plyid, needShow[freeTextDraw][2][plyid], needName[need]);
				for(new cols=0; cols<3; cols++)
				{
					PlayerTextDrawShow(plyid, needShow[freeTextDraw][cols][plyid]);
				}
				freeTextDraw++;
			}
        }

		if(GetPlayerInterior(plyid) != 0)
		{
			new money = GetPlayerMoney(plyid);
			if(lastMoney[plyid] - money >= 2)
			{
				playerNeeds[plyid][0] += (7*lastMoney[plyid] - money);
				playerNeeds[plyid][1] += 100;
			}
			lastMoney[plyid] = money;
		}


    	if(GetPlayerInterior(plyid) == 14 && IsPlayerInRangeOfPoint(plyid, 6, 258.7220,-41.7669,1002.0333))
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
		toggleNeedsTextDraw[plyid] = 1;
	}
	else
	{
		if(toggleNeedsTextDraw[plyid] == 1)
		{
			for(new need=0; need<=5; need++)
			{
				for(new cols=0; cols<3; cols++)
				{
					PlayerTextDrawHide(plyid, needShow[need][cols][plyid]);
				}
			}
			toggleNeedsTextDraw[plyid] = 0;
		}
	}

}


/*timer*/

forward needsTimer();
public needsTimer()
{
	if (connectedPlayers > 0)
	{
		static playerindex = 0;
		if (playerindex >= connectedPlayers)
		{ // index higher than connected players -> reset
			playerindex = 0;
			updateNeeds(players[playerindex]);
		}
		else
		{
			playerindex++;
			updateNeeds(players[playerindex]);
		}
		SetTimer("needsTimer", 3000/connectedPlayers, false);
	}
	else
	{
		SetTimer("needsTimer", 5000, false);
	}

}

forward needs_OnPlayerConnect(playerid);
public needs_OnPlayerConnect(playerid)
{
	toggleNeedsTextDraw[playerid] = 1;
    resetNeeds(playerid);
	SetPlayerMapIcon(playerid, 0*playerid, 2816.40625, 2132.8125, 0, 31, 0, MAPICON_LOCAL);
	SetPlayerMapIcon(playerid, 1*playerid, 2367.1875, 2160.15625, 0, 31, 0, MAPICON_LOCAL);
	SetPlayerMapIcon(playerid, 2*playerid, 2214.84375, 1837.890625, 0, 31, 0, MAPICON_LOCAL);
	SetPlayerMapIcon(playerid, 3*playerid, 1962.890625, 1623.046875, 0, 31, 0, MAPICON_LOCAL);
	SetPlayerMapIcon(playerid, 4*playerid, 2248.046875, 1289.0625, 0, 31, 0, MAPICON_LOCAL);
	SetPlayerMapIcon(playerid, 5*playerid, 2453.125, 687.5, 0, 31, 0, MAPICON_LOCAL);
	SetPlayerMapIcon(playerid, 6*playerid, 1404.296875, 1884.765625, 0, 31, 0, MAPICON_LOCAL);
	SetPlayerMapIcon(playerid, 7*playerid, -1529.296875, 2656.25, 0, 31, 0, MAPICON_LOCAL);

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
		PlayerTextDrawSetShadow(playerid, needShow[need][0][playerid], 0);

    	needShow[need][1][playerid] = CreatePlayerTextDraw(playerid, 501.0,112.5+(need*20), "_");
		PlayerTextDrawTextSize(playerid, needShow[need][1][playerid], 604.2, 480.0);
		PlayerTextDrawLetterSize(playerid, needShow[need][1][playerid],0.3,1.0);
		PlayerTextDrawUseBox(playerid, needShow[need][1][playerid], 1);
	    PlayerTextDrawBoxColor(playerid, needShow[need][1][playerid], 0xCC0000AA);
	    PlayerTextDrawShow(playerid, needShow[need][1][playerid]);
		PlayerTextDrawSetShadow(playerid, needShow[need][1][playerid], 0);

		needShow[need][2][playerid] = CreatePlayerTextDraw(playerid, 501.0,112.5+(need*20), "_");
		PlayerTextDrawTextSize(playerid, needShow[need][2][playerid], 504.2, 480.0);
		PlayerTextDrawLetterSize(playerid, needShow[need][2][playerid],0.3,1.0);
		PlayerTextDrawUseBox(playerid, needShow[need][2][playerid], 1);
	    PlayerTextDrawBoxColor(playerid, needShow[need][2][playerid], 0xFF0000AA);
	    PlayerTextDrawShow(playerid, needShow[need][2][playerid]);
		PlayerTextDrawSetShadow(playerid, needShow[need][2][playerid], 0);


	}
}

forward needs_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
public needs_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	lastPlayerKey[playerid] = newkeys;
	if(newkeys == KEY_YES)
	{
		//{"food","drink","pee","poo","energy","hygiene"};
       	if(IsPlayerInRangeOfPoint(playerid, 0.5, 258.7220,-41.7669,1002.0333))
	    {
            playerNeeds[playerid][5] += 10.0;
            playerNeeds[playerid][1] += 25.0;
            SendClientMessage(playerid, -1, "hygiene+\ndrink+");
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 0.5, 257.7963,-39.9567,1002.0333))
	    {
            playerNeeds[playerid][5] += 100.0;
            SendClientMessage(playerid, -1, "hygiene++");
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 0.5,  254.8486,-39.8989,1002.0333))
	    {
            playerNeeds[playerid][2] += 100.0;
            playerNeeds[playerid][3] += 100.0;
            SendClientMessage(playerid, -1, "pee++\npoo++");
	    }
	}
}

forward needs_OnPlayerSpawn(playerid);
public needs_OnPlayerSpawn(playerid)
{
	resetNeeds(playerid);
}

forward needs_OnPlayerCommandText(playerid, cmd[], params[]);
public needs_OnPlayerCommandText(playerid, cmd[], params[])
{


	if (strcmp("/reset", cmd, true, 10) == 0)
	{
		resetNeeds(playerid);
		return 1;
	}

	return 0;
}

resetNeeds(plyid)
{
    playerNeeds[plyid][0] = 100.0;
	playerNeeds[plyid][1] = 100.0;
	playerNeeds[plyid][2] = 100.0;
	playerNeeds[plyid][3] = 100.0;
	playerNeeds[plyid][4] = 100.0;
	playerNeeds[plyid][5] = 100.0;
	return 1;
}
