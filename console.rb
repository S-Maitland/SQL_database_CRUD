require ('pry-byebug')
require_relative('models/bounty.rb')

bounty1 = Bounty.new({
  'name' => 'Hans Solo',
  'homeworld' => 'Earth',
  'danger_level' => 'medium',
  'bounty_value' => '5000000'
})

bounty1.save()

bounty2 = Bounty.new({
  'name' => 'Dr Evil',
  'homeworld' => 'Earth',
  'danger_level' => 'low',
  'bounty_value' => '1000000'
})

bounty2.save()

bounty3 = Bounty.new({
  'name' => 'Thanos',
  'homeworld' => 'Earth',
  'danger_level' => 'ermagerdyerderd',
  'bounty_value' => '90000000'
})

bounty3.save()
binding.pry
#Updating bounty3 homeworld from earth to Titan
# bounty3.homeworld = "Titan"
# bounty3.update()
#
bounties = Bounty.all()
# # Bounty.delete_all()
# Bounty.find_by_name('Thanos')
