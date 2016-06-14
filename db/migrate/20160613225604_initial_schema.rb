class InitialSchema < ActiveRecord::Migration
  def change
    #
    # Holiday
    #
    # The specific volunteer center activity, e.g. "Share Your Christmas" or "Backpacks for School"
    #   has_many :campaigns
    #
    #   program.current_drive
    #
    create_table :holidays do |t|
      t.string :name, limit: 100, null: false
      t.string :season                                        # Christmas, Thanksgiving, Spring
      t.text :about
      t.boolean :active, default: true, null: false

      t.timestamps
      
      t.index :name
    end

    #
    # Campaign
    #
    # Programs often repeat each year, so familes and clients will be associated with the specific Drive
    #   belongs_to :holiday
    #   has_many :deadlines
    #
    #
    create_table :campaigns do |t|
      t.references :holiday, null: false
      t.string :name, limit: 50, null: false                 # e.g. "2012", or "Winter 2012"
      t.boolean :active, default: true, null: false
      
      t.timestamps
      
      t.index :holiday_id
      t.index :name
    end

    #
    # Deadline
    #
    # Dates associated with a campaign
    #
    #   belongs_to :campaign
    #
    create_table :deadlines do |t|
      t.references :campaign, null: false
      t.string :name, limit: 60, null: false
      t.date :due_date, null: false
      t.time :due_time
      t.date :reminder_date
      t.string :description, limit: 100, null: false
      
      t.timestamps
      
      t.index :campaign_id
    end


    #
    # Organization
    #
    # The collaborating organization - e.g. "Aldersgate United Methodist Church"
    #   belongs_to :leader (UserProfile)
    #
    create_table :organizations do |t|
      t.string :name,  limit: 100, null: false
      t.string :key, limit: 50                                       # short name for URL
      t.string :email_from, limit: 100                                      # the visual from in email if possible
      t.string :image_uid, :limit => 500
      t.string :image_name, :limit => 100
      t.boolean :active, default: true, null: false

      t.text :instructions
      t.text :about

      t.timestamps
      
      t.index :name
      t.index :key
    end

    #
    # SocialWorker
    #
    # The Social Worker assiting the client family
    #   has_many :clients
    #
    create_table :social_workers do |t|
      t.string :name,  limit: 100, null: false
      t.string :email, limit: 200
      t.string :phone, limit: 20
      t.boolean :active, default: true, null: false

      t.timestamps
      
      t.index :name
    end

    #
    # RecipientFamily
    #
    # The Family registering for assistance - associated with a campaign and an organization
    # Notes:
    #   - a client can belong to a campaign, before being assigned to an organization 
    #
    #   belongs_to :drive
    #   belongs_to :partnership
    #   belongs_to :social_worker
    #
    #   has_many :family_members
    #   has_one :sponsorship          (for food)
    #
    # 
    create_table :recipient_families do |t|
      t.references :campaign,    null: false
      t.references :organization,  null: true                  # until assigned
      t.references :social_worker, null: false                 # may not be available at first

      t.integer :casenumber                                   # SYC# needs to be integer for proper sorting
      t.string :last_name,  limit: 40, null: false            # Patterson-Robertson, III
      t.string :first_name, limit: 40                         # Theodore Alexander Frederick
      t.string :address,    limit: 200
      t.string :city,       limit: 50
      t.string :state,      limit: 2, default: 'NC'
      t.string :zip,        limit: 10
      t.string :phone,      limit: 100
      t.string :profile,    limit: 2000
      
      t.boolean :deliverable, null: false, default: true
      t.string  :latlng, limit: 60

      t.timestamps
      
      t.index :campaign_id
      t.index :organization_id
      t.index :social_worker_id
      t.index :casenumber
    end

    # Recipient
    #
    # members of the recipient family
    #   belongs_to :client
    #   has_one :sponsorship
    #
    create_table :recipients do |t|
      t.references :recipient_family, null: false
      t.references :match

      t.string  :first_name, limit: 60, null: false           # generally, we don't collect full names
      t.decimal :age, :precision => 5, :scale => 2            # in years, up to 199.99 (express months as decimal years 1/12, 2/12, etc) - gets rounded in display
      t.string  :gender, limit: 1                             # class Gender::OPTIONS = {"F"=>"Female", "M"=>"Male", "U"=>"Unknown"}
      t.string  :race, limit: 1                               # class Race::OPTIONS = {"A"=>"Asian", "B"=>"Black", "H"=>"Hispanic", "W"=>"White"}
      t.string  :size                                         # text: Infant, Toddler, Petite, Small, Medium, Large, X-Large, XX-Large, XXX-Large
      t.string  :need, limit: 1000                            # gift request
      t.boolean :bike, null: false, default: false            # special flag if gift requests include a Bicycle

      t.timestamps
      
      t.index [:recipient_family_id, :age]
    end

    #
    # Giver
    #
    # The person sponsoring a family member. Maybe we'll add devise_to this model later
    #   has_many :recipients
    #
    create_table :givers do |t|
      t.string :name,  limit: 100, null: false
      t.string :email, limit: 200, null: false
      t.string :phone, limit: 20

      t.timestamps
      
      t.index :email
    end

    # Match
    #
    #   belongs_to :giver
    #   belongs_to :recipient
    #
    create_table :matches do |t|
      t.references :giver, null: false
      t.references :recipient, null: true

      t.timestamps
      
      t.index :giver_id
      t.index :recipient_id
    end

  end
end
