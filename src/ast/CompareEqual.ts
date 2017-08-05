import { AExp, BExp } from './ASTNode';

/**
  Representación de las comparaciones por igual.
*/
export class CompareEqual implements BExp {

  lhs: AExp;
  rhs: AExp;

  constructor(lhs: AExp, rhs: AExp) {
    this.lhs = lhs;
    this.rhs = rhs;
  }

  toString(): string {
    return `CompareEqual(${this.lhs.toString()}, ${this.rhs.toString()})`;
  }

  unparse(): string {
    return `(${this.lhs.unparse()} == ${this.rhs.unparse()})`;
  }
}
