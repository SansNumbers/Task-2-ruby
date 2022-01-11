ActiveAdmin.register User do
  permit_params :name, :email, :age, :gender, :about, :password, :user_avatar

  filter :name
  filter :email
  filter :age
  filter :gender
  filter :current_sign_in_at
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :age
      f.input :gender
      f.input :about
      f.input :user_avatar, as: :file
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
