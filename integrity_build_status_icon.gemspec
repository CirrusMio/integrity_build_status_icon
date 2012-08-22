Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  s.name              = 'integrity_build_status_icon'
  s.version           = '0.0.9'
  s.date              = '2012-08-22'

  s.summary     = 'Visual indicators of build status'
  s.description = 'Shows icons for build that are currently building, failed, or passed over an HTTP endpoint in IntegrityCI.'

  s.authors  = ['Mildmojo', 'xtoddx']
  s.email    = 'xtoddx@gmail.com'
  s.homepage = 'http://github.com/CirrusMio/integrity_build_status_icon'

  s.require_paths = %w[lib]

  # 1.2.0 exposed last_modified to send_file
  s.add_dependency('sinatra', '> 1.2.0')

  s.files = `git ls-files`.split("\n")
end
