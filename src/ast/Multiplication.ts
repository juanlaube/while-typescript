import { AExp } from './ASTNode';

/**
  Representación de multiplicaciones.
*/
export class Multiplication implements AExp {

  lhs: AExp;
  rhs: AExp;

  constructor(lhs: AExp, rhs: AExp) {
    this.lhs = lhs;
    this.rhs = rhs;
  }

  toString(): string {
    return `Multiplication(${this.lhs.toString()}, ${this.rhs.toString()})`;
  }

  unparse(): string {
    return `(${this.lhs.unparse()} * ${this.rhs.unparse()})`;
  }
}
