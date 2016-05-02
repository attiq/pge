module Pge
  module PutsMail
    class NewEmailPage
      include PageObject

      page_url 'https://putsmail.com/tests/new'

      text_field(:email, id: 'recipient-value')
      text_field(:subject, id: 'email_test_subject')

      div(:flash, id: "flash-notice")
      button(:send, text: 'Send Email')

    end
  end
end