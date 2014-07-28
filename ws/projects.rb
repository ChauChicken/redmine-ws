#!/usr/bin/env ruby
# encoding: UTF-8

require 'sinatra'
require 'json'
require_relative 'redmine'

set :port, 8080
set :environment, :production

redmine = RedmineWs::Redmine.new

get '/:name/projects' do
    #projects = {'proyectos' => [{'area' => 'dearin', 'proyecto' => 'project1'}, {'area' => 'dit', 'proyecto' => 'proyect2'}]}
    #projects.to_json
    redmine.get_projects(params[:name])
end

not_found do
  '404 - No hay nada aquí. Cheque su URL'
end

error do
  '500 - Error en el servidor - ' + env['sinatra.error'].message
end
