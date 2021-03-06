module ApplicationHelper

  def show_list_creators(options={})
    document = options[:document]
    creator_roles = document.fetch(:creator_role)
    options[:value].map.with_index do |creator, index|
      capture do 
        concat link_to "#{creator}", search_action_path(search_state.add_facet_params(options[:field], creator))
        unless creator_roles[index].nil?
          creator_role = creator_roles[index]
          if (creator_role != "n/a")
            concat " (#{creator_role})"
          end
        end
      end
    end.join('<br />').html_safe
  end

  def iiif_thumbnail_url_field(document=@document)
    image_id = document.fetch(:publish_image) ? document.fetch(:id) : 'arthub:placeholder'
    riiif_image_url(image_id, size: "206,")
  end
end
