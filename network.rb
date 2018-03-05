# Facter to determine if exist a bonding
# Network configuration
# Network Profile
# Facter name: is_bonding
#
#
if Facter.value(:kernel) == 'Linux'
  #Instance the global variables
  is_bonding = false
  interfaces_string = Facter.value(:interfaces)
  interfaces_array =  interfaces_string.split(',')

  #Validating if bonding exist
  is_bonding = interfaces_array.any? { |key| key =~ /^bond(\d+)/ } ? 'true' : 'false'
  #Saving the bond interface
  bond_interface = interfaces_array.find { |key| key =~ /^bond(\d+)/}
  #validating if the bond variable is empty
  if bond_interface.to_s.empty?
    bond_interface = 'unknown'
  end

    #Adding new facter
    if is_bonding
      Facter.add('is_bonding') do
        confine :kernel => :linux
        setcode { is_bonding }
      end
      Facter.add('bond_interface') do
        confine :kernel => :linux
        setcode { bond_interface }
      end
  end
end
