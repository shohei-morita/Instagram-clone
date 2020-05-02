module PicturesHelper
  def choose_new_or_edit
    if action_name == %q(new) || action_name == %q(create) || action_name == %q(confirm)
      confirm_pictures_path
    elsif action_name == %q(edit)
      picture_path
    end
  end
end
