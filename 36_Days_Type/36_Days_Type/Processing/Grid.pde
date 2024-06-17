class Grid {
  IntDict inventario;
  int numLinhas, numColunas;
  float tamanho, tamanhoCaractere;
  float largura, altura;

  Grid(float largura, float altura) {
    this.altura = altura; // altura de toda a grelha
    this.largura = largura; // largura de toda a grelha
    numLinhas = 4; // número de linhas
    numColunas = 9; // número de colunas (numLinhas * numColunas = número de caracteres)
    tamanho = width/numColunas; // tamanho da célula        

    inventario = new IntDict(); // número de ocurrências do array caracteres
    for (int i=0; i<caracteres.length; i++) {
      char caractere = caracteres[i];
      inventario.set(str(caractere), 0); // iniciar a 0
    }
  }

  void inserirCaractere(char caractere, int numOcurrencias, float x, float y) {
    numOcurrencias = constrain(numOcurrencias, 0, 50); // número máximo de ocurrências 50
    tamanhoCaractere = map(numOcurrencias, 0, 50, tamanho/3, tamanho*0.8); // variar o tamanho da fonte
    textFont(fonts[posicaoPessoa]);
    textSize(tamanhoCaractere);
    fill(corTexto[corTextoIndex]);

    caractere = Character.toUpperCase(caractere);
    text(caractere, x + tamanho/2, y+tamanho);
  }

  void display() {
    push();
    translate(width/2 - (numColunas*tamanho)/2, height/2 - (numLinhas*tamanho)/2 - tamanho/4);

    for (int linhas = 0; linhas < numLinhas; linhas++) {
      for (int colunas = 0; colunas < numColunas; colunas++) {
        // Correr todos os caracteres da fonte
        int index = linhas * numColunas + colunas;
        //index %= caracteres.length;
        if (index < caracteres.length) {
          float x = colunas * tamanho;
          float y = linhas * tamanho;

          int numOcurrencias = inventario.get(str(caracteres[index])); // ver qual o número de ocurrências para alterar tamanho

          // Inserir caractere na celula
          inserirCaractere(caracteres[index], numOcurrencias, x, y);

          // Grid (Debug)
          //noFill();
          //stroke(255, 100);
          //circle(x+tamanho/2, y+tamanho/2, 10);
          //rect(x, y, tamanho, tamanho);
        }
      }
    }
    pop();
  }
}
