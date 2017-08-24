################################################################################
# Model:  Tour
#
# Purpose:
#
# Tour attributes:
#   title       - title:              string,  not NULL
#   start_date  - Tour's start_date : date,    not NULL
#   finish_date - Tour's finish_date: date,    not NULL
#   content     - content:            text,    not NULL
#   cover       - cover:              string
#   status      - status:             enum { active (0) | archived (1) }
#
#  24.08.2017 ZT
################################################################################
class Tour < ApplicationRecord
  mount_uploader :cover, CoverUploader
  
  enum status: %w(active archived)

  validates :title,       presence: true
  validates :start_date,  presence: true
  validates :finish_date, presence: true
  validates :content,     presence: true
end
