require 'spec_helper'

describe 'omd', :type => 'class' do

  # tests defaults includes
  context "No variable are given and osfamily is not set to debian or redhat" do
    let :facts do {
      :osfamily => 'Arch',
    }
    end
    it {
      expect { should raise_error(Puppet::Error) }
    }
  end

  context "Osfamily is set to debian, operatingsystem is set to debian and no variables aren't given" do
    let :facts do {
      :osfamily               => 'Debian',
      :operatingsystem        => 'Debian',
      :operatingsystemrelease => '7.4'
    }
    end

  end
end
