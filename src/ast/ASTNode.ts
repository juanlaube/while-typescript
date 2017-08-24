export interface ASTNode {
  toString(): string;
  unparse(): string;
}

/**
  Categoría sintáctica de las expresiones de While, las
  construcciones del lenguaje que evalúan.
*/
export interface Exp extends ASTNode { }

/**
  Categoría sintáctica de las expresiones aritméticas de While, las
  construcciones del lenguaje que evalúan a un número.
*/
export interface AExp extends Exp { }

/**
  Categoría sintáctica de las expresiones booleanas de While, las
  construcciones del lenguaje que evalúan a un valor de verdad (booleano).
*/
export interface BExp extends Exp { }

/**
  Categoría sintáctica de las sentencias (statements) de While, las
  construcciones del lenguaje que modifican (potencialmente) los
  valores de las variables en el estado del programa.
*/
export interface Stmt extends ASTNode { }
