# frozen_string_literal: true

class Term < ActiveYaml::Base
  set_root_path 'app/models/activeyaml'
  set_filename 'terms'

  include ActiveHash::Associations
  has_many :users
end
