require 'sshkit'
require 'sshkit/dsl'
include SSHKit::DSL

deploy_tag = ENV['DEPLOY_TAG']
deploy_env = ENV['DEPLOY_ENV'] || :production
deploy_path = ENV['DEPLOY_PATH'] || "/home/#{ENV['SERVER_USER']}"

server = SSHKit::Host.new hostname: ENV['SERVER_HOST'], port: ENV['SERVER_PORT'], user: ENV['SERVER_USER']

namespace :docker do

  desc 'pulls images, stops old containers, updates the database, and starts new containers'
  task deploy: %w{docker:pull docker:stop docker:migrate docker:start}

  desc 'pulls images from Docker Hub'
  task pull: 'docker:login' do
    on server do
      within deploy_path do
        %w{pitchbattle_web pitchbattle_app}.each do |image_name|
          execute 'docker', 'pull', "#{ENV['DOCKER_USER']}/#{image_name}:#{deploy_tag}"
        end

        execute 'docker', 'pull', 'postgres:9.5.3'
      end
    end
  end

  desc 'logs into Docker Hub for pushing and pulling'
  task :login do
    on server do
      within deploy_path do
        execute 'docker', 'login', '-e' , ENV['DOCKER_EMAIL'], '-u', ENV['DOCKER_USER'], '-p', "'#{ENV['DOCKER_PASS']}'"
      end
    end
  end

  desc 'stops all Docker containers via Docker Compose'
  task stop: 'deploy:configs' do
    on server do
      within deploy_path do
        with rails_env: deploy_env, deploy_tag: deploy_tag do
          execute 'docker-compose', '-f', 'docker-compose.production.yml', 'stop'
        end
      end
    end
  end

  desc 'runs database migrations in application container via Docker Compose'
  task migrate: 'deploy:configs' do
    on server do
      within deploy_path do
        with rails_env: deploy_env, deploy_tag: deploy_tag do
          execute 'docker-compose', '-f', 'docker-compose.production.yml', 'run', 'app', 'bundle', 'exec', 'rake', 'db:migrate'
        end
      end
    end
  end

  desc 'starts all Docker containers via Docker Compose'
  task start: 'deploy:configs' do
    on server do
      within deploy_path do
        with rails_env: deploy_env, deploy_tag: deploy_tag do
          execute 'docker-compose', '-f', 'docker-compose.production.yml', 'up', '-d'

          # write the deploy tag to file so we can easily identify the running build
          execute 'echo', deploy_tag , '>', 'deploy.tag'
        end
      end
    end
  end

end

namespace :deploy do

  desc 'copy to server files needed to run and manage Docker containers'
  task :configs do
    on server do
      upload! File.expand_path('../../.docker/docker-compose.production.yml', __dir__), deploy_path
    end
  end

end

