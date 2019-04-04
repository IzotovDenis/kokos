class OrderMailer < ActionMailer::Base
    default from: "kokos.uss@yandex.ru"


   def order(order)
        @order = order
        @email = "izotov87@gmail.com"
        mail to: @email, :reply_to=> @email, subject: "письмо"
   end
end