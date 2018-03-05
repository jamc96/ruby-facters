# Facter to determine if exist a bonding
Facter.add(:bond, :type => :aggregate) do
  confine :kernel => "Linux"

    chunk(:status) do
      bonding = {}
      status = Facter.value(:interfaces).split(',').any? { |key| key =~ /^bond(\d+)/ } ? 'true' : 'false'
      if !status.to_s.empty?
        bonding = {:status => status}
      end
      bonding
    end
    chunk(:interface) do
      bonding = {}
      interface = Facter.value(:interfaces).split(',').find { |key| key =~ /^bond(\d+)/}
      if !interface.to_s.empty?
        bonding = {:interface => interface}
      end
      bonding
    end

end
