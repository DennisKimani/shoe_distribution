class Brand
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  # retrieves all the data in the database.
  define_singleton_method(:all) do
    returned_brands = DB.exec('SELECT * FROM brands;')
    brands = []
    returned_brands.each do |brand|
      name = brand.fetch('name')
      id = brand.fetch('id').to_i
      brands.push(Brand.new(name: name, id: id))
    end
    brands
  end

  # retrieves shoes using their unique id.
  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * FROM brands WHERE id -#{id};")
    name = result.first.fetch('name')
    Brand.new(name: name, id: id)
  end

  #save the shoes and gives them unique id.
  define_method(:save) do
    result = DB.exec("INSERT INTO brands (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end
end
