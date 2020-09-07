# frozen_string_literal: true

module Reader
  def self.read_file(filepath)
    raise ArgumentError, 'The file does not exists' unless File.exist?(filepath)

    file = File.open(filepath)
    log = file.readlines.map(&:chomp)
    file.close
    log
  end
end
