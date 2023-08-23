
25.times.each do |x|
    Product.create!(
        name: "Test #{x}",
        oriprice: 11000,
        disprice: 10000,
        brand: "brand #{x}",
        user_id: 1
    )
end
