import {Stmt} from './ASTNode';

/**
  Representación del la sentencia skip del while de Nielson.
*/
export class Skip implements Stmt {

  toString(): string {
    return `Skip()`;
  }

  unparse(): string {
    return "";
  }
}
