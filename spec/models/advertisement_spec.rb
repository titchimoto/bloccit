require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let (:advertisement) { Advertisement.create!(title: "New Advert Title", copy: "New Advert Copy", price: 5) }

  describe "attributes" do
    it "has title, body and price attributes" do
      expect(advertisement).to have_attributes(title: "New Advert Title", copy: "New Advert Copy", price: 5)
    end
  end
end
