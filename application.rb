# Facter to determine the architecture environment
Facter.add(:application, :type => :aggregate) do
  confine :kernel => 'Linux'

    hostname = Facter.value(:hostname)
    chunk(:name) do
      application = {}
      case hostname
      when /^.{1,3}(?:[t|d|s|p])(?:beaches)(?:wb)\d+/
        application = {:name => 'beachesweb'}
      when /^.{1,3}(?:[t|d|s|p])(?:sandals)(?:wb)\d+/
        application = {:name => 'sandalsweb'}
      when /^.{1,3}(?:[t|d|s|p]obec)(\d+)(?:wb)(\w+)/
        application = {:name => 'obeweb'}
      when /^.{1,3}(?:[t|d|s|p]obec)(\d+)(?:pol)(\w+)/
        application = {:name => 'obepol'}
      when /^.{1,3}(?:[t|d|s|p]obec)(\d+)(?:soa)(\w+)/
        application = {:name => 'obesoa'}
      when /^.{1,3}(?:[t|d|s|p]odsdb)(\d+)/
        application = {:name => 'odsdb'}
      when /^.{1,3}(?:[t|d|s|p]geowb)(\d+)/
        application = {:name => 'geoweb'}
      when /^.{1,3}(?:[t|d|s|p]geocb)(\d+)/
        application = {:name => 'geocb'}
      when /^.{1,3}(?:[t|d|s|p]butlerp)(\w+)(\d+)/
        application = {:name => 'butlerp'}
      else 
        application = {:name => 'none'}
      end
      application
    end
    chunk(:tier) do
      application = {}
      if hostname =~ /^.{1,3}(?:[t|d|s|p]obe)(\w+)/
        tier = hostname.match(/^.{1,3}(?:[t|d|s|p]obec)(\d+)(?:[a-z]{1,3})/).to_s
        application = {:tier => tier}
      end
      application
    end
end
