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
end
