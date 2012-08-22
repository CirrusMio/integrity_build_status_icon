module IntegrityBuildStatusIcon
  module Routing
    def self.included kls
      kls.send(:get, '/:project/status_icon'){ build_status_icon_request }
    end

    private

    def build_status_icon_request
      login_required unless current_project.public?
      if last_build = current_project.last_build
        icon = status_icon_for_build(last_build)
        last_modified = last_build.completed_at || Time.now
      else
        icon = 'status_unknown.png'
        last_modified = current_project.updated_at
      end
      file_path = Pathname.new(__FILE__).join("../../../icons/#{icon}")
      puts "SENDING #{file_path.expand_path}"
      send_file file_path.expand_path, type: 'image/' + icon.split('.').last,
                last_modified: last_modified
    end

    def status_icon_for_build build
      return pending_status_icon unless last_build.completed_at
      last_build.successful ? 'status_passing.png' : 'status_failing.png'
    end

    def pending_status_icon
      ['clock', 'tetris'].sample + '.gif'
    end
  end
end
