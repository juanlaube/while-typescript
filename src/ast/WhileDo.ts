import { BExp, Stmt } from './ASTNode';

/**
  Representación de las iteraciones while-do.
*/
export class WhileDo implements Stmt {
  cond: BExp;
  body: Stmt;

  constructor(cond: BExp, body: Stmt) {
    this.cond = cond;
    this.body = body;
  }

  toString(): string {
    return `WhileDo(${this.cond.toString()}, ${this.body.toString()})`;
  }

  unparse(): string {
    return `while ${this.cond.unparse()} do { ${this.body.unparse()} }`;
  }
}
