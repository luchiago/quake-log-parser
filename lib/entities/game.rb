# frozen_string_literal: true
class Game
  attr_accessor :players, :total_kills, :kills, :kills_by_means

  WORLD_ID = "1022"

  def initialize
    @players = []
    @total_kills = 0
    @kills = {}
    @kills_by_means = {}
  end

  def to_hash
    {
      "total_kills": @total_kills,
      "players": @players,
      "kills": @kills,
      "kills_by_means": @kills_by_means,
    }
  end

  def add_kill(killer, killed, weapon)
    @total_kills += 1
    add_kill_count(@kills_by_means, weapon)
    if killer == WORLD_ID || killer == killed
      add_kill_count(@kills, killed, true)
    else
      add_kill_count(@kills, killer)
    end
  end

  def add_player(name)
    @players.push(name) unless @players.include?(name)
  end

  private

  def add_kill_count(hash, object, world_kill = false)
    hash[object] = 0 unless hash.keys.include?(object)

    return hash[object] -= 1 if world_kill
    hash[object] += 1
  end
end
