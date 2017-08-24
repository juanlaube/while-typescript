import { AExp } from './ASTNode';

/**
  Representación de divisiones.
*/
export class Division implements AExp {

  lhs: AExp;
  rhs: AExp;

  constructor(lhs: AExp, rhs: AExp) {
    this.lhs = lhs;
    this.rhs = rhs;
  }

  toString(): string {
    return `Division(${this.lhs.toString()}, ${this.rhs.toString()})`;
  }

  unparse(): string {
    return `(${this.lhs.unparse()} / ${this.rhs.unparse()})`;
  }
}
