#include "esp_camera.h"
#include <WebServer.h>
#include <WiFi.h>

#define PWDN_GPIO_NUM 32
#define LED_GPIO 4

const char* ssid = "SLT-LTE-WiFi-8127";
const char* password = "HF1J15RDNM8";

WebServer server(80);

void handleCapture() {
  Serial.println("Capture requested");
  camera_fb_t *fb = esp_camera_fb_get();
  if (!fb) {
    Serial.println("Capture failed");
    server.send(500, "text/plain", "Camera error");
    return;
  }
  
  WiFiClient client = server.client();
  client.println("HTTP/1.1 200 OK");
  client.println("Content-Type: image/jpeg");
  client.println("Connection: close");
  client.print("Content-Length: ");
  client.println(fb->len);
  client.println();
  client.write(fb->buf, fb->len);
  
  esp_camera_fb_return(fb);
  Serial.println("Image sent");
}

void setup() {
  Serial.begin(115200);
  pinMode(LED_GPIO, OUTPUT);
  
  // Camera config (AI-Thinker)
  camera_config_t config;
 
config.ledc_channel = LEDC_CHANNEL_0;  // Must be 0-7
config.ledc_timer = LEDC_TIMER_0;      // Must be 0-3
config.pin_d0 = 5;
config.pin_d1 = 18;
config.pin_d2 = 19;
config.pin_d3 = 21;
config.pin_d4 = 36;
config.pin_d5 = 39;
config.pin_d6 = 34;
config.pin_d7 = 35;
config.pin_xclk = 0;                   // Critical for clock signal
config.pin_pclk = 22;
config.pin_vsync = 25;
config.pin_href = 23;
config.pin_sscb_sda = 26;
config.pin_sscb_scl = 27;
config.pin_pwdn = 32;
config.pin_reset = -1;
config.xclk_freq_hz = 20000000;        // Must be 20MHz
config.pixel_format = PIXFORMAT_JPEG;
config.frame_size = FRAMESIZE_SVGA;    // Try lower resolution if needed
config.jpeg_quality = 10;
config.fb_count = 1;


  if (esp_camera_init(&config) != ESP_OK) {
    Serial.println("Camera init failed!");
    while(1);
  }

  WiFi.softAP(ssid, password);
  Serial.print("AP IP: "); Serial.println(WiFi.softAPIP());

  server.on("/", [](){
    digitalWrite(LED_GPIO, HIGH);
    server.send(200, "text/plain", "ESP32-CAM Ready");
    digitalWrite(LED_GPIO, LOW);
  });
  
  server.on("/capture.jpg", handleCapture);
  
  server.begin();
  Serial.println("HTTP server started");
}

void loop() {
  server.handleClient();
}