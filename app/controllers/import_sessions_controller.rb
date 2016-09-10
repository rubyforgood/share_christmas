class ImportSessionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_org_and_authorize
  layout 'org_admin'

  def new
    @import_session = ImportSession.new(
      organization_id: params[:organization_id],
      merge_mode: 'merge'
    )
  end

  def create
    import_session = ImportSession.new(params[:import_session])
    import_session.merge_into_membership
    redirect_to organization_path(id: import_session.organization_id)
  end
end
