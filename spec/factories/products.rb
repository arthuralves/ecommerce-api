FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price(range: 100.0..400.0) }


    # Este recurso after :build permite que após a construção de um objeto de Product pela factory, a gente acesse ele e crie um model Game utilizando a factory e atribua em productable. Este productable é um recurso da associação polimórfica que tem objeto que está associado com o model utilizando os campos productable_type e productable_id    
    after :build do |product|
      product.productable = create(:game)
    end
  end
end
