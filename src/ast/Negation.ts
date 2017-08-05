import { BExp } from './ASTNode';

/**
  Representación de las negaciones de expresiones booleanas.
*/
export class Negation implements BExp {

  exp: BExp;

  constructor(exp: BExp) {
    this.exp = exp;
  }

  toString(): string {
    return `Negation(${this.exp.toString()})`;
  }

  unparse(): string {
    return `(!${this.exp.unparse()})`;
  }
}
