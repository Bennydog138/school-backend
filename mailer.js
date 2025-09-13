const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({ host: process.env.SMTP_HOST, port: Number(process.env.SMTP_PORT || 587), secure: Number(process.env.SMTP_PORT) === 465, auth: { user: process.env.SMTP_USER, pass: process.env.SMTP_PASS } });

async function sendOncallAlert(adminEmails, payload){ const subject = OnCall Alert — ${payload.category} — Room ${payload.room}; const text = OnCall Alert\n\nRoom: ${payload.room}\nCategory: ${payload.category}\nDetails: ${payload.details || ''}\nRequested by: ${payload.requestedByName} (${payload.requestedByEmail})\nTime: ${new Date(payload.created_at).toLocaleString()}; return transporter.sendMail({ from: process.env.FROM_EMAIL, to: adminEmails.join(','), subject, text }); }

module.exports = { sendOncallAlert };
