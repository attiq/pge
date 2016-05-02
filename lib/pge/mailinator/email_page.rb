module Pge
  module Mailinator
    class EmailPage
      include PageObject

      div(:putsmail, text: 'Would you like to receive email drafts?')

      div(:show_mail_div, id: 'public_showmaildiv')

      in_iframe(:id => 'publicshowmaildivcontent') do |frame|
        link(:yes_link, link_text: 'Yes, I’m happy to accept email drafts', :frame => frame)
        element(:email_body, tag_name: 'body', :frame => frame)
      end

      button(:inbox, class: 'btn btn-sm btn-dark')

      div(:mail_div, id: 'public_maildirdiv')

      div(:email, class: 'row ng-scope', index: 0)

      cell(:subject_cell, :text => "Subject:")

      def email_subject
        subject_cell_element.parent.td(index: 1).text
      end

    end
  end
end