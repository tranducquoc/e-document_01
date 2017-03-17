module ApplicationHelper
  def localize_time datetime
    datetime.strftime(I18n.t(:"datetime.formats.default", locale: I18n.locale))
  end

  def load_categories
    @categories = Category.all
  end

  def load_series user, organization_id = nil
    @series = user.series.where(organization_id: organization_id)
  end

  def load_image
    @images = Imageslide.all.enable
  end

  def load_value_coin
    @list_value = Coin.pluck("DISTINCT value")
  end

  def load_user_will_be_shared_by_document document
    ids = Share.share_user.select(:share_id).where(document_id: document.id) +
      [document.user.id]
    User.where.not(id: ids)
  end

  def user_not_in_organization organization
    user_ids = GroupMember.select(:user_id).where(group_id: organization.id,
      group_type: :organization)
    User.where.not(id: user_ids)
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

   def load_user_will_share_document document, organization
    ids = Share.share_user.select(:share_id).where(document_id: document.id) +
      [document.user.id]
    user_in_organization_ids = GroupMember.select(:user_id).where(
      group_id: organization.id, group_type: :organization)
    User.where(id: user_in_organization_ids).where.not(id: ids)
  end
end
