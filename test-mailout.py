from maap.maap import MAAP
from timeit import default_timer as timer
maap = MAAP()

print(maap.secrets.get_secrets())

import argparse
import os
YOUR_GOOGLE_EMAIL = maap.secrets.get_secret("mail_e")
YOUR_GOOGLE_EMAIL_APP_PASSWORD = maap.secrets.get_secret("mail_p")

import smtplib
from pathlib import Path
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email.mime.text import MIMEText
from email.utils import formatdate
from email import encoders
COMMASPACE = ", "

parser = argparse.ArgumentParser(description='Testing')
parser.add_argument('-basedir', help='Location of this code', default='daily-trace-gases/')

def mail_with_batsign(message_str = "", subject_str = ""):
    # curl --data $'Subject: Important notice\nHammer time!' https://batsign.me/at/kilgoret6@gmail.com/77975fc777

    command_str = "curl --data $'Subject: "+subject_str+"\n"+message_str+"' https://batsign.me/at/kilgoret6@gmail.com/77975fc777"
    os.system(command_str)

def send_mail(send_from, send_to, subject, message, files=[]):
    # Works!
    """Compose and send email with provided info and attachments.

    Args:
        send_from (str): from name
        send_to (list[str]): to name(s)
        subject (str): message title
        message (str): message body
        files (list[str]): list of file paths to be attached to email
    """
    msg = MIMEMultipart()
    msg['From'] = send_from
    msg['To'] = COMMASPACE.join(send_to)
    msg['Date'] = formatdate(localtime=True)
    msg['Subject'] = subject

    msg.attach(MIMEText(message))

    for path in files:
        part = MIMEBase('application', "octet-stream")
        with open(path, 'rb') as file:
            part.set_payload(file.read())
        encoders.encode_base64(part)
        part.add_header('Content-Disposition',
                        'attachment; filename={}'.format(Path(path).name))
        msg.attach(part)

    smtpserver = smtplib.SMTP_SSL('smtp.gmail.com', 465)
    smtpserver.ehlo()
    smtpserver.login(YOUR_GOOGLE_EMAIL, YOUR_GOOGLE_EMAIL_APP_PASSWORD)
    smtpserver.sendmail(send_from, send_to, msg.as_string())
    smtpserver.close()



if __name__ == '__main__':

    send_mail("previtus@gmail.com", ["previtus@gmail.com"], "Testing mail",
              "foobar mail from maap", files=[])

    args = parser.parse_args()
    basedir = args.basedir
    trying_path = os.path.join(args.basedir, "no2-prediction_scored.geojson")
    print("trying path:", trying_path)
    from pathlib import Path

    file_path = Path(trying_path)
    if file_path.is_file():
        print("The file exists.")
    else:
        print("The file does not exist.")

    send_mail("previtus@gmail.com", ["previtus@gmail.com"], "Testing mail with attachment",
              "foobar mail from maap", files=[trying_path])

