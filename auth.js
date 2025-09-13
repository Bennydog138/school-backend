const jwt = require('jsonwebtoken'); const db = require('./db');

function authenticateJWT(req, res, next){ const auth = req.headers.authorization; if(!auth) return res.status(401).json({error:'Missing authorization'}); const token = auth.split(' ')[1]; try{ const payload = jwt.verify(token, process.env.JWT_SECRET); req.user = payload; next(); }catch(e){ return res.status(401).json({error:'Invalid token'}) } }

function requireRole(role){ return (req,res,next)=>{ if(!req.user) return res.status(401).json({error:'Not authenticated'}); if(req.user.role !== role) return res.status(403).json({error:'Forbidden'}); next(); } }

module.exports = { authenticateJWT, requireRole };
