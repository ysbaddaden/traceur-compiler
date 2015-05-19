var Compiler = traceur.Compiler;

// TODO: source maps (?)
function compile(content, sourceName, outputName, options) {
  var compiler = new Compiler(options || {}),
      errors = [],
      js;

  try {
    js = compiler.compile(content, sourceName || "<compileSource>", outputName || "<compileOutput>");
  } catch (ex) {
    errors.push(ex);
  }

  return {
    errors: errors,
    js: js || ""
  };
}
