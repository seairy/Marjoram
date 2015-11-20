namespace :data do
  desc 'Import hotel data'
  task import_hotel: :environment do
    Hotel.create!(name: '上海对外贸易学院国际交流中心酒店', address: '长宁区古北路620号对外贸易学院内', distance: '4公里', ferry_car: true).rooms.create!([
      { name: '双人间(床位)', price: 195, quantity: 60 },
      { name: '单人间', price: 390, quantity: 20 }
    ])
    Hotel.create!(name: '金水湾大酒店', address: '闸北区恒丰路308号', distance: '7公里', ferry_car: true).rooms.create!([
      { name: '双人间(床位)', price: 210, quantity: 100 }
    ])
    Hotel.create!(name: '锦江之星华师大店', address: '上海普陀区中山北路3500号', distance: '500米', ferry_car: false).rooms.create!([
      { name: '双人间(床位)', price: 138, quantity: 60 },
      { name: '单人间', price: 275, quantity: 15 }
    ])
  end
end