const passport = require('passport');
const GithubStrategy = require('passport-github2').Strategy;
const User = require('../models/User');
const { MONGOOSE_GITHUB_KEY } = require('../config/githubConfig');
const { GITHUB_PASSPORT_CONFIG } = require('../config/githubConfig');

const STRATEGY_GITHUB = 'github';

// passport.use(new GithubStrategy(GITHUB_PASSPORT_CONFIG,
//     async function (req, accessToken, refreshToken, profile, cb) {
//         const user = req.user;

//         try {
//             user.connectData.set(MONGOOSE_GITHUB_KEY, { accessToken: accessToken, refreshToken: refreshToken });
//             await User.updateOne({ email: user.email, isMicrosoftAuthed: user.isMicrosoftAuthed }, user);
//             return cb(null, user);
//         } catch (e) {
//             return cb(null, false);
//         }
//     }
// ))
passport.use(new GithubStrategy(GITHUB_PASSPORT_CONFIG,
  function(req, accessToken, refreshToken, profile, done) {
    console.log(accessToken);
  }
));

module.exports = {
    STRATEGY_GITHUB
}