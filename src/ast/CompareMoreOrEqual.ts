import { Exp } from './ASTNode';

/**
  Representación de las comparaciones por mayor o igual.
*/
export class CompareMoreOrEqual implements Exp {

  lhs: Exp;
  rhs: Exp;

  constructor(lhs: Exp, rhs: Exp) {
    this.lhs = lhs;
    this.rhs = rhs;
  }

  toString(): string {
    return `CompareMoreOrEqual(${this.lhs.toString()}, ${this.rhs.toString()})`;
  }

  unparse(): string {
    return `(${this.lhs.unparse()} >= ${this.rhs.unparse()})`;
  }
}
