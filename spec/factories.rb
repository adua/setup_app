#Define user instances using factory

Factory.define :user do |user|
  user.name                   "Ashish Dua"
  user.email                  "adua1@jhu.edu"
  user.password               "password"
  user.password_confirmation  "password"
end
