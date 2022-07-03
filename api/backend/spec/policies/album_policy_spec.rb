require 'rails_helper'

RSpec.describe AlbumPolicy, type: :policy do
  subject { described_class.new(user, album) }

  let(:album) { create(:album) }
  let(:user) { create(:user) }
  let(:scope) { AlbumPolicy::Scope.new(user, Album.all).resolve }

  context 'for a user' do
    it { expect(scope.to_a).to match_array([]) }
    it { should permit(:create) }
    it { should_not permit(:show) }
    it { should_not permit(:update) }
    it { should_not permit(:add_or_delete_user) }
    it { should_not permit(:destroy) }
  end

  context 'for an invited user' do
    before do
      user.albums << album
    end
    it { expect(scope.to_a).to match_array([]) }
    it { should permit(:create) }
    it { should permit(:show) }
    it { should_not permit(:update) }
    it { should_not permit(:add_or_delete_user) }
    it { should_not permit(:destroy) }
  end

  context 'for a owner' do
    before do
      album.owner = user
      user.albums << album
    end
    it { expect(scope.to_a).to match_array([album]) }
    it { should permit(:show) }
    it { should permit(:create) }
    it { should permit(:update) }
    it { should permit(:add_or_delete_user) }
    it { should permit(:destroy) }
  end
end
