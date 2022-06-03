# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
    let(u1) { create (:user) }
    let(u2) { create (:user) }
    let(u3) { create (:user) }

    context "with invalid parameters" do
    subject { u1 }

    it { is_expected.to_not be_successful }
    end
end
