require 'rails_helper'

RSpec.describe PicturePolicy, type: :policy do
  subject { described_class.new(user, picture) }

  let(:user) { create(:user) }
  let(:picture) { create(:picture) }

  context "for a user" do
    it { should_not permit(:show) }
    it { should_not permit(:create)  }
    it { should_not permit(:new)     }
    it { should_not permit(:update)  }
    it { should_not permit(:edit)    }
    it { should_not permit(:destroy) }
  end
  context "for a owner" do
    it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:new)     }
    it { should permit(:update)  }
    it { should permit(:edit)    }
    it { should permit(:destroy) }
  end
end
