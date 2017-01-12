class Supports::DocumentSupport
  def initialize
  end

  def newest_documents
    Document.newest
  end

  def own_documents user
    Document.own_documents user
  end
end
