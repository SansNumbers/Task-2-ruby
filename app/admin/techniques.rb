ActiveAdmin.register Technique do
  permit_params :title, :description, :photo, :gender, :total_steps, :age, :status, :duration

  filter :title
  filter :gender
  filter :duration

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :photo, as: :file
      f.input :gender
      f.input :age
      f.input :total_steps
      f.input :status
      f.input :duration
    end
    f.actions
  end
end
