require 'spec_helper_acceptance'

describe 'vision_docker' do
  context 'with defaults' do
    it 'idempotentlies run' do
      pp = <<-EOS
        class { 'vision_docker': }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end
end
