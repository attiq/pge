require 'spec_helper'

describe Pge do
  include PageObject::PageFactory

  it 'has a version number' do
    expect(Pge::VERSION).not_to be nil
  end

  it 'sends and receives email' do
    visit(Pge::PutsMail::HomePage).create_email

    user_name = Faker::Internet.user_name
    email = "#{user_name}@mailinator.com"
    subject = Faker::Lorem.words
    body = Faker::Lorem.paragraph

    # fill out the form with the above email, subject and body
    # send email

    visit(Pge::PutsMail::NewEmailPage) do |page|
      page.email = email
      page.subject = subject
      execute_script("window.editor.setValue(\"#{body}\");")
      page.send
      page.wait_until do
        page.flash_element.visible?
      end
    end

    visit(Pge::Mailinator::HomePage) do |page|
      page.inbox = user_name
      page.go
    end

    # #verify that there is an email present from putsmail.com
    # #open that email and accept with the 'Yes....' link
    # #verify that now there is an email that you sent
    # #open the email
    #
    on(Pge::Mailinator::EmailPage) do |page|

      page.wait_until do
        page.putsmail_element.visible?
      end

      if page.putsmail_element.exist?

        page.putsmail_element.click

        page.wait_until do
          page.show_mail_div_element.visible?
        end

        page.yes_link
        page.inbox

        sleep 30
      end

      page.wait_until do
        page.mail_div_element.visible?
      end

      page.wait_until do
        page.email_element.visible?
      end

      if page.email_element.exist?
        page.email_element.click

        page.wait_until do
          page.show_mail_div_element.visible?
        end

        expect(page.email_subject).to eq("#{subject.join}")
        expect(page.email_body).to eq("#{body}")

      end
    end

  end

end
