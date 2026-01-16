// Will handle persistent data storage.

// █▀█ █▀▀ █▀█ █░█ █ █▀█ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ █▀
// █▀▄ ██▄ ▀▀█ █▄█ █ █▀▄ ██▄ █░▀░█ ██▄ █░▀█ ░█░ ▄█

import java.time.*;
import java.time.format.DateTimeFormatter;




// █▀ ▀█▀ ▄▀█ ▀█▀ █▀▀ █▀
// ▄█ ░█░ █▀█ ░█░ ██▄ ▄█

LocalDate currentDate;
void updateCurrentDate() { currentDate = LocalDate.now(); }

LocalTime currentTime;
void updateCurrentTime() { currentTime = LocalTime.now(); }


Table disposalsTracker;
Table fullnessTracker;




// █░█ █▀▀ █░░ █▀█ █▀▀ █▀█ █▀
// █▀█ ██▄ █▄▄ █▀▀ ██▄ █▀▄ ▄█


String formatCurrentTime(LocalTime currentTime) {
  String formattedTime = currentTime.format(DateTimeFormatter.ofPattern("HH:mm:ss"));
  return formattedTime;
}


TableRow addTableRow(Table table) {
  
  // Create a new row within the target table.
  TableRow newRow = table.addRow();
  newRow.setInt("ID", table.getRowCount() -1);
  
  updateCurrentTime();
  newRow.setString("TIME", formatCurrentTime(currentTime));
  
  return newRow;
}


// Methods that save to disk the locally stored tables.
void saveDisposalsTrackerTable() {
  saveTable(disposalsTracker, "data/data_tracking/disposals/" + currentDate + ".csv");
}

void saveFullnessTrackerTable() {
  saveTable(fullnessTracker, "data/data_tracking/fullness/" + currentDate + ".csv");
}