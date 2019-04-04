class OrderMailer < ActionMailer::Base
    default from: "kokos.uss@yandex.ru"


   def order(order)
        @order = order
        @email = "kokosussur@gmail.com"
        mail to: @email, :reply_to=> @email, subject: "заказ"
   end
end