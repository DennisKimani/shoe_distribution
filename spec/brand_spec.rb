require("spec_helper")

describe(Brand) do

  describe(".all") do
    it("starts off with no brands") do
      expect(Brand.all()).to(eq([]))
    end
  end
end
