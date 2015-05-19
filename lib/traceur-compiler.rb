require "active_support/core_ext/string/inflections"
require "execjs"

module TraceurCompiler
  class Error < StandardError; end

  module Source
    def self.path
      @path ||= ENV["TRACEUR_COMPILER_SOURCE_PATH"]
    end

    def self.compile_path
      File.expand_path("../traceur-compiler/compile.js", __FILE__)
    end

    def self.path=(path)
      @path, @contents, @context = path, nil, nil
    end

    def self.contents
      @contents ||= File.read(path) + File.read(compile_path)
    end

    def self.context
      @context ||= ExecJS.compile(contents)
    end
  end

  DEFAULT_OPTIONS = {
    output_language: "es5",
    source_map: false,
    module_name: true,
  }

  def self.compile(content, source_name: nil, output_name: nil, **options)
    compile_options = DEFAULT_OPTIONS
      .merge(options)
      .map { |key, value| [key.to_s.camelize(:lower), value] }
      .to_h

    content = content.read if content.respond_to?(:read)
    result = Source.context.call("compile", content, source_name, output_name, compile_options)

    if result["errors"].any?
      raise Error.new("TRACEUR COMPILE ERROR:\n" + result["errors"].join("\n"))
    end

    result["js"]
  end
end
