/* OnPlayerConnect */
addPlayerToTracker(&numberofplayers, playerlist[MAX_PLAYERS]) {
    /* increase nuberofplayers and updates playerlist */
    numberofplayers++;
    playerlist = getAllConnectedPlayers();
    return 1;
}
/* OnPlayerDisconnect */
removePlayerFromTracker(&numberofplayers, playerlist[MAX_PLAYERS]) {
    /* decrease nuberofplayers and updates playerlist */
    numberofplayers--;
    playerlist = getAllConnectedPlayers();
    return 1;
}
/* internal use */
getAllConnectedPlayers() {
    /* returns array[size] with all connected players in ascending order*/
    new playerlist[MAX_PLAYERS];
	for(new i = 0; i < MAX_PLAYERS; i++) {
		if (IsPlayerConnected(i)) {
			playerlist[i] = i;
		}
	}
    return playerlist;
}
