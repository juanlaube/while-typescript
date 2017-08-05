import { AExp } from './ASTNode';

/**
  Representación de usos de variable en expresiones.
*/
export class Variable implements AExp {
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
