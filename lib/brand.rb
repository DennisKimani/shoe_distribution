class Brand
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

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

  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * FROM brands WHERE id = #{id};")
    name = result.first.fetch('name')
    Brand.new(name: name, id: id)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO brands (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  define_method(:==) do |another_brand|
    name.==(another_brand.name).&(id.==(another_brand.id))
  end

  # method updates the brands stores
  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = id
    DB.exec("UPDATE brands SET name = '#{@name}' WHERE id = #{@id};")
  end

  # the method delete the ids after showing them
  define_method(:delete) do
    DB.exec("DELETE FROM brands WHERE id = #{id};")
    DB.exec("DELETE FROM brands_stores WHERE brand_id = #{id};")
  end

  # passes the method to show which stores an brand has being in.
  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE brands SET name = '#{@name}' WHERE id = #{id};")

    attributes.fetch(:store_ids, []).each do |store_id|
      DB.exec("INSERT INTO brands_stores (brand_id, store_id) VALUES (#{id}, #{store_id});")
    end
  end

  define_method(:stores) do
    brand_stores = []
    results = DB.exec("SELECT store_id FROM brands_stores WHERE brand_id = #{id};")
    results.each do |result|
      store_id = result.fetch('store_id').to_i
      store = DB.exec("SELECT * FROM stores WHERE id = #{store_id};")
      name = store.first.fetch('name')
      brand_stores.push(Store.new(name: name, id: store_id))
    end
    brand_stores
  end
  end
