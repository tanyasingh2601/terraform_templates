import smtplib
import sys
import os
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
import base64

mail_content = '''Hello,
This is a test mail.
In this mail we are sending some attachments.
Thank You
'''
#The mail addresses and password
sender_address = '
sender_pass = ''
receiver_address = sys.argv[1]

#Setup the MIME
message = MIMEMultipart()
message['From'] = sender_address
message['To'] = receiver_address
message['Subject'] = 'AWS IAM User credentials'
#The subject line

#The body and the attachments for the mail
message.attach(MIMEText(mail_content, 'plain'))
file_name = "creds.txt"
attach_file = open(file_name, 'rb') # Open the file as binary mode
payload = MIMEBase('application', 'octate-stream')
payload.set_payload((attach_file).read())
encoders.encode_base64(payload) #encode the attachment

#add payload header with filename
payload.add_header('Content-Decomposition', 'attachment', filename=file_name)
message.attach(payload)

#Create SMTP session for sending the mail
session = smtplib.SMTP('smtp.gmail.com', 587) #use gmail with port
session.starttls() #enable security
session.login(sender_address, sender_pass) #login with mail_id and password
text = message.as_string()
session.sendmail(sender_address, receiver_address, text)
session.quit()
print('Mail Sent')
os.remove("creds.txt")
