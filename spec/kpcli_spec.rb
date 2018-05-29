# frozen_string_literal: true

require 'spec_helper'

describe 'kpcli Installation' do
  describe docker_build(path: '.', tag: 'thinkstackio/kpcli', rm: true) do
    it { should have_label 'Author' => 'Lee Myring <mail@thinkstack.io>' }
    it { should have_label 'Description' => 'kpcli wrapper instance' }
    it { should have_label 'Version' => '0.2' }
    it { should have_maintainer 'Lee Myring' }
    it { should have_user 'nobody' }
    it { should have_entrypoint '/bin/entrypoint.sh' }
    it { should have_volume '/keepassx' }
    it { should have_workdir '/keepassx' }

    its(:arch) { should eq 'amd64' }
    its(:os) { should eq 'linux' }

    describe docker_build('spec/', tag: 'thinkstackio/kpcli_test') do
      docker_env = {
        'FILENAME' => 'keepassx.kdbx',
        'PASSWORD' => 'password',
        'ENTRY' => '/Root/Test\ Group/Test',
        'DOCKER_SPEC_KEEPALIVE' => 'true'
      }
      wait = ENV['TRAVIS'] ? 10 : 2

      describe docker_run('thinkstackio/kpcli_test', family: 'debian', env: docker_env, wait: wait) do
        %w[
          /usr/bin/kpcli
          /keepassx/keepassx.kdbx
        ].each do |file|
          describe file(file) do
            it { should exist }
            it { should be_file }
            it { should be_owned_by 'root' }
          end
        end

        %w[
          /keepassx/keepassx.pwd
          /keepassx/keepassx.out
        ].each do |file|
          describe file(file) do
            it { should_not exist }
          end
        end

        describe 'Describe packages' do
          %w[kpcli].each do |package|
            describe package(package) do
              it { should be_installed }
              it 'has package in the path' do
                expect(command("which #{package}").exit_status).to eq 0
              end
            end
          end
        end

        describe 'Describe container logs' do
          its(:stdout) { should include 'IAmAPasswordSafelySecured' }
          its(:stderr) { should_not include 'No filename specified' }
          its(:stderr) { should_not include 'No password specified' }
          its(:stderr) { should_not include 'No entry specified' }
        end
      end
    end
  end
end
