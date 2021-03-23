FactoryBot.define do
  factory :user, class: "User" do
    name {'admin'}
    email {'admin@example.org'}
    password {'123456'}
  end
end
