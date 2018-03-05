# Facter to determine the development techonology running
Facter.add(:devcode, :type => :aggregate) do
  confine :kernel => "Linux"
    # Validating differents devcode
    chunk(:name) do
      devcode = {}
      if Dir.glob('/opt/coldfusion*/cfusion/bin/coldfusion').any? or
        Dir.glob('/opt/coldfusion*/bin/coldfusion').any?
        devcode = {:name => 'coldfusion' }
      end
      if Dir.glob('/opt/lucee/lucee_ctl').any?
        devcode = {:name => 'lucee' }
      end
      if Facter::Util::Resolution.which('php')
        devcode = {:name => 'php'}
      end
      devcode
    end
    chunk(:version) do
      devcode = {}
      if Dir.glob('/opt/coldfusion*').any?
        if File.exist? '/opt/coldfusion8/bin/coldfusion'
          devcode = {:version => '8'}
        end
        if File.exist? '/opt/coldfusion9/bin/coldfusion'
          devcode = {:version => '9'}
        end
        if File.exist? '/opt/coldfusion10/cfusion/bin/coldfusion'
          devcode = {:version => '10'}
        end
        if File.exist? '/opt/coldfusion11/cfusion/bin/coldfusion'
          devcode = {:version => '11'}
        end
        if File.exist? '/opt/coldfusion12/cfusion/bin/coldfusion'
          devcode = {:version => '12'}
        end
      end
      devcode
    end
end
