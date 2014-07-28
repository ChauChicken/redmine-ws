# encoding: UTF-8

require 'wrest'
require 'yaml'
require 'pp'

module RedmineWs
  class Redmine
    @@config_folder = 'config'
    @@config_file = 'redmine-ws.yml'
    @@od = '|'
    @@key_api_header = 'X-Redmine-API-Key'
  
    def initialize
	generateRedminesAttributes
        puts "Url: #{@url}"
    end
  
    def get_projects(name)
       #resp = Net::HTTP.get_response(URI.parse(@url))
       #resp_text = resp.body
       redmine = getRedmine(name)
       url = redmine['url']
       puts "Url en get: #{url}"
       response = url.to_uri(:timeout => 5, :verify_mode => OpenSSL::SSL::VERIFY_NONE).get(@@key_api_header => redmine['key'])
  
       proyectos = []
       puts "Code: #{response.code}"
       xml = response.deserialise
       projects = xml['projects']
       projects.each do |p|
          row = {}
          proyectos.push(row)
          row['identifier'] = p['identifier']
          row['name'] = p['name']
          row['sarhaCode'] = redmine['sarhaCode'] #Uso el default configurado en el yml de configuración
          row['description'] = ( (p['description'].nil?) ? "" : p['description'] )
#          proyectos.push(p['identifier'] << @@od << p['name'] << @@od << ((p['description']. nil?) ? "" : p['description']))
       end
       proyectos.to_json
    end

    private
       def parse_yaml
	   YAML::load(File.open(File.join(@@config_folder, @@config_file)))
       end

       def generateRedminesAttributes
	   @redmines = {}
	   items = parse_yaml
	   puts items.inspect
	   items.each do |item|
             attrs = {}
             @redmines[item['name']] = attrs
             attrs['url'] = item['protocol'] << '://' << item['host'] << ':' << item['port'].to_s << item['service']
             attrs['key'] = item['key']
             attrs['sarhaCode'] = item['sarhaCode']
           end
       end

       def getRedmine(name)
          redmine = @redmines[name]
          if redmine.nil?
             raise "No se encuentra configurado " << name << ". Chequee su url."
          end
          redmine
       end
  end
end
