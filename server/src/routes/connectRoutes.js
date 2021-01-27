const express = require('express');
const isLoggedIn = require("../passport/isLoggedIn");

const router = express.Router();

// router.get('/microsoft', isLoggedIn, async (req, res) => {
//     try {
//
//     } catch (err) {
//         console.log(err);
//         res.redirect('/'); // TODO: front home page.
//     }
// });

module.exports = router;
