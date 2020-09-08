# frozen_string_literal: true
require_relative 'reader'
require_relative 'filters'
require_relative 'entities/game'
require 'pp'

class Extract
  def initialize(log)
    @log = log
    @current_game = nil
    @games = {}
    @game_count = 0
  end

  def extract
    @log.each do |line|
      if Filter.new_game?(line)
        new_game
      elsif Filter.new_kill?(line)
        process_kill(Filter.new_kill_info(line))
      elsif Filter.killed_by_world?(line)
        process_kill(Filter.killed_by_world_info(line), true)
      end
    end

    puts @games.pretty_inspect
  end

  private

  def new_game
    old_game = @current_game
    @current_game = Game.new

    return if old_game.nil?

    game_name = "game_#{@game_count}"
    @games[game_name] = old_game.to_hash
    @game_count += 1
  end

  def process_kill(info, world = false)
    killer = world ? "1022" : info[:killer_name]
    killed = info[:killed_name]
    weapon = info[:mod_weapon]

    @current_game.add_player(killer) unless world
    @current_game.add_player(killed)

    @current_game.add_kill(killer, killed, weapon)
  end
end

log = Reader.read_file('qgames.log')

Extract.new(log).extract
