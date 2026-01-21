
// █▀▄ ▄▀█ ▀█▀ ▄▀█   █▀▀ █▄░█ ▀█▀ █▀█ █ █▀▀ █▀
// █▄▀ █▀█ ░█░ █▀█   ██▄ █░▀█ ░█░ █▀▄ █ ██▄ ▄█


void trackDisposal(BinType TARGET_BIN, BinType DETECTED_BIN) {
  
  // Creae a new entry in the CSV file
  TableRow newRow = addTableRow(disposalsTracker);
  newRow.setString("TARGET_BIN", compressBinName(TARGET_BIN)); // Track in what bin an item was thrown
  
  if (DETECTED_BIN != null) { // If Binny was used, also track that it was and what it recommended.
    newRow.setString("DETECTED_BIN", compressBinName(DETECTED_BIN));
  } // else newRow.setString("BINNY_USED", "N"); By default, if there's no active
  
  // Save the updated table to a file
  saveDisposalsTrackerTable();
  
}




// RESIDUAL  PLASTIC  PAPER  ORGANIC
String[] binFullness = new String[4];

void trackFullness() {
  
  // Creae a new entry in the CSV file
  TableRow newRow = addTableRow(fullnessTracker);

  newRow.setString("RESIDUAL_BIN", binFullness[0]);
  newRow.setString("PLASTIC_BIN", binFullness[1]);
  
  // Save the updated table to a file
  saveFullnessTrackerTable();

}



void updateBinFullness(String BIN_TYPE, String VALUE) {

  int fullnessArrayIndex = 0;

  switch(BIN_TYPE) {
    case "PLASTIC_BIN": fullnessArrayIndex = 1; break;
    case "PAPER_BIN": fullnessArrayIndex = 2; break;
    case "ORGANIC_BIN": fullnessArrayIndex = 3; break;
  }

  binFullness[fullnessArrayIndex] = VALUE;

}