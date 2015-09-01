require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }

    describe 'relationship associations' do
      let!(:kfc){ Restaurant.create(name: 'KFC') }
      let!(:kfc_review){ Review.create(thoughts: 'so so', rating: 2) }
      it "has a dependent relationship with reviews" do
      kfc.reviews << kfc_review
      expect{ kfc.destroy }.to change{ Review.count }
    end
  end
end
