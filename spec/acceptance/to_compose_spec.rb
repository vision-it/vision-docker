require 'spec_helper_acceptance'

describe 'vision_docker::to_compose' do
  context 'with defaults' do
    it 'run idempotently' do
      pp = <<-FILE
      vision_docker::to_compose { 'redis':
        path => '/tmp/swarm',
        compose => {
          'version' => '3',
          'services' => {
            'redis' => {
              'image' => 'redis:latest',
            },
          },
        }
      }

      FILE

      apply_manifest(pp, catch_failures: true)
    end

    context 'Compose File' do
      describe file('/tmp/swarm/redis.yaml') do
        it { is_expected.to be_file }
        its(:content) { is_expected.to match 'Puppet' }
        its(:content) { is_expected.to match 'version: \'3\'' }
        its(:content) { is_expected.to match 'image: redis:latest' }
      end
    end
  end
end
