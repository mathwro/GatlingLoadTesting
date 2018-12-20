desc "Bygg en container til at køre tests"
task :build do
  sh "docker build -t load-test ."
end

desc "Kør en test"
task :test do
  java_opts = ""
  java_opts += "-Dusers=#{ENV['users']} " if ENV['users']
  java_opts += "-Dduration=#{ENV['duration']} " if ENV['duration']

  command = "docker run -it "
  command += "--volume `pwd`/user-files/:/opt/gatling/user-files "
  command += "--volume `pwd`/results/:/opt/gatling/results "
  command += "--env JAVA_OPTS=\"#{java_opts}\" " unless java_opts.empty?
  command += "load-test "
  command += "-s #{ENV['simulation']} " if ENV['simulation']
  sh command
end
