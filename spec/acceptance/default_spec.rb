require 'spec_helper_acceptance'

describe 'vision_docker' do
  context 'with defaults' do
    it 'run idempotently' do
      pp = <<-FILE

        file { '/vision':
          ensure => directory,
        }

        class { 'vision_docker': }
      FILE

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    context 'Docker installed' do
      describe package('docker-ce') do
        it { is_expected.to be_installed }
      end
    end

    context 'Prone' do
      describe file('/etc/systemd/system/docker-system-prune.timer') do
        it { is_expected.to be_file }
        its(:content) { is_expected.to match 'daily' }
      end
      describe file('/etc/systemd/system/docker-system-prune.service') do
        it { is_expected.to be_file }
        its(:content) { is_expected.to match 'docker system prune' }
      end
    end

    context 'Apt' do
      describe file('/etc/apt/sources.list.d/docker.list') do
        it { is_expected.to be_file }
        its(:content) { is_expected.to match 'Puppet' }
        its(:content) { is_expected.to match 'stable' }
        its(:content) { is_expected.to match 'docker' }
      end
    end
  end
end
