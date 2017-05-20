source "gpg -d ~/.mutt/passwords.gpg |"
set imap_user = "machat.v"
set folder = imaps://imap.gmail.com
set spoolfile = +INBOX
set record = "+[Gmail]/Sent Mail"
set postponed = "[Gmail]/Drafts"
set timeout = 10

set smtp_url = 'smtps://machat.v@smtp.gmail.com'
set record = ''
set mail_check_stats

