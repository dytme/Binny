
// █▀█ █▀▀ █▀█ █░█ █ █▀█ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ █▀
// █▀▄ ██▄ ▀▀█ █▄█ █ █▀▄ ██▄ █░▀░█ ██▄ █░▀█ ░█░ ▄█

import processing.serial.*;

/*
Processing Serial Library
@ Processing Foundation
Licensed under Creative Commons (CC BY-NC-SA 4.0)
https://processing.org/reference/libraries/serial/index.html
*/

Serial bin1; // Residual Waste Bin // Index 0
Serial bin2; // Plastic Waste Bin  // Index 1






// █▀ █▀▀ ▀█▀ ▀█▀ █ █▄░█ █▀▀ █▀
// ▄█ ██▄ ░█░ ░█░ █ █░▀█ █▄█ ▄█


int baudrate = 9600;
int numberOfBins = 2;




// █▀ ▀█▀ ▄▀█ ▀█▀ █▀▀ █▀
// ▄█ ░█░ █▀█ ░█░ ██▄ ▄█

boolean waitingThrow = false;
BinType expectedBin;

enum BinType {
	RESIDUAL,
	PLASTIC
}




// █▀ █▀▀ ▀█▀ █░█ █▀█
// ▄█ ██▄ ░█░ █▄█ █▀▀


// Print out the current active serial connections and setup connections for both.
void serialSetup() {
	// println(Serial.list());

	String portBin1 = Serial.list()[2]; //com #
	String portBin2 = Serial.list()[3]; //com #

	bin1 = new Serial(this, portBin1, baudrate);
	bin2 = new Serial(this, portBin2, baudrate);

	println("Residual waste bin connected to port"+ portBin1);
	println("Plastic waste bin connected to port"+ portBin2);
}




// █▀▀ █▀█ █▀█ █░█░█ ▄▀█ █▀█ █▀▄   █▀█ █▀▀ █▀ █░█ █░░ ▀█▀   ▀█▀ █▀█   █▄▄ █ █▄░█ █▀
// █▀░ █▄█ █▀▄ ▀▄▀▄▀ █▀█ █▀▄ █▄▀   █▀▄ ██▄ ▄█ █▄█ █▄▄ ░█░   ░█░ █▄█   █▄█ █ █░▀█ ▄█

void INFORM_RESIDUAL_BIN() {
	
	// If Serial Connections are disabled, do nothing.
	if (!serialConnections) return;

	bin1.write('H');
	expectedBin = BinType.RESIDUAL;
    waitingThrow = true;
}

void INFORM_PLASTIC_BIN() {

	// If Serial Connections are disabled, do nothing.
	if (!serialConnections) return;

	bin2.write('H');
	expectedBin = BinType.PLASTIC;
	waitingThrow = true;
}




// █░░ █ █▀ ▀█▀ █▀▀ █▄░█   █▀▀ █▀█ █▀█   ▄▀█ █▀█ █▀▄ █░█ █ █▄░█ █▀█   █▀█ █▀▀ █▀ █▀█ █▀█ █▄░█ █▀ █▀▀
// █▄▄ █ ▄█ ░█░ ██▄ █░▀█   █▀░ █▄█ █▀▄   █▀█ █▀▄ █▄▀ █▄█ █ █░▀█ █▄█   █▀▄ ██▄ ▄█ █▀▀ █▄█ █░▀█ ▄█ ██▄

// This one doesn't need to check for serialConnections, as it will inherently never fire without one.
void serialEvent(Serial which) {

	println("Serial Data Event");
	println(which);

	String read = which.readStringUntil('\n'); //read the characters from THIS serial port until end of line
	if ( read == null) return ;
	read = trim(read);

	println(read);

	// Why are we disregarding "1"?
	if (!read.equals("1")) return;


	BinType actualBin;
	if (which == bin1) actualBin = BinType.RESIDUAL; // Graph used to be updated here.
	else actualBin = BinType.PLASTIC;

	if (waitingThrow) { // If we're waiting on input from the last throw.
						// i.e. if Binny has been used in this particular disposal event
						// Once the splash screen is over, waitingThrow will be set to false.

		// Track the disposal, mentioning the use and result of Binny
		trackDisposal(compressBinName(actualBin), compressBinName(expectedBin)); // TODO: Only store the first letter of the bin name to save on storage space.
		waitingThrow = false;

	} else { trackDisposal(actualBin.name(), null); } // If Binny wasn't used, just track whatever item was thrown out.
}

