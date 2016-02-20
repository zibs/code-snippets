class Snippet < ActiveRecord::Base
  after_initialize :set_defaults
  belongs_to :user

  validates :kind, presence: true
  validates :title, presence: true, uniqueness: true
  validates :code, presence: true
  
  scope :recent, ->( number = 5){ order("created_at DESC").limit(number) }

   KIND_RUBY         = "Ruby"
   KIND_HTML         = "HTML"
   KIND_CSS          = "CSS"
   KIND_JAVASCRIPT   = "JavaScript"
   KINDS = [KIND_RUBY, KIND_HTML, KIND_CSS, KIND_JAVASCRIPT]

   def set_defaults
    self.kind ||= KIND_RUBY
  end

end
