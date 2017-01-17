module ApplicationHelper
  def localize_time datetime
    datetime.strftime(I18n.t(:"datetime.formats.default", locale: I18n.locale))
  end

  def load_categories
    @categories = Category.all
  end

  def active_class_locale locale
    locale == I18n.locale ? "active" : ""
  end

  def generate_conversation message
    user = message.user
    host = message.chatroom.host
    end_html = "<span class='username'>#{user.name}</span>: #{message.body}</div>"
    end_right_html = "#{message.body} :<span class='username'>#{user.name}
      </span></div>"

    user != host ? "<div class='message left'>" +
      end_html : "<div class='message right'>" + end_right_html
  end
end
