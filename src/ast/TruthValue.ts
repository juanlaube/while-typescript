import { BExp } from './ASTNode';

/**
  Representación de valores de verdad (cierto o falso).
*/
export class TruthValue implements BExp {

  value: boolean;

  constructor(value: boolean) {
    this.value = value;
  }

  toString(): string {
    return `TruthValue(${this.value})`;
  }

  unparse(): string {
    return this.value ? "true" : "false";
  }
}
