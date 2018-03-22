# Facter to determine if exist a bonding
Facter.add(:bond, type: :aggregate) do
  confine kernel: 'Linux'

  chunk(:status) do
    bonding = {}
    status = if Facter.value(:interfaces).split(',').any? do |key|
      key =~ /^bond(\d+)/
    end
               'true'
             else
               'false'
             end
    bonding = { status: status } unless status.to_s.empty?
    bonding
  end
  chunk(:interface) do
    bonding = {}
    interface = Facter.value(:interfaces).split(',').find do |key|
      key =~ /^bond(\d+)/
    end
    bonding = {interface: interface} unless interface.to_s.empty?
    bonding
  end
end

