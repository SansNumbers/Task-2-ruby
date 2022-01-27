ActiveAdmin.register Coach do
  permit_params :name, :email, :age, :gender, :about, :password, :coach_avatar, :education, :experience, :licenses, :socials

  filter :email
  filter :name
  filter :age

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :age
      f.input :gender
      f.input :about
      f.input :password
      f.input :education
      f.input :experience
      f.input :licenses
      f.input :socials
      f.input :coach_avatar, as: :file
    end
    f.actions
  end

end
