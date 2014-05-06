require "active_support/core_ext/string/inflections"
require "execjs"

module TraceurCompiler
  class Error < StandardError; end

  module Source
    def self.path
      @path ||= ENV["TRACEUR_COMPILER_SOURCE_PATH"]
    end

    def self.path=(path)
      @path = path
    end

    def self.compile_path
      File.expand_path("../traceur-compiler/compile.js", __FILE__)
    end

    def self.path=(path)
      @path, @contents, @context = path, nil, nil
    end

    def self.contents
      @contents = File.read(path) + File.read(compile_path)
    end

    def self.context
      ExecJS.compile(contents)
    end
  end

  def self.compile(content, options)
    content = content.read if content.respond_to?(:read)
    compile_options = options.map { |key, value| [key.to_s.camelize(:lower), value] }.to_h
    result = Source.context.call("compile", content, compile_options)
    raise Error.new("TRACEUR COMPILE ERROR:\n" + result["errors"].join("\n")) if result["errors"].any?
    result["js"]
  end
end
