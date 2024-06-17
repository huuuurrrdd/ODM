class Message {
  String msg;
  String[] palavras; // dividir a mensagem do websocket em palavras
  char[] caracteres; // dividir a mensagem do websocket em caracteres
  float tempoInicial, temporizador;
  boolean tempoExcedido;

  Message(String msg) {
    this.msg = msg; // mensagem do websocket

    tempoExcedido = true;
    tempoInicial = millis(); // recebe novo resultado, inicia temporizador
    temporizador = 5000; // tempo durante o qual mostra a mensagem

    caracteres = new char[msg.length()];
    for (int i=0; i<caracteres.length; i++) {
      caracteres[i] = Character.toUpperCase(msg.charAt(i)); // retirar todos os caracteres para um array
      grid.inventario.increment(str(caracteres[i])); // incrementar o número de ocurrências se esse caracter aparecer
    }

    palavras = split(msg, ' '); // dividir a mensagem em palavras
  }

  String existsSymbol(String palavra) {
    palavra = palavra.toLowerCase().trim();

    if (palavra.equals("crown") || palavra.equals("tiara") || palavra.equals("king") || palavra.equals("queen") || palavra.equals("champion")) { // ♛
      return palavra+" #";
    } else if (palavra.equals("sun") || palavra.equals("light") || palavra.equals("morning") || palavra.equals("shine")) { // ☀
      return palavra+" $";
    } else if (palavra.equals("flower") || palavra.equals("nature") || palavra.equals("natural") || palavra.equals("organic") || palavra.equals("plant") || palavra.equals("vegetable")) { // ✿
      return palavra+" %";
    } else if (palavra.equals("and")) { // &
      return "&";
    } else if (palavra.equals("sad") || palavra.equals("unhappy") || palavra.equals("down")) { // ☹
      return palavra+" (";
    } else if (palavra.equals("happy") || palavra.equals("smile") || palavra.equals("good") || palavra.equals("happiness")) { // ☺
      return palavra+" )";
    } else if (palavra.equals("gender") || palavra.equals("gender stereotypes") || palavra.equals("gender fonts") || palavra.equals("feminity") || palavra.equals("sexuality")) { // ⚤
      return palavra+" *";
    } else if (palavra.equals("this") || palavra.equals("these")) { // →
      return palavra+" +";
    } else if (palavra.equals("heart") || palavra.equals("love")) { // ♡
      return palavra+" ,";
    } else if (palavra.equals("that")) { // ←
      return palavra+" –";
    } else if (palavra.equals("two") || palavra.equals("fine") || palavra.equals("victory") || palavra.equals("win")) { // ✌
      return palavra+" .";
    } else if (palavra.equals("pencil") || palavra.equals("school")) { // ✎
      return palavra+" /";
    } else {
      return palavra;
    }
  }

  String finalString() {
    String finalString = "";
    for (int i=0; i<palavras.length; i++) {
      if (i<7) { // limitar a 4 linhas
        finalString += existsSymbol(palavras[i]); // coloca palavras lado a lado
        if (i%2 != 0 && i != palavras.length-1) finalString += " "; // adicionar espaços

        if (i%2 == 0 || textWidth(palavras[i])>width) finalString += "\n"; // quando o i é par faz parágrafo ou verificar se a palavra cabe na janela
      }
    }
    return finalString;
  }

  void display() {
    if (millis()-tempoInicial < temporizador) {
      fill(corTexto[corTextoIndex]);

      float posY = 0;
      if (palavras.length < 2) posY = height/2; // uma linha
      if (palavras.length >= 2) posY = height/2 - entrelinha; // duas ou mais linhas

      text(finalString().toUpperCase(), width/2, posY); // mostrar a mensagem do websocket
    } else {
      tempoExcedido = true;
    }
  }
}
