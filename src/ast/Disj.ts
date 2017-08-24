import { BExp } from './ASTNode';

/**
  Representación de conjunciones booleanas (AND).
*/
export class Disj implements BExp {

  lhs: BExp;
  rhs: BExp;

  constructor(lhs: BExp, rhs: BExp) {
    this.lhs = lhs;
    this.rhs = rhs;
  }

  toString(): string {
    return `Disj(${this.lhs.toString()}, ${this.rhs.toString()})`;
  }

  unparse(): string {
    return `(${this.lhs.unparse()} || ${this.rhs.unparse()})`;
  }
}
