class ContactMailer < ApplicationMailer
  def contact_mail(user, picture)
    @user = user
    @picture = picture
    mail to: @user.email, subject: %q(記事を投稿しました！)
  end
end
