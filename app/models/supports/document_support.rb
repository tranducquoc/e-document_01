class Supports::DocumentSupport
  def initialize
  end

  def newest_documents
    Document.newest
  end

  def own_documents user
    Document.own_documents user
  end

  def own_documents user
    Document.own_documents user
  end

  def read_documents user
    Document.get_read_document user
  end
end
