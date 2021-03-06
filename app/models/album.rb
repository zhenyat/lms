################################################################################
# Model:  Album
#
# Purpose:
#
# Album attributes:
#   title             - title:           string,  not NULL
#   content           - content:  text
#   images            - images gallery:  json
#   position          - sorting index:   integer, not NULL
#   status            - status:          enum { active (0) | archived (1) }
#   cover             - cover image:     string
#
#  24.08.2017 ZT
#  27.08.2017   Cover added
################################################################################
class Album < ApplicationRecord
  mount_uploaders :images, ImageUploader
  mount_uploader  :cover,  CoverUploader
  
  before_save     :set_position

  enum status: %w(active archived)

  validates :title, presence: true

  private

    def set_position
      if self.id.blank?
        last_item = Album.order(:position).last
        self.position = last_item.blank? ? 1 : last_item.position.to_i + 1
      end
    end
end
