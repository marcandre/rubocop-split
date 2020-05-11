# This module provides methods that make it easier to test Cops.
module SourceHelper
  def parse_source(source, file = nil)
    if file&.respond_to?(:write)
      file.write(source)
      file.rewind
      file = file.path
    end

    RuboCop::ProcessedSource.new(source, ruby_version, file)
  end
end
