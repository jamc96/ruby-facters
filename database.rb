# Facter to determine the database techonogy running
Facter.add(:database, :type => :aggregate) do
  confine :kernel => "Linux"

  chunk(:mysql) do
    if Facter::Util::Resolution.which('mysql') or
      Facter::Util::Resolution.which('mysqld')
      'mysql'
    end
  end
  chunk(:couchbase) do
    if Dir.glob('/opt/couchbase/bin/couchbase-server').any?
      'couchbase'
    end
  end
  # Filter the empty results
  aggregate do |chunks|
    result = ''
    chunks.each_value do |i|
      if !i.to_s.empty?
        result = i
      end
    end
    if result.to_s.empty?
      'unknown'
    else
      result
    end
  end

end
