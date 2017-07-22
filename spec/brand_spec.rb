require("spec_helper")

  describe(Brand) do

    describe("#initialize") do
      it("is initialized with a name") do
        brand = Brand.new({:name => "Brad Pitt", :id => nil})
        expect(brand).to(be_an_instance_of(Brand))
      end

      it("can be initialized with its database ID") do
        brand = Brand.new({:name => "Brad Pitt", :id => 1})
        expect(brand).to(be_an_instance_of(Brand))
      end
    end

    describe(".all") do
      it("starts off with no stores") do
        expect(Brand.all()).to(eq([]))
      end
    end

    describe(".find") do
      it("returns a Brand by its ID number") do
        test_Brand = Brand.new({:name => "Brad Pitt", :id => nil})
        test_brand.save()
        test_brand2 = Brand.new({:name => "George Clooney", :id => nil})
        test_brand2.save()
        expect(Brand.find(test_brand2.id())).to(eq(test_brand2))
      end
    end

    describe("#==") do
      it("is the same brand if it has the same name and id") do
        brand = Brand.new({:name => "Brad Pitt", :id => nil})
        brand2 = Brand.new({:name => "Brad Pitt", :id => nil})
        expect(brand).to(eq(brand2))
      end
    end

    describe("#update") do
      it("lets you update brands in the database") do
        brand = Brand.new({:name => "George Clooney", :id => nil})
        brand.save()
        brand.update({:name => "Brad Pitt"})
        expect(brand.name()).to(eq("Brad Pitt"))
      end

      it("lets you add a store to an brand") do
        store = Store.new({:name => "Oceans Eleven", :id => nil})
        store.save()
        brand = Brand.new({:name => "George Clooney", :id => nil})
        brand.save()
        brand.update({:store_ids => [store.id()]})
        expect(brand.stores()).to(eq([store]))
      end
    end

    describe("#delete") do
      it("lets you delete an brand from the database") do
        brand = Brand.new({:name => "George Clooney", :id => nil})
        brand.save()
        brand2 = Brand.new({:name => "Brad Pitt", :id => nil})
        brand2.save()
        brand.delete()
        expect(Brand.all()).to(eq([brand2]))
      end
    end

    describe("#stores") do
      it("returns all of the stores a particular brand has been in") do
        store = Store.new(:name => "Oceans Eleven", :id => nil)
        store.save()
        store2 = Store.new(:name => "Oceans Twelve", :id => nil)
        store2.save()
        brand = Brand.new(:name => "George Clooney", :id => nil)
        brand.save()
        brand.update(:store_ids => [store.id()])
        brand.update(:store_ids => [store2.id()])
        expect(brand.stores()).to(eq([store, store2]))
      end
    end
  end
