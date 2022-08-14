email = ENV["ADMIN_EMAIL"] || "admin@gmail.com"
unless User.exists?(email: email)
  admin = User.new(
    email: email
  )

  admin.password = "111111"
  admin.save
end
