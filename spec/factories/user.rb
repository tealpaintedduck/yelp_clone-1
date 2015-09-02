FactoryGirl.define do
  factory :user do
    email "jeremy@jermyisgreat.com"
    password "12345678"
    password_confirmation "12345678"

    factory :jeremina do
      email "jeremina@jermyisgreat.com"
    end
  end
end