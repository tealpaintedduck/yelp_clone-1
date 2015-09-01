require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }

    describe 'relationship associations' do
      let(:kfc){ Restaurant.create(name: 'KFC') }

      it "has a dependent relationship with reviews" do
      kfc.reviews.create(thoughts: "ok", rating: 3)
      expect{ kfc.destroy }.to change{ Review.count }
    end
  end
end
