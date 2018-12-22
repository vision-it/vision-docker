require 'spec_helper'
require 'hiera'

describe 'vision_docker::swarm' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:params) do
        {
          manager_ip: '1.2.3.4',
          ipaddress: '4.3.2.1',
          join_token: 'winteriscoming',
          hostname: 'johnsnow'
        }
      end

      context 'compile' do
        it { is_expected.to compile.with_all_deps }
      end

      context 'contains' do
        it {
          is_expected.to contain_class('vision_docker')
        }

        it {
          is_expected.to contain_docker__swarm('swarm_johnsnow').with(
                           'manager_ip' => '1.2.3.4',
                           'advertise_addr' => '4.3.2.1',
                           'listen_addr'    => '4.3.2.1',
                           'token'          => 'winteriscoming',
                           'join'           => true,
                           'init'           => false
                         )
        }
      end
    end
  end
end
