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

      # Docker within Docker not working
      apply_manifest(pp, catch_failures: false)
      apply_manifest(pp, catch_changes: false)
    end

    context 'Docker installed' do
      describe package('docker-ce') do
        it { is_expected.to be_installed.by('apt').with_version('5:19.03.2~3-0~debian-buster') }
      end
    end

    context 'Docker Daemon' do
      describe file('/etc/docker/daemon.json') do
        it { is_expected.to be_file }
        its(:content) { is_expected.to match 'privileges' }
        its(:content) { is_expected.to match '"userland-proxy": false' }
      end
    end

    context 'Prune' do
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
      describe file('/etc/apt/preferences.d/docker-ce.pref') do
        it { is_expected.to be_file }
        its(:content) { is_expected.to match 'Package: docker-ce' }
        its(:content) { is_expected.to match 'Pin: version 5:19.03.2~3-0~debian-buster' }
        its(:content) { is_expected.to match 'Priority: 1000' }
      end
    end
  end
end
