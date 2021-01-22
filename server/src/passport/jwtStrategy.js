const passport = require('passport');
const passportJWT = require('passport-jwt');
const JWTStrategy = passportJWT.Strategy;
const User = require('../models/User');

const { JWT_SECRET_KEY } = require('../config/jwtConfig');

const STRATEGY_JWT = 'jwt';

passport.use(STRATEGY_JWT, new JWTStrategy(
    {
        jwtFromRequest: req => req.headers.authorization,
        secretOrKey: JWT_SECRET_KEY
    },
    async (token, done) => {
        try {
            let user = await User.findOne({ email: token.user.email });

            if (!user) {
                return done(null);
            }
            return done(null, user);
        } catch(error) {
            done(error);
        }
    }))

module.exports = {
    STRATEGY_JWT
}