
// █▀ █▀▀ ▀█▀ ▀█▀ █ █▄░█ █▀▀ █▀
// ▄█ ██▄ ░█░ ░█░ █ █░▀█ █▄█ ▄█

String camIP = "10.160.37.57";
String picURL = "http://" + camIP + "/capture";

void captureESPFeed() {
    
    try {

    byte[] pic = loadBytes(picURL); // Request picture from ESP32 Camera.
    if (pic != null && pic.length > 0) {  
        saveBytes("data/capture.jpg", pic);
        lastValidCameraFeed = loadImage("capture.jpg");
        // println("Picture taken and saved as 'capture.jpg' (" + pic.length + " bytes)");
    } else { 
        println("Picture failed (null/0 bytes");
        // SHOW_ERROR("404", "Camera stream not found or invalidated.");
    }

    } catch (Exception e) {
        println("Capture error: " + e);
    }

}