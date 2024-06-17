import processing.serial.*;
import websockets.*;

WebsocketServer socket;
Serial myPort;

Grid grid;
Animation animation;
Message message;

PFont[] fonts;
float tamanhoFonte, entrelinha;
char[] caracteres = new char[] {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};

float posX, larguraBarra;
int posicaoPessoa = 2;
PImage textura;

color[] cores = {
  #FEC631,
  #A8DADC,
  #F4BFC2,
  #EFE2D1,
  #EB94C3,
  #FF1882,
  #8D69BA,
  #4171E1,
  #E56D2E,
  #FD504F
};
color[] corTexto = {color(35, 35, 35), color(243, 243, 243)};
int corRandom = 2;
int corTextoIndex;

void setup() {
  size(960, 540, P2D);
  //fullScreen();

  textura = loadImage("t.png");

  println(Serial.list());
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);

  tamanhoFonte = height/8;
  entrelinha = tamanhoFonte*1.2;

  fonts = new PFont[3];
  fonts[0] = createFont("./symbols/36DaysofBoulanger-Regular.ttf", tamanhoFonte);
  fonts[1] = createFont("./symbols/36DaysofBoulanger1-Regular.ttf", tamanhoFonte);
  fonts[2] = createFont("./symbols/36DaysofBoulanger2-Regular.otf", tamanhoFonte);
  textAlign(CENTER);
  noStroke();

  grid = new Grid(width-100, height-100);

  socket = new WebsocketServer(this, 1337, "/p5websocket");
  message = new Message("Helloo how potato batata gaga happy tata");

  animation = new Animation();
}

void draw() {
  background(cores[corRandom]);

  if (corRandom < 4) corTextoIndex = 0;
  else corTextoIndex = 1;

  if (animation.ativa) { // enquanto estiver a animação não mostrar a grelha de caracteres
    animation.movingLine(); // quando uma pessoa entra na sala
  } else {
    grid.display(); // grelha de caracteres

    if (!message.tempoExcedido) { // a mensagem aparece durante 5s
      fill(cores[corRandom], 200);
      rect(0, 0, width, height); // overlay
      message.display(); // mensagem do websocket
    }

    posX = posicaoPessoa*larguraBarra; // posição da pessoa (para teste)
    changeFont(); // mudar a fonte consoante a posição
  }

  // Textura
  push();
  blendMode(OVERLAY);
  tint(255, 50); //definir opacidade
  image(textura, 0, 0);
  textura.resize(width, height);
  image(textura, 0, 0);
  pop();
}

void changeFont() {
  fill(corTexto[corTextoIndex]);
  larguraBarra = width/3;
  rect(posX, height-5, larguraBarra, 5); // ponteiro

  // texto
  textFont(fonts[posicaoPessoa]);
  textSize(tamanhoFonte);
  textLeading(entrelinha);
}

void webSocketServerEvent(String msg) { // comunicação com websocket
  println(trim(msg));
  println(grid.inventario);
  println();

  message = new Message(trim(msg)); // update da mensagem
  message.tempoExcedido = false; // recomeça temporizador
  corRandom = (int)random(cores.length); // calculo de cor random quando chega nova mensagem
}

void serialEvent(Serial myPort) {
  try {
    String data = myPort.readStringUntil('\n');

    if (data != null) {
      println(data);
      data = trim(data);
      int[] sensor = int(split(data, ':'));

      for (int i=0; i<sensor.length; i++) {
        if (sensor[i] == 1)
          posicaoPessoa = i;
      }
    }
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R')
    animation = new Animation();
  if (key == 'c' || key == 'C')
    corRandom = (int)random(cores.length); // calculo de cor random quando chega nova mensagem
}
