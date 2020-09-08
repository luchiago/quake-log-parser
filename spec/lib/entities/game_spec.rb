# frozen_string_literal: true
require 'spec_helper'
require 'entities/game'

RSpec.describe(Game, type: :entity) do
  subject { described_class.new }

  describe '#to_hash' do
    let(:players) { ["Islamigdo", "John"] }
    let(:total_kills) { 42 }
    let(:kills) { { "Islamigdo": 12, "John": 30 } }
    let(:kills_by_means) { { "MOD_SHOTGUN": 10, "MOD_RAILGUN": 32 } }

    before do
      subject.players = players
      subject.total_kills = total_kills
      subject.kills = kills
      subject.kills_by_means = kills_by_means
    end

    it 'returns the correct game hash' do
      expect(subject.to_hash).to(eq({
        "total_kills": total_kills,
        "players": players,
        "kills": kills,
        "kills_by_means": kills_by_means,
      }))
    end
  end

  describe '#add_kill' do
    let(:killer) { "John" }
    let(:killed) { "João" }
    let(:weapon) { "MOD_SHOTGUN" }
    let(:world) { "1022" }

    context 'with a kill by other user' do
      before { subject.add_kill(killer, killed, weapon) }

      it 'increase the kill count' do
        expect(subject.total_kills).to(eq(1))
      end

      it 'increase the killer count' do
        expect(subject.kills[killer]).to(eq(1))
      end

      it 'increase the weapon kill count' do
        expect(subject.kills_by_means[weapon]).to(eq(1))
      end
    end

    context 'with a kill by world' do
      before { subject.add_kill(world, killed, weapon) }

      it 'increase the kill count' do
        expect(subject.total_kills).to(eq(1))
      end

      it 'descrease the killed count' do
        expect(subject.kills[killed]).to(eq(-1))
      end

      it 'increase the weapon kill count' do
        expect(subject.kills_by_means[weapon]).to(eq(1))
      end
    end
  end

  describe '#add_player' do
    context 'with a user name' do
      let(:name) { "John" }

      before { subject.add_player(name) }

      it 'adds the user to instance' do
        expect(subject.players).to(include(name))
      end

      it 'does not add the same user' do
        subject.add_player(name)
        expect(subject.players.length).to(eq(1))
      end
    end
  end
end
