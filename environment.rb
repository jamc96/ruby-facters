# Facter to determine the architecture envirnoment
Facter.add(:base_environment) do
  confine :kernel => 'Linux'
  setcode do
    hostname = Facter.value(:hostname)
    case hostname
    when /^.{1,3}(?:p)(\w+)/
      'production'
    when /^.{1,3}(?:s)(\w+)/
      'staging'
    when /^.{1,3}(?:t)(\w+)/
      'testing'
    when /^.{1,3}(?:d)(\w+)/
      'development'
    else
      'local'
    end
  end
end
