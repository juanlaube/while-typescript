import { Exp } from './ASTNode';

/**
  Representación de las comparaciones por menor o igual.
*/
export class CompareGreat implements Exp {

  lhs: Exp;
  rhs: Exp;

  constructor(lhs: Exp, rhs: Exp) {
    this.lhs = lhs;
    this.rhs = rhs;
  }

  toString(): string {
    return `CompareGreat(${this.lhs.toString()}, ${this.rhs.toString()})`;
  }

  unparse(): string {
    return `(${this.lhs.unparse()} > ${this.rhs.unparse()})`;
  }
}
