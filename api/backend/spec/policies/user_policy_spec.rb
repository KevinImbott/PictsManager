require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class.new(user, user) }

  let(:user) { create(:user) }
  it { should permit(:index) }
  it { should permit(:show) }
  it { should permit(:update)  }
  it { should permit(:destroy) }
end
