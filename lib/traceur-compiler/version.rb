module TraceurCompiler
  def self.version
    Gem::Version.new File.read(File.expand_path('../../../VERSION', __FILE__))
  end

  module VERSION
    MAJOR, MINOR, TINY, PRE = TraceurCompiler.version.segments
    STRING = TraceurCompiler.version.to_s
  end
end
