# Facter to determine the webserver techonogy running
Facter.add(:webserver, :type => :aggregate) do
  confine :kernel => "Linux"

chunk(:apache) do
  if Facter::Util::Resolution.which('apachectl') or
    Facter::Util::Resolution.which('apache2ctl')
    'apache'
  end
end
chunk(:nginx) do
  if Facter::Util::Resolution.which('nginx')
    'nginx'
  end
end
chunk(:glassfish) do
  if Dir.glob('/opt/glassfish*/glassfish*/bin/asadmin').any?
    'glassfish'
  end
end
chunk(:wildfly) do
  if Dir.glob('/etc/init.d/wildfly').any? or
    Dir.glob('/opt/wildfly/wildfly*/bin/init.d/wildfly-init-redhat.sh ').any?
    'wildfly'
  end
end
chunk(:tomcat) do
  if Dir.glob('/opt/tomcat/bin/startup.sh').any? or
    Dir.glob('/opt/tomcat/bin/daemon.sh').any? or
    Dir.glob('/opt/apache-tomcat*/bin/startup.sh').any?
    'tomcat'
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
