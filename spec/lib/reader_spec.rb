# frozen_string_literal: true
require 'spec_helper'
require './lib/reader'

RSpec.describe(Reader, type: :module) do
  let(:valid_file_path) { './qgames.log' }
  let(:invalid_file_path) { 'inexistent.log' }

  context 'with a valid file path' do
    subject { described_class.read_file(valid_file_path) }

    it 'returns the log text' do
      expect(subject).not_to(be_empty)
    end
  end

  context 'with an invalid file path' do
    subject { described_class.read_file(invalid_file_path) }

    it 'raises errors' do
      expect { subject }.to(raise_error(ArgumentError, 'The file does not exists'))
    end
  end
end
