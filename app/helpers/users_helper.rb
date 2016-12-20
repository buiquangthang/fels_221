module UsersHelper

  def gravatar_for user, size: Settings.user_helper.size
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag gravatar_url, alt: user.name, class: "profile-user-img img-responsive img-circle"
  end

  def search_user_by_id user_id
    User.find_by id: user_id
  end
end
