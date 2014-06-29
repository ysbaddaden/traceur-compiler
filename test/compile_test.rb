require "test_helper"

class TraceurCompilerTest < Minitest::Test
  def test_compile
    es6 = "var fn = x => x * x;"
    es5 = "var fn = (function(x) { return x * x; });"
    assert_match es5, compile(es6)
  end

  def test_syntax_error
    error = assert_raises(TraceurCompiler::Error) { compile("var fn = ") }
    assert_match "Unexpected end of input", error.message
  end

  def compile(es6)
    TraceurCompiler
      .compile(es6, modules: "inline", source_map: false)
      .gsub(/\s+/, " ")
  end
end
