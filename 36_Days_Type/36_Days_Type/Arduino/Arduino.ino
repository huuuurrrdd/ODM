#include <NewPing.h>

#define SONAR_NUM 2            // nº de sensores
#define MAX_DISTANCE 200       // cm
#define THRESHOLD_DISTANCE 20  // distância de deteção

// Pins dos sensores
NewPing sonar[SONAR_NUM] = {
  NewPing(6, 7, MAX_DISTANCE),
  NewPing(8, 9, MAX_DISTANCE)
};

void setup() {
  Serial.begin(115200);
}

void loop() {
  delay(200);

  if (sonar[0].ping_cm() < THRESHOLD_DISTANCE) {
    Serial.print("1");
  } else {
    Serial.print("0");
  }

  Serial.print(":");

  if (sonar[1].ping_cm() < THRESHOLD_DISTANCE) {
    Serial.print("1");
  } else {
    Serial.print("0");
  }

  Serial.println();  // 1:0
}
