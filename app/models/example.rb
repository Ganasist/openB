class Example < ActiveRecord::Base

  include JobValidations
  include GlobalConcerns

  belongs_to :contractor

  DURATION_UNITS = ['hours', 'days', 'weeks', 'months']

  def before_uploads
    self.uploads.where(before: true)
  end

  def after_uploads
    self.uploads.where(after: true)
  end
end
