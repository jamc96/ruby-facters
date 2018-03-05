Facter.add(:user_splunk) do
  has_weight 100
  setcode { Facter::Util::Resolution.exec("ps -ef | grep splunk | grep -v grep | awk '{print $1;}' | uniq") }
end
Facter.add(:user_splunk) do
  has_weight 90
  setcode { Facter::Util::Resolution.exec("ps aux | grep splunkd | awk '{ print $1 }' | sed '1 d' | sort | uniq") }
end
Facter.add(:user_splunk) do
  has_weight 80
  setcode { Facter::Util::Resolution.exec("ps aux | grep splunk | awk '{ print $1 }' | sed '1 d' | sort | uniq 2>/dev/null") }
end
