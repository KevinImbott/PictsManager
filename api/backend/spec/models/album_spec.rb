# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Album, type: :model do
  let(:album) { create(:album) }

  context 'album' do
    context 'with no valid attributes' do
      it 'is not valid with no name' do
        album.name = nil
        expect(album).to_not be_valid
      end
    end
  end

  context 'with good attributes' do
    it 'update attribute' do
      album.name = 'New name'
      expect(album.name).to eq 'New name'
    end
    it 'is valid with all attributes' do
      expect(album).to be_valid
    end
  end
end
