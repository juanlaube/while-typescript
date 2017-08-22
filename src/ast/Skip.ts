import { Stmt } from './ASTNode';

/**
  Representación de sumas.
*/
export class Skip implements Stmt {

  constructor() {
  }

  toString(): string {
    return `Skip();`;
  }

  unparse(): string {
    return `skip;`;
  }
}
