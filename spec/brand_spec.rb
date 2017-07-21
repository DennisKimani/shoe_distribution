require('spec_helper')

describe(Brand) do
  # starts with no shoe-brands.
  describe('.all') do
    it('starts off with no brands') do
      expect(Brand.all()).to(eq([]))
    end
  end

  #finds the shoe-brands using their ids.
  describe(".find") do
    it("returns a brand by its ID number") do
      test_brand = Brand.new({:name => "Akala", :id => nil})
      test_brand.save()
      test_brand2 = Brand.new({:name => "Rubber", :id => nil})
      test_brand2.save()
      expect(Brand.find(test_brand2.id())).to(eq(test_brand2))
    end
  end

  #for comparing the infomation entering the database so as to avoid having two of them.
  describe("#==") do
    it("is the same brand if it has the same name and id") do
      brand = Brand.new({:name => "Rubber", :id => nil})
      brand2 = Brand.new({:name => "Bata", :id => nil})
      expect(brand).to(eq(movie2))
    end
  end
end
