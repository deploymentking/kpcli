# frozen_string_literal: true

require 'spec_helper'

describe 'kpcli Installation' do
  describe docker_build(path: '.', tag: 'thinkstackio/kpcli', rm: true) do
    it { should have_label 'Author' => 'Lee Myring <mail@thinkstack.io>' }
    it { should have_label 'Description' => 'kpcli wrapper instance' }
    it { should have_maintainer 'Lee Myring' }
    it { should have_user 'nobody' }
    it { should have_entrypoint '/bin/entrypoint.sh' }

    its(:arch) { should eq 'amd64' }
    its(:os) { should eq 'linux' }

    describe docker_build('spec/', tag: 'thinkstackio/kpcli_test') do
      docker_env = {
        'PASSWORD' => 'password',
        'ENTRY' => '/Root/Test\ Group/Test',
        'DOCKER_SPEC_KEEPALIVE' => 'true'
      }
      wait = ENV['TRAVIS'] ? 10 : 2

      describe docker_run('thinkstackio/kpcli_test', family: 'debian', env: docker_env, wait: wait) do
        %w[
          /usr/bin/kpcli
          /bin/keepassx.kdbx
          /bin/keepassx.pwd
          /bin/keepassx.out
        ].each do |file|
          describe file(file) do
            it { should exist }
            it { should be_file }
            it { should be_owned_by 'root' }
          end
        end

        %w[kpcli].each do |package|
          describe "Describe package #{package}" do
            describe package(package) do
              it { should be_installed }
            end

            it 'has package in the path' do
              expect(command("which #{package}").exit_status).to eq 0
            end
          end
        end

        describe file('/bin/keepassx.out') do
          it { should exist }
          it { should be_file }
          it { should be_owned_by 'root' }
          its(:content) { should eq("IAmAPasswordSafelySecured\n") }
        end
      end
    end
  end
end
