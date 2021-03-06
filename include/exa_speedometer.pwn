/* stores ids of player textdraws */
new PlayerText:speedometerTextDraws[MAX_PLAYERS];

/*OnPlayerConnect*/
createPlayerSpeedometer(playerid) {
	speedometerTextDraws[playerid] = CreatePlayerTextDraw(playerid, 530.0, 380.0, " ");
	PlayerTextDrawTextSize(playerid, speedometerTextDraws[playerid], 620.0, 480.0);
	PlayerTextDrawLetterSize(playerid, speedometerTextDraws[playerid],0.3,1.0);
	PlayerTextDrawUseBox(playerid, speedometerTextDraws[playerid], 1);
    PlayerTextDrawBoxColor(playerid, speedometerTextDraws[playerid], 0x000000AA);
}


/* local function */
updatePlayerSpeedometer(playerid) {
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
		PlayerTextDrawSetString(playerid, speedometerTextDraws[playerid], speedstring);
		PlayerTextDrawShow(playerid, speedometerTextDraws[playerid]);
	} else {
	    PlayerTextDrawHide(playerid, speedometerTextDraws[playerid]);
	}
}
/* local timer */
forward updateSpeedometer();
public updateSpeedometer() {
	if (connectedPlayers > 0) {
		static playerindex = 0;
		if (playerindex >= connectedPlayers) { // index higher than connected players -> reset
			playerindex = 0;
			updatePlayerSpeedometer(players[playerindex]);
		} else {
			updatePlayerSpeedometer(players[playerindex]);
			playerindex++;
		}
		SetTimer("updateSpeedometer", 300/connectedPlayers, false);
	} else {
		SetTimer("updateSpeedometer", 1000, false); // no players wait 1 second
	}

}

createSpeedometerTimer() {
	SetTimer("updateSpeedometer", 1000, false);
}
