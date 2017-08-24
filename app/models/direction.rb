################################################################################
# Model:  Direction
#
# Purpose: Directions of activity
#
# Direction attributes:
#   name              - name:           string,  not NULL, unique
#   title             - title:          string,  not NULL
#   cover             - cover picture:  string
#   position          - sorting index:  integer, not NULL
#   status            - status:         enum { active (0) | archived (1) }
#
#  22.08.2017 ZT
################################################################################
class Direction < ApplicationRecord
  mount_uploader :cover, CoverUploader
  
  before_save :set_position

  enum status: %w(active archived)

  validates :name,  presence: true, uniqueness: true
  validates :title, presence: true

  private

    def set_position
      if self.id.blank?
        last_item = Direction.order(:position).last
        self.position = last_item.blank? ? 1 : last_item.position.to_i + 1
      end
    end
end
