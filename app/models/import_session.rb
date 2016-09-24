# Note this is not persisted to the database.

class ImportSession
  include ActiveModel::Model

  attr_accessor :organization_id, :list_text, :list_file, :merge_mode

  def merge_into_membership
    org = Organization.friendly.find(organization_id)

    # If the mode is "replace" remove all membership records.  DO NOT remove
    # associated users because they might be associated with other organizations
    Membership.where(organization: org).destroy_all if merge_mode == 'replace'

    # Loop through all import lines, and create a user for each if they
    # don't already exist.  Then create a membership link.
    @list_text = list_file.read unless list_file.nil?
    list_text.each_line do |m|
      (firstname, lastname, email) = parse_membership_line(m)

      user_params = {
        first_name: firstname.strip,
        last_name: lastname.strip,
        email: email.strip
      }
      user = User.find_by(email: user_params[:email]) ||
             create_user_for_membership(user_params)
      Membership.find_by(organization: org, user: user) ||
        Membership.create!(
          organization: org,
          user: user,
          send_email: false # TODO: maybe this should be settable?
        )
    end
  end

  private

  def parse_membership_line(m)
    if m =~ /(.+)<(.+)>/
      fullname = $LAST_MATCH_INFO[1]
      email = $LAST_MATCH_INFO[2]
      # If the name is of the form Last, First
      if fullname =~ /(.+),(.+)/
        lastname = $LAST_MATCH_INFO[1]
        firstname = $LAST_MATCH_INFO[2]
      else
        fullname_components = fullname.split(' ')
        lastname = fullname_components[-1]
        firstname = fullname_components[0..-2].join(' ')
      end
    elsif m =~ /(.+),(.+),(.*)/
      firstname = $LAST_MATCH_INFO[1]
      lastname = $LAST_MATCH_INFO[2]
      email = $LAST_MATCH_INFO[3]
    else
      firstname = ''
      lastname = ''
      email = m
    end
    [firstname, lastname, email]
  end

  # TODO: this is almost the same as in memberships_controller
  def create_user_for_membership(user_params)
    something = user_params.merge(
      password: ENV['USER_PASSWORD'],
      password_confirmation: ENV['USER_PASSWORD']
    )
    User.create!(something)
  end
end
