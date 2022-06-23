# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Picture, type: :model do
  let(:picture) { create(:picture) }

  context 'picture' do
    it 'is not valid with no name' do
      picture.name = nil
      expect(picture).to_not be_valid
    end

    it 'is valid with all attributes' do
      expect(picture).to be_valid
    end
    it 'update attribute' do
      picture.name = 'New name'
      expect(picture.name).to eq 'New name'
    end
  end
end
