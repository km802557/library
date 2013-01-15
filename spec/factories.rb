FactoryGirl.define do
  factory :publication do
    title "Lorem ipsum"
    author
  end
  
  
  
  factory :author do
    sequence(:lastname)  { |n| "Person #{n}" }
    sequence(:firstname)  { |n| "Person #{n}" }
    sequence(:nickname) { |n| "Person #{n}" }
    sequence(:labo) { |n| "Labo #{n}"}   
    password "foobar"
    password_confirmation "foobar"
    factory :admin do
      admin true
    end
  end
end
