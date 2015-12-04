namespace :data do
  desc 'Allocate user to expert for review'
  task staff: :environment do
    Staff.create!(account: 'admin', password: '123456', password_confirmation: '123456', name: '管理员', available: true)
  end
end