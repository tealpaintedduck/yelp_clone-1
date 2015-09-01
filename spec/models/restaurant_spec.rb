require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }

  it 'is not valid with a name of less than 3 characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  describe 'relationship associations' do
    let(:kfc){ Restaurant.create(name: 'KFC') }

    it "has a dependent relationship with reviews" do
      kfc.reviews.create(thoughts: "ok", rating: 3)
      expect{ kfc.destroy }.to change{ Review.count }
    end
  end
end
