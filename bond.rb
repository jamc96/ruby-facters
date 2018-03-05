# Facter to determine if exist a bond
Facter.add(:bond, :type => :aggregate) do
  confine :kernel => 'Linux'
    chunk(:status) do
      bond = { :status => Facter.value(:interfaces).split(',').any? { |key| key =~ /bond(\d+)/ } ? 'true' : 'false' }
    end
    chunk(:interface) do
      if Facter.value(:interfaces) =~ /bond(\d+)/
        bond = { :interface => Facter.value(:interfaces).split(',').find { |key| key =~ /bond(\d+)/} } 
      end
    end
end

