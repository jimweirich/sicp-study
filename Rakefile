require 'rubygems'
require 'redcloth'
require 'rake/clean'

CLOBBER.include("html")

task :readme => "html/README.html"

directory "html"
file "html/README.html" => ["README.textile", "html"] do |t|
  textile = open(t.name.pathmap("%n.textile")) { |f| f.read }
  open(t.name, 'w') do |outs|
    outs.write(RedCloth.new(textile).to_html)
  end
end
