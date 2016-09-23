module Orgadmin
  class ImportSessionsController < Orgadmin::ApplicationController
    def new
      @import_session = ImportSession.new(merge_mode: 'merge')
    end

    def create
      params[:import_session][:organization_id] = @org.id
      import_session = ImportSession.new(params[:import_session])
      import_session.merge_into_membership
      redirect_to orgadmin_root_path
    end
  end
end
