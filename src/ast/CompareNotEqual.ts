import { AExp, BExp } from './ASTNode';

/**
  Representación de las comparaciones distintas.
*/
export class CompareNotEqual implements BExp {

  lhs: AExp;
  rhs: AExp;

  constructor(lhs: AExp, rhs: AExp) {
    this.lhs = lhs;
    this.rhs = rhs;
  }

  toString(): string {
    return `CompareNotEqual(${this.lhs.toString()}, ${this.rhs.toString()})`;
  }

  unparse(): string {
    return `(${this.lhs.unparse()} != ${this.rhs.unparse()})`;
  }
}
