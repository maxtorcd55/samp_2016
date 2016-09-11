// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT


#include <a_samp>


new AntiFallOffBike[5][MAX_PLAYERS];

native IsValidVehicle(vehicleid);

new VehName[213][] =
{
        {"Landstalker"},
        {"Bravura"},
        {"Buffalo"},
        {"Linerunner"},
        {"Perrenial"},
        {"Sentinel"},
        {"Dumper"},
        {"Firetruck"},
        {"Trashmaster"},
        {"Stretch"},
        {"Manana"},
        {"Infernus"},
        {"Voodoo"},
        {"Pony"},
        {"Mule"},
        {"Cheetah"},
        {"Ambulance"},
        {"Leviathan"},
        {"Moonbeam"},
        {"Esperanto"},
        {"Taxi"},
        {"Washington"},
        {"Bobcat"},
        {"Mr Whoopee"},
        {"BF Injection"},
        {"Hunter"},
        {"Premier"},
        {"Enforcer"},
        {"Securicar"},
        {"Banshee"},
        {"Predator"},
        {"Bus"},
        {"Rhino"},
        {"Barracks"},
        {"Hotknife"},
        {"Trailer 1"},
        {"Previon"},
        {"Coach"},
        {"Cabbie"},
        {"Stallion"},
        {"Rumpo"},
        {"RC Bandit"},
        {"Romero"},
        {"Packer"},
        {"Monster"},
        {"Admiral"},
        {"Squalo"},
        {"Seasparrow"},
        {"Pizzaboy"},
        {"Tram"},
        {"Trailer 2"},
        {"Turismo"},
        {"Speeder"},
        {"Reefer"},
        {"Tropic"},
        {"Flatbed"},
        {"Yankee"},
        {"Caddy"},
        {"Solair"},
        {"Berkley's RC Van"},
        {"Skimmer"},
        {"PCJ-600"},
        {"Faggio"},
        {"Freeway"},
        {"RC Baron"},
        {"RC Raider"},
        {"Glendale"},
        {"Oceanic"},
        {"Sanchez"},
        {"Sparrow"},
        {"Patriot"},
        {"Quad"},
        {"Coastguard"},
        {"Dinghy"},
        {"Hermes"},
        {"Sabre"},
        {"Rustler"},
        {"ZR-350"},
        {"Walton"},
        {"Regina"},
        {"Comet"},
        {"BMX"},
        {"Burrito"},
        {"Camper"},
        {"Marquis"},
        {"Baggage"},
        {"Dozer"},
        {"Maverick"},
        {"News Chopper"},
        {"Rancher"},
        {"FBI Rancher"},
        {"Virgo"},
        {"Greenwood"},
        {"Jetmax"},
        {"Hotring"},
        {"Sandking"},
        {"Blista Compact"},
        {"Police Maverick"},
        {"Boxville"},
        {"Benson"},
        {"Mesa"},
        {"RC Goblin"},
        {"Hotring Racer A"},
        {"Hotring Racer B"},
        {"Bloodring Banger"},
        {"Rancher"},
        {"Super GT"},
        {"Elegant"},
        {"Journey"},
        {"Bike"},
        {"Mountain Bike"},
        {"Beagle"},
        {"Cropdust"},
        {"Stunt"},
        {"Tanker"},
        {"Roadtrain"},
        {"Nebula"},
        {"Majestic"},
        {"Buccaneer"},
        {"Shamal"},
        {"Hydra"},
        {"FCR-900"},
        {"NRG-500"},
        {"HPV1000"},
        {"Cement Truck"},
        {"Tow Truck"},
        {"Fortune"},
        {"Cadrona"},
        {"FBI Truck"},
        {"Willard"},
        {"Forklift"},
        {"Tractor"},
        {"Combine"},
        {"Feltzer"},
        {"Remington"},
        {"Slamvan"},
        {"Blade"},
        {"Freight"},
        {"Streak"},
        {"Vortex"},
        {"Vincent"},
        {"Bullet"},
        {"Clover"},
        {"Sadler"},
        {"Firetruck LA"},
        {"Hustler"},
        {"Intruder"},
        {"Primo"},
        {"Cargobob"},
        {"Tampa"},
        {"Sunrise"},
        {"Merit"},
        {"Utility"},
        {"Nevada"},
        {"Yosemite"},
        {"Windsor"},
        {"Monster A"},
        {"Monster B"},
        {"Uranus"},
        {"Jester"},
        {"Sultan"},
        {"Stratum"},
        {"Elegy"},
        {"Raindance"},
        {"RC Tiger"},
        {"Flash"},
        {"Tahoma"},
        {"Savanna"},
        {"Bandito"},
        {"Freight Flat"},
        {"Streak Carriage"},
        {"Kart"},
        {"Mower"},
        {"Duneride"},
        {"Sweeper"},
        {"Broadway"},
        {"Tornado"},
        {"AT-400"},
        {"DFT-30"},
        {"Huntley"},
        {"Stafford"},
        {"BF-400"},
        {"Newsvan"},
        {"Tug"},
        {"Trailer 3"},
        {"Emperor"},
        {"Wayfarer"},
        {"Euros"},
        {"Hotdog"},
        {"Club"},
        {"Freight Carriage"},
        {"Trailer 3"},
        {"Andromada"},
        {"Dodo"},
        {"RC Cam"},
        {"Launch"},
        {"Police Car (LSPD)"},
        {"Police Car (SFPD)"},
        {"Police Car (LVPD)"},
        {"Police Ranger"},
        {"Picador"},
        {"S.W.A.T. Van"},
        {"Alpha"},
        {"Phoenix"},
        {"Glendale"},
        {"Sadler"},
        {"Luggage Trailer A"},
        {"Luggage Trailer B"},
        {"Stair Trailer"},
        {"Boxville"},
        {"Farm Plow"},
        {"Utility Trailer"},
        {""}
};




