class Song < ActiveRecord::Base
  validates :title, :artist_name, presence: true
  validates :released, inclusion:{in:[false,true]}
  validate :same_artist_not_allowed_in_same_year, :release_year_validation



  private
  def same_artist_not_allowed_in_same_year
    if Song.find_by(artist_name:self.artist_name,   release_year: self.release_year, title:self.title)
      errors.add(:artist_name, "release the same song twice in a year")
    end
  end

  def release_year_validation
    if released==true
      if !release_year
        errors.add(:release_year, "can't be empty if the song is already released")
      elsif release_year > Time.now.year
        errors.add(:release_year, "must be less than or equal to the current year")
      end
    end
  end
end
