FactoryBot.define do
  factory :game do
    mode { %i(pvp pve both).sample }
    release_date { '2020-06-01' }
    developer { Faker::Company.name }
    # um atalho que informa que existe uma associação deste model com SystemRequirement e que, quando Game for criado, essa associação deve existir, então ele também cria um SystemRequirement para associar.
    system_requirement
  end
end