new VehMenuSelectDialog[] = {101,102,103,104,105};
new VehStuck[] = {111};
new VehStuckRemind[MAX_PLAYERS];
new VehicleCategories[5][1024];
new VehicleSelect[MAX_PLAYERS][41];
new PlayerLastVehicle[MAX_PLAYERS][5];
new VehMenuDialog[] = {111,112,113};
new PlayerVehFound[MAX_PLAYERS][210];


#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

#endif


public OnGameModeInit()
{

    VehicleCategories[1] = "Air Vehicles:\n    Airplanes\n    Helicopters\n ";
    VehicleCategories[2] = "Land Vehicles:\n    Bikes\n    Convertibles\n    Industrial\n    Lowriders\n    Off Road\n    Public Service Vehicles\n    Saloons\n    Sport Vehicles\n    Station Wagons\n ";
    VehicleCategories[3] = "Water Vehicles:\n    Boats\n ";
    VehicleCategories[4] = "Miscellaneous Vehicles:\n    Trailers\n    Unique Vehicles\n    RC Vehicles\n ";
	SetTimer("VehicleFix", 2000, true);


	return 1;
}

forward VehicleFix();
public VehicleFix()
{
	for(new i; i<MAX_PLAYERS; i++)
    {
		if(IsPlayerConnected(i))
		{
            if(IsPlayerInAnyVehicle(i))
            {
            	new veh = GetPlayerVehicleID(i);
    			new Float:health;
				GetVehicleHealth(veh, health);

                if(health <= 250)
				{
                    SetVehicleHealth(veh, 1000);
                    RepairVehicle(veh);
				}

            }

		}
	}

    return 1;
}


public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{

	return 1;
}



