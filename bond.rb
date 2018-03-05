# Facter to determine if exist a bonding
Facter.add(:bond, :type => :aggregate) do
  confine :kernel => "Linux"

    chunk(:status) do
      bonding = {}
      status = Facter.value(:interfaces).split(',').any? { |key| key =~ /^bond(\d+)/ } ? 'true' : 'false'
      bonding = {:status => status} unless status.to_s.empty
    end
    chunk(:interface) do
      bonding = {}
      interface = Facter.value(:interfaces).split(',').find { |key| key =~ /^bond(\d+)/}
      bonding = {:interface => interface} unless status.to_s.empty
    end

end

