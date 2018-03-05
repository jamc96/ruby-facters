# Facter to determine if exist a bonding
Facter.add(:bond, :type => :aggregate) do
  confine :kernel => "Linux"
    chunk(:status) do
      status = Facter.value(:interfaces).split(',').any? { |key| key =~ /^bond(\d+)/ } ? 'true' : 'false'
      status unless status.to_s.empty
    end
    chunk(:interface) do
      interface = Facter.value(:interfaces).split(',').find { |key| key =~ /^bond(\d+)/}
      interface unless interface.to_s.empty
    end
end

