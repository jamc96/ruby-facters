#!/usr/bin/ruby
# Facter to determine if the ldap connection is working
# Fact_name: ldap_connection (true/false)
# The user for the test will be Admin user currently registered in ldap servers
#
#
if Facter.value(:kernel) == 'Linux'
    user = 'Admin'
    conn_string = "/usr/bin/env id " + user
    test_connection = Facter::Util::Resolution.exec(conn_string)
    ldap_connect_arr = test_connection.split(' ')
    # Validating ldap connection
    ldap_connection = ldap_connect_arr.any? { |key| key =~ /^uid=(\d+)/ } ? 'true': 'false'
    # Creating facter ldap_connection
    if ldap_connection
      Facter.add('ldap_connection') do
        confine :kernel => :linux
        setcode { ldap_connection }
      end
    end
end
