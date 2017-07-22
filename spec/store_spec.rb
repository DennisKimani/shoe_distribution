require("spec_helper")

  describe(Store) do


    describe(".all") do
      it("starts off with no stores") do
        expect(Store.all()).to(eq([]))
      end
    end

    describe(".find") do
      it("returns a store by its ID number") do
        test_store = Store.new({:name => "Oceans Eleven", :id => nil})
        test_store.save()
        test_store2 = Store.new({:name => "Oceans twelve", :id => nil})
        test_store2.save()
        expect(Store.find(test_store2.id())).to(eq(test_store2))
      end
    end

    describe("#==") do
      it("is the same store if it has the same name and id") do
        store = Store.new({:name => "Oceans Eleven", :id => nil})
        store2 = Store.new({:name => "Oceans Eleven", :id => nil})
        expect(store).to(eq(store2))
      end
    end

    describe("#update") do
      it("lets you update stores in the database") do
        store = Store.new({:name => "Oceans Eleven", :id => nil})
        store.save()
        store.update({:name => "Oceans Twelve"})
        expect(store.name()).to(eq("Oceans Twelve"))
      end

      it("lets you add an brand to a store") do
        store = Store.new({:name => "Oceans Eleven", :id => nil})
        store.save()
        george = Brand.new({:name => "George Clooney", :id => nil})
        george.save()
        brad = Brand.new({:name => "Brad Pitt", :id => nil})
        brad.save()
        store.update({:brand_ids => [george.id(), brad.id()]})
        expect(store.brands()).to(eq([george, brad]))
      end
    end

    describe("#brands") do
    it("returns all of the brands in a particular store") do
      store = Store.new({:name => "Oceans Eleven", :id => nil})
      store.save()
      george = Brand.new({:name => "George Clooney", :id => nil})
      george.save()
      brad = Brand.new({:name => "Brad Pitt", :id => nil})
      brad.save()
      store.update({:brand_ids => [george.id(), brad.id()]})
      expect(store.brands()).to(eq([george, brad]))
    end
  end

    describe("#delete") do
      it("lets you delete a store from the database") do
        store = Store.new({:name => "Oceans Eleven", :id => nil})
        store.save()
        store2 = Store.new({:name => "Oceans Twelve", :id => nil})
        store2.save()
        store.delete()
        expect(Store.all()).to(eq([store2]))
      end
    end
  end
