import { Exp } from './ASTNode';

/**
  Representación de usos de variable en expresiones.
*/
export class Variable implements Exp {
  id: string;

  constructor(id: string) {
    this.id = id;
  }

  toString(): string {
    return `Variable(${this.id})`;
  }

  unparse(): string {
    return this.id;
  }
}
