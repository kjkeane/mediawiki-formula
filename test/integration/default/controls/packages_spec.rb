control 'Mediawiki package' do
  title 'should be installed'

  described pacakge('apache') do
    it { should be_installed  }
  end
end
