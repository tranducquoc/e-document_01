class Supports::DocumentSupport
  def initialize
  end

  def newest_documents
    Document.newest
  end

  def own_documents user
    Document.own_documents user
  end

  def read_documents user
    Document.get_read_document user
  end

  def list_comments document
    document.comments.newest
  end

  def list_reviews document
    (document.reviews.order created_at: :desc).includes(:user)
  end

  def get_download_free user
    current_date = Time.now - Settings.number_seven_2
    Download.get_download_free user,
      current_date.strftime(Settings.format_date)
  end

  def get_document_fav document, user
    Favorite.find_by document_id: document.id,
      user_id: user.id
  end
end
