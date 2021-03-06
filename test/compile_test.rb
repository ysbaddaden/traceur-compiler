require "test_helper"

class TraceurCompilerTest < Minitest::Test
  def test_module_name
    assert_match '__moduleName = "my/module/file.js"', compile(";", "my/module/file.js")
  end

  def test_compile
    es6 = "var fn = x => x * x;"
    es5 = "var fn = (function(x) { return x * x; });"
    assert_match es5, compile(es6)
  end

  def test_syntax_error
    error = assert_raises(TraceurCompiler::Error) { compile("var fn = ", "file.js") }
    assert_match "file.js:1:10: Unexpected end of input", error.message
  end

  def compile(es6, filename = "<compileSource>")
    TraceurCompiler
      .compile(es6, modules: "inline", source_map: false, source_name: filename)
      .gsub(/\s+/, " ")
  end
end
