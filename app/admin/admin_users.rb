ActiveAdmin.register AdminUser do

  menu priority: 3, parent: "Admin"

  actions :all, :except => [:new, :edit, :update, :destroy]

  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end
end
