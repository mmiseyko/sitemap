class SiteLinkSerializer < ActiveModel::Serializer
  attributes :id, :link_id, :name, :relative_path, :full_path

  def full_path
    pathes = tree_path.map(&:relative_path)
    File.join(*pathes)
  end

  def link_id
    tree_path.map(&:name).join('.').underscore
  end

  private

  def parents
    @parents ||= @instance_options[:parents] || object.ancestors
  end

  def tree_path
    @tree_path ||= parents + [object]
  end
end
