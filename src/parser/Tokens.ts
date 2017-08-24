export const tokens = {

  // Punctuation
  '!':          '!',
  '&&':         '&&',
  '(':          '(',
  ')':          ')',
  '{':          '{',
  '}':          '}',
  '/':          '/',
  '*':          '*',
  '+':          '+',
  '-':          '-',
  ';':          ';',
  '<=':         '<=',
  '==':         '==',
  '=':          '=',
  '>=':         '>=',
  '!=':         '!=',
  '<':          '<',
  '>':          '>',

  // Keywords
  'do':         'do',
  'while':      'while',
  'if':         'if',
  'then':       'then',
  'else':       'else',
  'skip':       'skip',
  'true':       'true',
  'false':      'false',

  // Atoms
  number:       { match: /[0-9]+/, value: (x: string) => (parseFloat(x)) },
  hexa:         { match: /0[xX][0-9a-fA-F]+/, value: (x: string) => (Number(x)) },
  floatingPoint:{ match: /[-+]?[0-9]*\.?[0-9]+(?:[eE][-+]?[0-9]+)?/, value: (x: string) => (parseFloat(x)) },
<<<<<<< HEAD
  comments:     { match: /\/\*(?:\*(?:?!\/)|[^*])*\*\//, lineBreaks: true },
=======
  comments:     { match: /\/\*(?:\*(?:!\/)|[^*])*\*\//, lineBreaks: true },
>>>>>>> b0675e3b372f64601d4e8b49b49295c1ad7b20b4

  // Identifiers
  identifier:   /[a-zA-Z_][a-zA-Z0-9_]*/,

  // Ignored tokens
  _ws:          { match: /[ \t\r\n\f\v]+/, lineBreaks: true },
};
