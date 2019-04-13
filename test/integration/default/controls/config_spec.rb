control 'Mediawiki configuration' do
  title 'should match desired lines'

  describe file('/var/www/html/default/LocalSettings.php') do
    it { should be_file }
    it { should be_owned_by 'apache' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0644' }
  end
end
