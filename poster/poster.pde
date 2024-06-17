int samples = 0;
float videoLength = 60;
boolean save = false;
String outputFile;

PImage textura;
String idTexto = nf(int(random(37)), 2);
PShape texto;

color black = color(#232323);
color white = color(#F3F3F3);
color[] allColor = {#4171E1, #FD504F, #FFED00, #A8DADC, #F4BFC2, #EFE2D1};
color[] darkColor = {#4171E1, #FD504F, #FFED00};
color[] lightColor = {#A8DADC, #F4BFC2, #EFE2D1};
int modo;
int pos;
color fundoDark, fundoLight, mod1color, mod2color, c_texto;



int nLetras = 7;
float tamLetras = 0.8;
//formas
PShape [] letras = new PShape[107];

PVector [] posLetras;
PVector [] velLetras;
float [] amplitude;
float [] angle;

int [] idLetra;
PGraphics pg;

void setup() {
  size(450, 800);
  
  //size(1000, 500);
  //idTexto = "30";
  textura = loadImage("t.png");
  texto = loadShape("c" + idTexto + ".svg");
  texto.disableStyle();
  
  //c_texto = random(1) < 0.5 ? color(#232323) : color(#F3F3F3);
  c_texto = color(#232323);
  
  modo = int(random(1, 3));
  println("texto: " + idTexto);

  //se central (apenas centro: 32,  )
  if (idTexto.equals("00") || idTexto.equals("05")|| idTexto.equals("08")|| idTexto.equals("13")
    || idTexto.equals("02")|| idTexto.equals("20")|| idTexto.equals("21")|| idTexto.equals("23")
    || idTexto.equals("31")|| idTexto.equals("32")) {
    if (!idTexto.equals("32")) {
      pos = int(random(4, 6));
    } else {
      pos = 5;
    }
  }
  //se direita (apenas centro: 19, 37)
  else if (idTexto.equals("04")|| idTexto.equals("06")|| idTexto.equals("12")|| idTexto.equals("15")
    || idTexto.equals("19")|| idTexto.equals("22")|| idTexto.equals("24")|| idTexto.equals("29")
    || idTexto.equals("33")|| idTexto.equals("37")|| idTexto.equals("16")) {
    if (!idTexto.equals("19") && !idTexto.equals("37")&& !idTexto.equals("33")) {
      pos = int(random(1, 3));
    } else {
      pos = 2;
    }
  }
  // se esquerda (apenas centro: )
  else if (idTexto.equals("01")|| idTexto.equals("03")|| idTexto.equals("07")|| idTexto.equals("09")
    || idTexto.equals("11")|| idTexto.equals("25")|| idTexto.equals("28")|| idTexto.equals("30")) {
    pos = int(random(7, 9));
  }
  //se direita e centro (apenas centro: 14, 34)
  else if (idTexto.equals("10")|| idTexto.equals("14")|| idTexto.equals("26")|| idTexto.equals("34")) {
    if (!idTexto.equals("14") && !idTexto.equals("34")) {
      pos = int(random(1, 6));
    } else {
      //pos = 2 ou 5
      pos = random(1) < 0.5 ? 2 : 5;
    }
  }
  //se esquerda e centro (apenas centro: 18, 35, 36)
  else if (idTexto.equals("17")|| idTexto.equals("18")|| idTexto.equals("27")|| idTexto.equals("35")
    || idTexto.equals("36")) {
    if (!idTexto.equals("18") && !idTexto.equals("35") && !idTexto.equals("36")) {
      pos = int(random(4, 9));
    } else {
      //pos = 5 ou 8
      pos = random(1) < 0.5 ? 5 : 8;
    }
  }
  
   println("pos: " + pos); // Debug

  //pos = int(random(1, 9));
  //pos = 9;

  fundoDark = darkColor[int(random(0, 3))];
  fundoLight = lightColor[int(random(0, 3))];
  mod1color = allColor[int(random(0, 6))];
  mod2color = darkColor[int(random(0, 3))];

  if (mod1color == fundoDark) {
    while (mod1color == fundoDark) {
      mod1color = allColor[int(random(0, 3))];
    }
  } else if (mod2color == #FFED00 && fundoLight == #EFE2D1) {
    while (mod2color == #FFED00 && fundoLight == #EFE2D1) {
      mod2color = darkColor[int(random(0, 3))];
    }
  }


  shapeMode(CENTER);
  //texto.scale(3.5);
  //descarrega letras
  for (int i = 0; i < letras.length; i++) {
    letras[i] = loadShape("Asset " + (i + 1) + ".svg");
  }

  posLetras = new PVector[nLetras];
  velLetras = new PVector[nLetras];
  amplitude = new float[nLetras];
  angle = new float[nLetras];
  idLetra = new int[nLetras];

  pg = createGraphics(width * 2, height * 2);

  //define letras e posicoes
  for (int i = 0; i < nLetras; i++) {
    idLetra[i] = int(random(0, 106));
    posLetras[i] = new PVector(int(random(width * 2)), int(random(height * 2)));
    velLetras[i] = new PVector(random(0.1, 0.15), 0);
    amplitude[i] = random(20, 50);
    angle[i] = random(TWO_PI);
  }
  
    outputFile = System.currentTimeMillis() + "";
}

void draw() {
  
    if(samples < 21*30){
  //update do movimento y
  for (int i = 0; i < nLetras; i++) {
    posLetras[i].y = posLetras[i].y + sin(angle[i]) * amplitude[i] * 0.005;
    
    //sive wave angle
    angle[i] += 0.01;
    
    //horizontal move
     posLetras[i].x += velLetras[i].x;
  }
  
  
  
  
  
  // Os melhores; DIFFERENCE, EXCLUSION, OVERLAY

  if (modo == 1) {
    background(fundoDark);
    pushMatrix();
    scale(0.5);
    for (int i = 0; i < nLetras; i++) {
      letras[idLetra[i]].disableStyle();
      fill(mod1color);
      //blendMode(EXCLUSION);
      noStroke();
      shape(letras[idLetra[i]], posLetras[i].x, posLetras[i].y, letras[idLetra[i]].width * tamLetras, letras[idLetra[i]].height * tamLetras);
      
      
      //blendMode(BLEND);
    }
    popMatrix();
  } else if (modo == 2) {
    background(fundoLight);
    pushMatrix();
    scale(0.5);
    for (int i = 0; i < nLetras; i++) {
      letras[idLetra[i]].disableStyle();
      fill(mod2color);
      noStroke();
      //blendMode(EXCLUSION);
      shape(letras[idLetra[i]], posLetras[i].x, posLetras[i].y, letras[idLetra[i]].width * tamLetras, letras[idLetra[i]].height * tamLetras);
      //blendMode(BLEND);
    }
    popMatrix();
  }

  blendMode(OVERLAY);
  tint(255, 80); //definir opacidade
  image(textura, 0, 0);
  textura.resize(width, height);
  image(textura, 0, 0);
  blendMode(BLEND);


  pushMatrix();
  fill(c_texto);
  switch (pos) {
  case 1:
    shapeMode(CENTER);
    fill(c_texto);
    shape(texto, width/2 + (texto.width * 0.1), height/2 - height/3.5, texto.width*1.6, texto.height*1.6);
    break;
    //meio direito
  case 2:
    shapeMode(CENTER);
    fill(c_texto);
    shape(texto, width/2 + (texto.width * 0.1), height/2, texto.width*1.6, texto.height*1.6);
    break;
    //inferior direito
  case 3:
    shapeMode(CENTER);
    fill(c_texto);
    shape(texto, width/2 + (texto.width * 0.1), height/2 + height/3.5, texto.width*1.6, texto.height*1.6);
    break;
    //superior centro
  case 4:
    shapeMode(CENTER);
    fill(c_texto);
    shape(texto, width/2, height/2 - height/4.5, texto.width*1.8, texto.height*1.8);
    break;
    //meio centro
  case 5:
    shapeMode(CENTER);
    fill(c_texto);
    shape(texto, width/2, height/2, texto.width*1.8, texto.height*1.8);
    break;
    //inferior centro
  case 6:
    shapeMode(CENTER);
    fill(c_texto);
    shape(texto, width/2, height/2 + height/3.1, texto.width*1.8, texto.height*1.8);
    break;
    //superior esquerdo
  case 7:
    shapeMode(CENTER);
    fill(c_texto);
    shape(texto, width/2 - (texto.width * 0.1), height/2 - height/3.5, texto.width*1.6, texto.height*1.6);
    break;
    //meio esquerdo
  case 8:
    shapeMode(CENTER);
    fill(c_texto);
    shape(texto, width/2 - (texto.width * 0.1), height/2, texto.width*1.6, texto.height*1.6);
    break;
    //inferior esquerdo
  case 9:
    shapeMode(CENTER);
    fill(c_texto);
    shape(texto, width/2 - (texto.width * 0.1), height/2 + height/3.5, texto.width*1.6, texto.height*1.6);
    break;
  }
  popMatrix();
  
    samples++;
  if (samples < videoLength*30 && save) {
    //if (save && frameCount % 10 == 0) {
    samples++;
    save(sketchPath("exported/" + outputFile + "/" + nf(frameCount, 6) + ".png"));
  }
}
}
