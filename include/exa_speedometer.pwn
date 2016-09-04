new PlayerText:SpeedoMeter[MAX_PLAYERS];


/*OnPlayerConnect*/
forward createSpeedoMeter(playerid);
public createSpeedoMeter(playerid) {
	SpeedoMeter[playerid] = CreatePlayerTextDraw(playerid, 530.0, 380.0, " ");
	PlayerTextDrawTextSize(playerid, SpeedoMeter[playerid], 620.0, 480.0);
	PlayerTextDrawLetterSize(playerid, SpeedoMeter[playerid],0.3,1.0);
	PlayerTextDrawUseBox(playerid, SpeedoMeter[playerid], 1);
    PlayerTextDrawBoxColor(playerid, SpeedoMeter[playerid], 0x000000AA);
	return 1;
}


/*Thread*/
forward SpeedoUpdate(playerid);
public SpeedoUpdate(playerid)
{
    new Float:speed_x, Float:speed_y, Float:speed_z;
    if(IsPlayerInAnyVehicle(playerid)) {
    	GetVehicleVelocity(GetPlayerVehicleID(playerid), speed_x, speed_y, speed_z);
        new Float:health;
		GetPlayerHealth(playerid,health);
	    new speedstring[128];
	    new Float:cor_x, Float:cor_y, Float:cor_z;
		GetPlayerPos(playerid,cor_x, cor_y, cor_z);
		new PlayerSpeed = floatround(floatsqroot(((speed_x * speed_x) + (speed_y * speed_y)) + (speed_z * speed_z)) * 158.179, floatround_round);
		format(speedstring, sizeof(speedstring), "Speed: %3d km/h~n~Height: %.2f",PlayerSpeed,cor_z);
		PlayerTextDrawSetString(playerid, SpeedoMeter[playerid], speedstring);
		PlayerTextDrawShow(playerid, SpeedoMeter[playerid]);
	} else {
	    PlayerTextDrawHide(playerid, SpeedoMeter[playerid]);
	}
	return 1;
}
