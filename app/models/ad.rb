class Ad < ActiveRecord::Base
  belongs_to :member
  belongs_to :category, counter_cache: true
  has_many :comments

  # Callbacks
  before_save :md_to_html

  # Validates
  validates :title, :description_md, :description_short, :category, presence: true 
  validates :picture, :finish_date, presence: true
  validates :price, numericality: {greater_than: 0} 

  # Scopes
  scope :descending_order, -> (page) {
    order(created_at: :desc).page(page).per(6)
  }

  scope :search, -> (term, page = 1) { 
    where("lower(title) LIKE ?", "%#{term.downcase}%").page(page).per(6) 
  }

  scope :to_the, -> (member) { where(member: member) }
  
  scope :by_category, -> (id, page) { where(category: id).page(page).per(6)}

  scope :random, ->(quantity) {
    if Rails.env.production?
      limit(quantity).order("RAND()") # MySQL
    else
      limit(quantity).order("RANDOM()") # SQLite
    end
  }

  # Ratyrate gem
  ratyrate_rateable 'quality'

  #paperclip images
  has_attached_file :picture, styles: { large: "800x300#", medium: "320x150#", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  #Price rails - Price in whole cents
  monetize :price_cents


  private
    def md_to_html
      options = {
        filter_html: true,
        link_attributes: {
          rel: "nofollow",
          target: "_blank"
        }
      }

      extensions = {
        space_after_headers: true,
        autolink: true
      }

      renderer = Redcarpet::Render::HTML.new(options)
      markdown = Redcarpet::Markdown.new(renderer, extensions)

      self.description = markdown.render(self.description_md)
        
    end 

end
