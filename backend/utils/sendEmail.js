const nodemailer = require('nodemailer');

// Configure the email transporter
const transporter = nodemailer.createTransport({
  service: 'Gmail',  // You can use any email service
  auth: {
    user: '',
    pass: ''
  }
});

function sendEmail(to, subject, text) {
  const mailOptions = {
    from: '',
    to,
    subject,
    text
  };

  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      console.log('Error sending email:', error);
    } else {
      console.log('Email sent: ' + info.response);
    }
  });
}

module.exports = sendEmail;
