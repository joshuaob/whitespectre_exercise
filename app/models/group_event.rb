class GroupEvent < ApplicationRecord

  validates :status, inclusion: {in: %w[draft published]}
  validates :name, presence: true, on: :publish
  validates :description, presence: true, on: :publish
  validates :starts_at, presence: true, on: :publish
  validates :ends_at, presence: true, on: :publish
  validates :location, presence: true, on: :publish

  validate :starts_at_cannot_be_in_the_past
  validate :ends_at_cannot_be_in_the_past
  validate :ends_at_cannot_be_before_starts_at

  scope :published, -> { where(status: "published") }
  scope :published_and_visible, -> { published.where(deleted: false) }

  before_save :update_duration, if: :starts_at_changed?
  before_save :update_duration, if: :ends_at_changed?
  before_save :update_starts_at, if: :duration_changed?
  before_save :update_ends_at, if: :duration_changed?

  def publish!
    if self.valid?(:publish)
      self.status = "published"
      self.save
      return true
    end
    false
  end

  def mark_as_deleted!
    self.deleted = true
    self.save
  end

  private



  def starts_at_cannot_be_in_the_past
    if starts_at.present? && starts_at < Date.today
      errors.add(:starts_at, "can't be in the past")
    end
  end

  def ends_at_cannot_be_in_the_past
    if ends_at.present? && ends_at < Date.today
      errors.add(:ends_at, "can't be in the past")
    end
  end

  def ends_at_cannot_be_before_starts_at
    if ends_at.present? && starts_at.present? && ends_at < starts_at
      errors.add(:ends_at, "can't be before starts at")
    end
  end

  def update_duration
    if starts_at.present? && ends_at.present?
      self.duration = (self.ends_at - self.starts_at).to_i / 1.day
    end
  end

  def update_ends_at
    self.ends_at = self.starts_at + self.duration.days if duration.present?
  end

  def update_starts_at
    self.starts_at = Time.now
  end

end
