# config/unicorn.rb
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true

working_directory "/home/joe/apps/woodsman/current"
pid "/home/joe/apps/woodsman/current/tmp/pids/unicorn.pid"
stderr_path "/home/joe/apps/woodsman/current/log/unicorn.log"
stdout_path "/home/joe/apps/woodsman/current/log/unicorn.log"

listen "/tmp/unicorn.woodsman.sock"

before_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
  EM.stop if defined?(EM) && EM.reactor_running?
end

after_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
    Thread.new { EM.run }
end