# frozen_string_literal: true
module Filter
  FILTER_REGEX = {
    game: /(?:^|\W)InitGame(?:$|\W)/,
    kill: /\sKill:[\s|\d]+:\s(?<killer_name>\w+)\skilled\s(?<killed_name>[\w+|\s]+)\sby\s(?<mod_weapon>\w+)/,
    killed_by_world: /\sKill:\s1022[\s\d+]+:\s<world>\skilled\s(?<killed_name>[\w+|\s]+)\sby\s(?<mod_weapon>\w+)/,
  }.freeze

  def self.new_game?(line)
    line.match?(FILTER_REGEX[:game])
  end

  def self.new_kill?(line)
    line.match?(FILTER_REGEX[:kill])
  end

  def self.new_kill_info(line)
    line.match(FILTER_REGEX[:kill])
  end

  def self.killed_by_world?(line)
    line.match?(FILTER_REGEX[:killed_by_world])
  end

  def self.killed_by_world_info(line)
    line.match(FILTER_REGEX[:killed_by_world])
  end
end
