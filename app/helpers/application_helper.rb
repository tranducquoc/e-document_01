module ApplicationHelper
  def localize_time datetime
    datetime.strftime(I18n.t(:"datetime.formats.default", locale: I18n.locale))
  end

  def load_categories
    @categories = Category.all
  end

  def load_value_coin
    @list_value = Coin.pluck("DISTINCT value")
  end

  def load_user_will_be_shared_by_document document
    ids = Share.share_user.select(:share_id).where(document_id: document.id) +
      [document.user.id]
    User.where.not(id: ids)
  end

  def active_class_locale locale
    locale == I18n.locale ? "active" : ""
  end

  def generate_conversation message
    user = message.user
    host = message.chatroom.host
    end_html = "</span><span class='userhost'>#{user.name}</span>:
      <span class='content_host'>#{message.body}</span></div>"
    end_right_html = "<span class='usergest'>#{user.name}</span>:
    <span class='content_gest'>#{message.body}</span></div>"

    user != host ? "<div class='message-left'>" +
      end_html : "<div class='message-right'>" + end_right_html
  end
end
