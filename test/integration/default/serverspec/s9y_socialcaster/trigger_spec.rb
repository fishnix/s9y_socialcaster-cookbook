require 'spec_helper'

describe package('curl') do
  it { should be_installed }
end

describe cron do
  command = '/usr/bin/curl -X POST -H "Content-Type: application/json" '
  command += "-d '{\"token\":\"somesecrettokenstring\"}' "
  command += 'http://localhost:4567/api/tweet '
  command += '2>&1'
  it { should have_entry "10 16/21 * * * #{command}" }
end
