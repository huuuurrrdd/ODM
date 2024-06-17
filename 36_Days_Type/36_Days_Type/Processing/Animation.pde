class Animation {
  int randomCaractere;
  float x = width;
  boolean ativa = true;

  Animation() {
    randomCaractere = (int)random(caracteres.length);
  }

  void restart() { // quando alguém entra na sala dar restart
    ativa = true;
    x = width;
  }

  void display(PFont font) {
    push();
    textFont(font);
    textLeading(entrelinha);
    fill(corTexto[corTextoIndex]);
    text("TRY TO\nSAY\nSOMETHING", width/2, height/2-height/5);
    pop();
  }

  void changeFont() {
    if (x<width && x>2*width/3) { // se do lado direito
      display(fonts[0]);
    }
    if (x<2 * width/3 && x>width/3) { // se no meio
      display(fonts[1]);
    }
    if (x<width/3 && x>0) { // se do lado esquerdo
      display(fonts[2]);
    }
  }

  void movingLine() {
    if (x > 0) {
      float posX = map(x, width, 0, 0, 1); // posição do retângulo para mudar a cor
      color cor1 = color(255, 0, 0); // cor inicial
      color cor2 = color(255, 0, 255); // cor final
      color corBarra = lerpColor(cor1, cor2, posX); // transição de uma cor para outra
      //fill(corBarra);
      fill(corTexto[corTextoIndex]);
      rect(x, height-100, 100, 100);

      changeFont(); // mudar a fonte dependendo da posição

      x-=10; // alterar a posição a cada frame
    } else {
      ativa = false;
    }
  }
}
