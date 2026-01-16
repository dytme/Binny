
// █▀▄ ▄▀█ ▀█▀ ▄▀█   █▀▀ █▄░█ ▀█▀ █▀█ █ █▀▀ █▀
// █▄▀ █▀█ ░█░ █▀█   ██▄ █░▀█ ░█░ █▀▄ █ ██▄ ▄█


void trackDisposal(String TARGET_BIN, boolean BINNY_USED, String DETECTED_BIN) {
  
  // Creae a new entry in the CSV file
  TableRow newRow = addTableRow(disposalsTracker);
  newRow.setString("TARGET_BIN", TARGET_BIN); // Track in what bin an item was thrown
  
  if (BINNY_USED) { // If Binny was used, also track that it was and what it recommended.
    newRow.setString("BINNY_USED", "Y");
    newRow.setString("DETECTED_BIN", DETECTED_BIN);
  } else newRow.setString("BINNY_USED", "N");
  
  // Save the updated table to a file
  saveDisposalsTrackerTable();
  
}


void trackFullness(String RESIDUAL_BIN, String PLASTIC_BIN) {
  
  // Creae a new entry in the CSV file
  TableRow newRow = addTableRow(fullnessTracker);
  
  newRow.setString("RESIDUAL_BIN", RESIDUAL_BIN);
  newRow.setString("PLASTIC_BIN", PLASTIC_BIN);
  
  // Save the updated table to a file
  saveFullnessTrackerTable();
}


void countItemBeingThrown(int actualBin, int expectedBin) {
	
	// If the index is accidentally bigger than the number of connected bins, do nothing.
	if (actualBin > numberOfBins-1 || expectedBin > numberOfBins-1) { 
		SHOW_ERROR("404", "Indexed bin in data collection method not found.");
		return;
	}

	// Increase the total disposal count for that bin
	totalDisposals[actualBin] = totalDisposals[actualBin] + 1;
	
	// Check if the item was thrown correctly, and if so, count for that too
	if (actualBin == expectedBin) {
		matchedDisposals[actualBin] = matchedDisposals[actualBin] + 1;
	}

}