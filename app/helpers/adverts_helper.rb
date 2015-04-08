module AdvertsHelper
  def tags_to_link(list)
    list.map { |tag| link_to tag, tag_path(tag) }.join(', ').html_safe
  end
end