public OnPlayerConnect(playerid)
{
    PlayerLastVehicle[playerid][0] = 0;
    VehStuckRemind[playerid] = 0;
    AntiFallOffBike[0][playerid] = 0;
    AntiFallOffBike[1][playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
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

	if (strcmp("/af", cmdtext, true, 10) == 0)
	{
	    if(AntiFallOffBike[1][playerid] == 0)
	    {
	        AntiFallOffBike[1][playerid] = 1;

	        if(IsPlayerInAnyVehicle(playerid))
	        {
		        AntiFallOffBike[0][playerid] = 1;
				AntiFallOffBike[2][playerid] = GetPlayerVehicleID(playerid);
			}
	        SendClientMessage(playerid, 0x00FFFFFF, "Anti fall off bike is ON");
	    }
	    else
	    {
	        AntiFallOffBike[1][playerid] = 0;
	        SendClientMessage(playerid, 0x00FFFFFF, "Anti fall off bike is OFF");
	    }
		return 1;
	}


	if (strcmp("/sv", cmdtext, true, 10) == 0)
	{
		ShowPlayerDialog(playerid,VehMenuDialog[0], DIALOG_STYLE_INPUT, "Spawn Vehicle", "Enter a vehicle name:", "Enter", "Cancel");
		return 1;
	}

	if ((strcmp("/v", cmdtext, true, 10) == 0) || (strcmp("/veh", cmdtext, true, 10) == 0) || (strcmp("/vehicle", cmdtext, true, 10) == 0))
	{

		ShowVehicleDialog(playerid);
		return 1;
	}

	if (strcmp("/eject", cmdtext, true, 10) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
	 		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 569||570||449||441||464||465||501||564||465)
			{
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				SetPlayerPos(playerid, x+0.5, y, z+1.0);

	        }
		}

		return 1;
	}

    if (strcmp("/flip", cmdtext, true, 10) == 0)
    {
  		if(IsPlayerInAnyVehicle(playerid))
		{
	        new currentveh;
	        new Float:angle;
	        currentveh = GetPlayerVehicleID(playerid);
	        GetVehicleZAngle(currentveh, angle);
	        SetVehicleZAngle(currentveh, angle);
	        SendClientMessage(playerid, 0xFFFFFFFF, "Your vehicle has been flipped.");
		}
		else
		{
		    SendClientMessage(playerid, 0xFFFFFFFF, "You can only use this command in a vehicle.");
		}
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
    AntiFallOffBike[0][playerid] = 0;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{

	if(AntiFallOffBike[1][playerid] == 1)
    {
		if(oldstate == PLAYER_STATE_DRIVER)
		{
			if(newstate == PLAYER_STATE_ONFOOT)
			{
				if(AntiFallOffBike[0][playerid] == 1)
				{
 					PutPlayerInVehicle(playerid, AntiFallOffBike[2][playerid], 0);
				}
   			}
      	}
       	if(oldstate == PLAYER_STATE_PASSENGER)
        {
			if(newstate == PLAYER_STATE_ONFOOT)
   			{
				if(AntiFallOffBike[0][playerid] == 1)
   				{
                	PutPlayerInVehicle(playerid, AntiFallOffBike[2][playerid], 1);
      			}
       		}
		}
  		if(oldstate == PLAYER_STATE_ONFOOT)
    	{
     		if(newstate == PLAYER_STATE_DRIVER || PLAYER_STATE_PASSENGER)
			{
				AntiFallOffBike[0][playerid] = 1;
				AntiFallOffBike[2][playerid] = GetPlayerVehicleID(playerid);
			}
		}
	}


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
    if(newkeys == KEY_SECONDARY_ATTACK )
	{

        if(!IsPlayerInAnyVehicle(playerid))
		{

			for(new i = 1; i < MAX_VEHICLES; i++)
			{
				if(GetVehicleModel(i) > 0)
				{

		  			if((GetVehicleModel(i) == 569)||(GetVehicleModel(i) ==570)||(GetVehicleModel(i) == 449)||(GetVehicleModel(i) == 441)||(GetVehicleModel(i) ==464)||(GetVehicleModel(i) == 465)||(GetVehicleModel(i) == 501)||(GetVehicleModel(i) == 564)||(GetVehicleModel(i) == 465))
					{

			        	new Float:x, Float:y, Float:z;
		         		GetVehiclePos(i,x,y,z);
			       	    if(IsPlayerInRangeOfPoint(playerid, 5.0, x,y,z))
			    		{

			       			PutPlayerInVehicle(playerid, i, 0);

			   			}


					}
				}
			}



        }




        else
		{

        	if((GetVehicleModel(playerid) == 569)||(GetVehicleModel(playerid) ==570)||(GetVehicleModel(playerid) == 449)||(GetVehicleModel(playerid) == 441)||(GetVehicleModel(playerid) ==464)||(GetVehicleModel(playerid) == 465)||(GetVehicleModel(playerid) == 501)||(GetVehicleModel(playerid) == 564)||(GetVehicleModel(playerid) == 465))
            {

                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x, y, z);
                SetPlayerPos(playerid, x+0.5, y, z+1.0);
                SetCameraBehindPlayer(playerid);
            }
        }
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



    if(dialogid == VehMenuSelectDialog[0])
    {
		if(response)
        {

			new VehNameCombine[1500];
			new LastVehicleToggle = 0;
			if(PlayerLastVehicle[playerid][0] == 1)
			{
				LastVehicleToggle = 2;
 				if(listitem == 0)//LastVeh
				{
					CreateVeh(playerid,PlayerLastVehicle[playerid][1]);
				}
			}


			if(listitem == 1+LastVehicleToggle)//Airplanes
			{
				format(VehNameCombine,sizeof(VehNameCombine), "%s\n",VehicleIdToName(playerid,460,476,511,512,513,519,520,553,577,592,593));
			}

   			if(listitem == 2+LastVehicleToggle)//Helicopters
			{
				format(VehNameCombine,sizeof(VehNameCombine), "%s\n",VehicleIdToName(playerid,548,425,417,487,488,497,563,447,469));
			}

	        if(listitem == 5+LastVehicleToggle)//Bikes
			{
                format(VehNameCombine,sizeof(VehNameCombine), "%s\n",VehicleIdToName(playerid,509,481,510,462,448,581,522,461,521,523,463,586,468,471));
			}
	        if(listitem == 6+LastVehicleToggle)//Convertibles
			{
                format(VehNameCombine,sizeof(VehNameCombine), "%s\n",VehicleIdToName(playerid,480,533,439,555));
			}
	        if(listitem == 7+LastVehicleToggle)//Industrial
			{
                format(VehNameCombine,sizeof(VehNameCombine), "%s\n%s\n",VehicleIdToName(playerid,499,422,482,498,609,524,578,455,403,414,582,443,514,600,413,515,440,543,605,459),VehicleIdToName1(playerid,531,408,552,478,456,554));
			}
	        if(listitem == 8+LastVehicleToggle)//Lowriders
			{
                format(VehNameCombine,sizeof(VehNameCombine), "%s\n",VehicleIdToName(playerid,536,575,534,567,535,566,576,412));
			}
	        if(listitem == 9+LastVehicleToggle)//Off Road
			{
                format(VehNameCombine,sizeof(VehNameCombine), "%s\n",VehicleIdToName(playerid,568,424,573,579,400,500,444,556,557,470,489,505));
			}
	        if(listitem == 10+LastVehicleToggle)//Public Service Vehicles
			{
                format(VehNameCombine,sizeof(VehNameCombine), "%s\n",VehicleIdToName(playerid,416,433,431,438,437,523,427,490,528,407,544,596,598,597,599,432,601,420));
			}
	        if(listitem == 11+LastVehicleToggle)//Saloons
			{
                format(VehNameCombine,sizeof(VehNameCombine), "%s\n%s\n",VehicleIdToName(playerid,445,504,401,518,527,542,507,562,585,419,526,419,526,604,466,492,474,546,517,410),VehicleIdToName1(playerid,551,516,467,426,436,547,405,580,560,550,549,540,491,529,421));
			}
	        if(listitem == 12+LastVehicleToggle)//Sport Vehicles
			{
                format(VehNameCombine,sizeof(VehNameCombine), "%s\n",VehicleIdToName(playerid,602,429,496,402,541,415,589,587,565,494,502,503,411,559,603,475,506,451,558,477));
			}
	        if(listitem == 13+LastVehicleToggle)//Station Wagons
			{
                format(VehNameCombine,sizeof(VehNameCombine), "%s\n",VehicleIdToName(playerid,418,404,479,458,561));
			}
	        if(listitem == 16+LastVehicleToggle)//Boats
			{
                format(VehNameCombine,sizeof(VehNameCombine), "%s\n",VehicleIdToName(playerid,472,473,493,595,484,430,453,452,446,454));
			}
	        if(listitem == 19+LastVehicleToggle)//Trailers
			{
                format(VehNameCombine,sizeof(VehNameCombine), "%s\n",VehicleIdToName(playerid,435,450,569,570,584,590,591,606,607,608,610,611));
			}
	        if(listitem == 20+LastVehicleToggle)//Unique Vehicles
			{
                format(VehNameCombine,sizeof(VehNameCombine), "%s\n%s\n",VehicleIdToName(playerid,406,409,423,428,434,442,449,457,483,486,508,525,530,532,537,538,539,545,571,572),VehicleIdToName1(playerid,574,583,588));
			}
	        if(listitem == 21+LastVehicleToggle)//RC Vehicles
			{
                format(VehNameCombine,sizeof(VehNameCombine), "%s\n",VehicleIdToName(playerid,441,464,465,501,564));
			}
			if((listitem == 0+LastVehicleToggle)||(listitem == 4+LastVehicleToggle)||(listitem == 15+LastVehicleToggle)||(listitem == 18+LastVehicleToggle))
			{
    			ShowPlayerDialog(playerid, VehMenuSelectDialog[3], DIALOG_STYLE_MSGBOX, "Notice", "Select an subcategory", "Ok", "");
			}
			else if((listitem == 3+LastVehicleToggle)||(listitem == 14+LastVehicleToggle)||(listitem == 17+LastVehicleToggle)||(listitem == 22+LastVehicleToggle))
			{
				ShowVehicleDialog(playerid);
			}
			else if((listitem == 23+LastVehicleToggle))
			{
				ShowPlayerDialog(playerid,VehMenuDialog[0], DIALOG_STYLE_INPUT, "Spawn Vehicle", "Enter a vehicle name:", "Enter", "Cancel");
			}
			else
			{
				ShowPlayerDialog(playerid,VehMenuSelectDialog[2], DIALOG_STYLE_LIST, "Select Vehicle", VehNameCombine, "Enter", "Back");
			}


		}
		else
		{



		}
        return 1;
    }





   	if(dialogid == VehMenuSelectDialog[3])
    {
		if(response)
        {
			ShowVehicleDialog(playerid);
        }

        return 1;
    }

	if(dialogid == VehMenuSelectDialog[2])
    {
		if(response)
        {
            CreateVeh(playerid,VehicleSelect[playerid][listitem+1]);
        }
        else
        {
        	ShowVehicleDialog(playerid);
        }

        return 1;
    }







	if(dialogid == VehMenuDialog[0])
    {
		if(response)
        {
            new foundveh[3024];
            new foundvehnum;
       		for(new i = 0; i < 211; i++)
			{
		 		if(strfind(VehName[i], inputtext, true) != -1)
				 {
					format(foundveh,sizeof(foundveh),"%s\n%s",foundveh,VehName[i]);
					PlayerVehFound[playerid][foundvehnum] = i+400;
					foundvehnum++;

				 }
			}
			if(foundvehnum == 1){CreateVeh(playerid,PlayerVehFound[playerid][0]);}
			else
			{
			    new foundvehcount[50];
			    format(foundvehcount,sizeof(foundvehcount),"Vehicles found: %d",foundvehnum);
				ShowPlayerDialog(playerid, VehMenuDialog[1], DIALOG_STYLE_LIST, foundvehcount, foundveh, "spawn", "close");
			}
        }

        return 1;
    }

	if(dialogid == VehMenuDialog[1])
    {
		if(response)
        {

	        CreateVeh(playerid,PlayerVehFound[playerid][listitem]);

		}
        return 1;
    }

   	if(dialogid == VehStuck[0])
    {
		if(!response)
        {

	        VehStuckRemind[playerid] =  1;

		}
        return 1;
    }

	return 0;
}





stock ShowVehicleDialog(playerid)
{
    if(IsPlayerInAnyVehicle(playerid)) return ShowPlayerDialog(playerid, VehMenuSelectDialog[4], DIALOG_STYLE_MSGBOX, "Notice", "You can't use this command in a vehicle.", "Close", "");
	new string[500];
	if(PlayerLastVehicle[playerid][0] == 0)
	{
		format(string,sizeof(string), "%s\n%s\n%s\n%s\nSearch by name (/sv)",VehicleCategories[1],VehicleCategories[2],VehicleCategories[3],VehicleCategories[4]);
	}
	else
	{
		format(string,sizeof(string), "Last Vehicle: %s\n \n%s\n%s\n%s\n%s\nSearch by name (/sv)",VehName[PlayerLastVehicle[playerid][1]-400],VehicleCategories[1],VehicleCategories[2],VehicleCategories[3],VehicleCategories[4]);
	}
	ShowPlayerDialog(playerid,VehMenuSelectDialog[0], DIALOG_STYLE_LIST, "Select category", string, "Enter", "Cancel");

	return 1;
}

stock VehicleIdToName(playerid,id1=612,id2=612,id3=612,id4=612,id5=612,id6=612,id7=612,id8=612,id9=612,id10=612,id11=612,id12=612,id13=612,id14=612,id15=612,id16=612,id17=612,id18=612,id19=612,id20=612)
{
	new VehicleIdToNameString1[150] = "error";
	new VehicleIdToNameString2[150] = "error";
    new VehicleIdToNameStringCombine[250] = "error";
	format(VehicleIdToNameString1,sizeof(VehicleIdToNameString1), "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n",VehName[id1-400],VehName[id2-400],VehName[id3-400],VehName[id4-400],VehName[id5-400],VehName[id6-400],VehName[id7-400],VehName[id8-400],VehName[id9-400],VehName[id10-400]);
	format(VehicleIdToNameString2,sizeof(VehicleIdToNameString2), "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n",VehName[id11-400],VehName[id12-400],VehName[id13-400],VehName[id14-400],VehName[id15-400],VehName[id16-400],VehName[id17-400],VehName[id18-400],VehName[id19-400],VehName[id20-400]);
	format(VehicleIdToNameStringCombine,sizeof(VehicleIdToNameStringCombine), "%s\n%s",VehicleIdToNameString1,VehicleIdToNameString2);

	VehicleSelect[playerid][1]=id1;VehicleSelect[playerid][2]=id2;VehicleSelect[playerid][3]=id3;VehicleSelect[playerid][4]=id4;VehicleSelect[playerid][5]=id5;
	VehicleSelect[playerid][6]=id6;VehicleSelect[playerid][7]=id7;VehicleSelect[playerid][8]=id8;VehicleSelect[playerid][9]=id9;VehicleSelect[playerid][10]=id10;
	VehicleSelect[playerid][11]=id11;VehicleSelect[playerid][12]=id12;VehicleSelect[playerid][13]=id13;VehicleSelect[playerid][14]=id14;VehicleSelect[playerid][15]=id15;
	VehicleSelect[playerid][16]=id16;VehicleSelect[playerid][17]=id17;VehicleSelect[playerid][18]=id18;VehicleSelect[playerid][19]=id19;VehicleSelect[playerid][20]=id20;


	return VehicleIdToNameStringCombine;
}

stock VehicleIdToName1(playerid,id1=612,id2=612,id3=612,id4=612,id5=612,id6=612,id7=612,id8=612,id9=612,id10=612,id11=612,id12=612,id13=612,id14=612,id15=612,id16=612,id17=612,id18=612,id19=612,id20=612)
{
	new VehicleIdToNameString1[150] = "error";
	new VehicleIdToNameString2[150] = "error";
    new VehicleIdToNameStringCombine[250] = "error";
	format(VehicleIdToNameString1,sizeof(VehicleIdToNameString1), "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n",VehName[id1-400],VehName[id2-400],VehName[id3-400],VehName[id4-400],VehName[id5-400],VehName[id6-400],VehName[id7-400],VehName[id8-400],VehName[id9-400],VehName[id10-400]);
	format(VehicleIdToNameString2,sizeof(VehicleIdToNameString2), "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n",VehName[id11-400],VehName[id12-400],VehName[id13-400],VehName[id14-400],VehName[id15-400],VehName[id16-400],VehName[id17-400],VehName[id18-400],VehName[id19-400],VehName[id20-400]);
	format(VehicleIdToNameStringCombine,sizeof(VehicleIdToNameStringCombine), "%s\n%s",VehicleIdToNameString1,VehicleIdToNameString2);

	VehicleSelect[playerid][21]=id1;VehicleSelect[playerid][22]=id2;VehicleSelect[playerid][23]=id3;VehicleSelect[playerid][24]=id4;VehicleSelect[playerid][25]=id5;
	VehicleSelect[playerid][26]=id6;VehicleSelect[playerid][27]=id7;VehicleSelect[playerid][28]=id8;VehicleSelect[playerid][29]=id9;VehicleSelect[playerid][30]=id10;
	VehicleSelect[playerid][31]=id11;VehicleSelect[playerid][32]=id12;VehicleSelect[playerid][33]=id13;VehicleSelect[playerid][34]=id14;VehicleSelect[playerid][35]=id15;
	VehicleSelect[playerid][36]=id16;VehicleSelect[playerid][37]=id17;VehicleSelect[playerid][38]=id18;VehicleSelect[playerid][39]=id19;VehicleSelect[playerid][40]=id20;

	return VehicleIdToNameStringCombine;
}

stock CreateVeh(playerid,vehicleid)
{
	if(IsPlayerInAnyVehicle(playerid)) return 0;
 	new Float:plyx, Float:plyy, Float:plyz, Float:plyr,PlyVehId;
	GetPlayerPos(playerid, plyx, plyy, plyz);
	GetPlayerFacingAngle(playerid, plyr);
	PlyVehId =  AddStaticVehicleEx(vehicleid, plyx, plyy, plyz+1, plyr, -1, -1, 999999999999);
	if(GetPlayerInterior(playerid)) LinkVehicleToInterior(PlyVehId,GetPlayerInterior(playerid));
	SetVehicleVirtualWorld(PlyVehId,GetPlayerVirtualWorld(playerid));
	PutPlayerInVehicle(playerid,PlyVehId,0);
	PlayerLastVehicle[playerid][0] = 1;
	if(IsValidVehicle(PlayerLastVehicle[playerid][4])){DestroyVehicle(PlayerLastVehicle[playerid][4]);}
	PlayerLastVehicle[playerid][4] = PlayerLastVehicle[playerid][3];
	PlayerLastVehicle[playerid][3] = PlayerLastVehicle[playerid][2];
	PlayerLastVehicle[playerid][2] = PlyVehId;
	PlayerLastVehicle[playerid][1] = vehicleid;

	AntiFallOffBike[0][playerid] = 1;
	AntiFallOffBike[2][playerid] = GetPlayerVehicleID(playerid);


	return 1;
}
