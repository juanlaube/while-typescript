import { AExp } from './ASTNode';

/**
  Representación de constantes numéricas o numerales.
*/
export class Numeral implements AExp {

  value: number;

  constructor(value: number) {
    this.value = value;
  }

  toString(): string {
    return `Numeral(${this.value})`;
  }

  unparse(): string {
    return `${this.value}`;
  }
}
