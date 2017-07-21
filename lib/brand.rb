class Brand
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_brands = DB.exec("SELECT * FROM brands;")
    brands = []
    returned_brands.each() do |brand|
      name = brand.fetch("name")
      id = brand.fetch("id").to_i()
      brands.push(Brand.new({:name => name, :id => id}))
  end
  brands
end
end
