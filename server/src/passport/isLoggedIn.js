const isLoggedIn = (req, res, next) => {
    return next();
    // if (req.isAuthenticated()) {
    //     return next();
    // }
    // return res.status(401).json({ 'statusCode': 401, 'message': 'Not authenticated.' });
};

module.exports = isLoggedIn;
