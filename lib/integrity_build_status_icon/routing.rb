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
      send_file file_path.expand_path, type: 'image/' + icon.split('.').last,
                last_modified: last_modified
    end

    def status_icon_map
      {building: 'clock.gif',
       pending: 'tetris.gif',
       success: 'status_passing.png',
       failed: 'status_failing.png'}
    end

    def status_icon_for_build build
      status_icon_map[build.status]
    end
  end
end
