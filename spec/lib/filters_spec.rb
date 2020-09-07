# frozen_string_literal: true
require 'spec_helper'
require 'filters'

RSpec.describe(Filter, type: :module) do
  let(:line) { 'test' }

  describe '.new_game?' do
    subject { described_class.new_game?(line) }

    context 'with a valid string' do
      let(:line) do
        '20:37 InitGame: \sv_floodProtect\1\sv_maxPing\0\sv_minPing' \
        '\0\sv_maxRate\10000\sv_minRate\0\sv_hostname\Code Miner Server\g_gametype\0\s' \
        'v_privateClients\2\sv_maxclients\16\sv_allowDownload\0\bot_minplayers\0\dmflags\0' \
        '\fraglimit\20\timelimit\15\g_maxGameClients\0\capturelimit\8\version\ioq3 1.36 linux-x86_64' \
        'Apr 12 2009\protocol\68\mapname\q3dm17\gamename\baseq3\g_needpass\0'
      end
      it { is_expected.to(be_truthy) }
    end

    context 'with an invalid string' do
      it { is_expected.to(be_falsey) }
    end
  end

  describe '.new_kill?' do
    subject { described_class.new_kill?(line) }

    context 'with a valid string' do
      let(:line) { '1:08 Kill: 3 2 6: Isgalamido killed Mocinha by MOD_ROCKET' }

      it { is_expected.to(be_truthy) }
    end

    context 'with an invalid string' do
      it { is_expected.to(be_falsey) }
    end

    context 'with killed by world string' do
      let(:line) { '7:30 Kill: 1022 2 19: <world> killed Dono da Bola by MOD_FALLING' }

      it { is_expected.to(be_falsey) }
    end
  end

  describe '.new_kill_info' do
    subject { described_class.new_kill_info(line) }

    context 'with a valid string' do
      let(:line) { '1:08 Kill: 3 2 6: Isgalamido killed Mocinha by MOD_ROCKET' }
      let(:killer) { 'Isgalamido' }
      let(:killed) { 'Mocinha' }
      let(:weapon) { 'MOD_ROCKET' }

      it 'returns the name of the killer' do
        expect(subject[:killer_name]).to(eq(killer))
      end

      it 'returns the name of the killed' do
        expect(subject[:killed_name]).to(eq(killed))
      end

      it 'returns the used weapon' do
        expect(subject[:mod_weapon]).to(eq(weapon))
      end
    end

    context 'with an invalid string' do
      it { is_expected.to(be_nil) }
    end
  end

  describe '.killed_by_world?' do
    subject { described_class.killed_by_world?(line) }

    context 'with a valid string' do
      let(:line) { '7:30 Kill: 1022 2 19: <world> killed Dono da Bola by MOD_FALLING' }

      it { is_expected.to(be_truthy) }
    end

    context 'with an invalid string' do
      it { is_expected.to(be_falsey) }
    end

    context 'with killed by other string' do
      let(:line) { '1:08 Kill: 3 2 6: Isgalamido killed Mocinha by MOD_ROCKET' }

      it { is_expected.to(be_falsey) }
    end
  end

  describe '.killed_by_world_info' do
    subject { described_class.killed_by_world_info(line) }

    context 'with a valid string' do
      let(:line) { '7:30 Kill: 1022 2 19: <world> killed Dono da Bola by MOD_FALLING' }
      let(:killed) { 'Dono da Bola' }
      let(:weapon) { 'MOD_FALLING' }

      it 'returns the name of the killed' do
        expect(subject[:killed_name]).to(eq(killed))
      end

      it 'returns the used weapon' do
        expect(subject[:mod_weapon]).to(eq(weapon))
      end
    end

    context 'with an invalid string' do
      it { is_expected.to(be_nil) }
    end
  end
end
