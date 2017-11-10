require 'spec_helper'
require 'hiera'

describe 'vision_docker' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'compile' do
        it { is_expected.to compile.with_all_deps }
      end

      context 'contains' do
        it do
          is_expected.to contain_class('docker').with(
                              'tcp_bind' => 'tcp://0.0.0.0:2375'
                            )
        end
        it { is_expected.to contain_class('docker::compose') }
        it { is_expected.to contain_file('/etc/systemd/system/docker-system-prune.service').with_content('[Service]') }
        it { is_expected.to contain_file('/etc/systemd/system/docker-system-prune.timer').with_content('[Timer]') }
      end
    end
  end
end
