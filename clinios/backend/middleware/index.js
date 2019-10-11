var jwt = require('jsonwebtoken');

checkToken = (req, res, next) => {
    var token = req.headers['x-access-token'] || req.headers['authorization'];
    if (token.startsWith('JWT')) {
        token = token.slice(4, token.length);
    }
    if (token) {
        token = token.replace(/['"]+/g, '');
        jwt.verify(token, 'secret', (err, decoded) => {
            if (err) {
                return res.status(409).json({
                    token: false,
                    message: 'Token is not valid.'
                });
            } else {
                req.decoded = decoded;
                next();
            }
        });
    } else {
        return res.json({
            token: false,
            message: 'Auth token is not supplied.'
        });
    }
}
module.exports = {
    token: checkToken
}