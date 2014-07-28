#require 'net/http'
require 'wrest'
require 'yaml'
require 'pp'

module RedmineWs
  class Redmine
    @@config_folder = 'config'
    @@config_file = 'redmine-ws.yml'
    @@od = '|'
  
    def initialize
	generateRedminesUrls
        puts "Url: #{@url}"
    end
  
    def get_projects(name)
       #resp = Net::HTTP.get_response(URI.parse(@url))
       #resp_text = resp.body
       url = getUrlFromRedmine(name)
       puts "Url en get: #{url}"
       response = url.to_uri(:timeout => 5).get
  
       proyectos = []
       puts "Code: #{response.code}"
       xml = response.deserialise
       projects = xml['projects']
       projects.each do |p|
          proyectos.push(p['identifier'] << @@od << p['name'] << @@od << p['description'])
       end
       proyectos.to_json
    end

    private
       def parse_yaml
	   YAML::load(File.open(File.join(@@config_folder, @@config_file)))
       end

       def generateRedminesUrls
	   @redmines = {}
	   items = parse_yaml
	   puts items.inspect
	   items.each do |item|
             @redmines[item['name']] = item['protocol'] << '://' << item['host'] << ':' << item['port'].to_s << item['service']
           end
       end

       def getUrlFromRedmine(name)
           url = @redmines[name]
	   if url.nil?
	      raise "No se encuentra configurado " << name << ". Chequee su url."
	   end
	   url
       end

  end
end
