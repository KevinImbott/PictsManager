require 'rails_helper'

RSpec.describe PicturePolicy, type: :policy do
  subject { described_class.new(user, picture) }

  let(:picture) { create(:picture) }
  let(:user) { create(:user) }
  let(:scope) { PicturePolicy::Scope.new(user, Picture.all).resolve }

  context 'for a user' do
    it { expect(scope.to_a).to match_array([]) }
    it { should permit(:create) }
    it { should_not permit(:show) }
    it { should_not permit(:update)  }
    it { should_not permit(:add_or_delete_user) }
    it { should_not permit(:add_or_delete_album) }
    it { should_not permit(:destroy) }
  end

  context 'for an invited user' do
    before do
      user.pictures << picture
    end
    it { expect(scope.to_a).to match_array([]) }
    it { should permit(:create) }
    it { should permit(:show) }
    it { should_not permit(:update)  }
    it { should_not permit(:add_or_delete_user) }
    it { should_not permit(:add_or_delete_album) }
    it { should_not permit(:destroy) }
  end

  context 'for a owner' do
    before do
      picture.owner = user
      user.pictures << picture
    end
    it { expect(scope.to_a).to match_array([picture]) }
    it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:update)  }
    it { should permit(:add_or_delete_user) }
    it { should permit(:add_or_delete_album) }
    it { should permit(:destroy) }
  end
end
