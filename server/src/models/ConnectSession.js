const mongoose = require('mongoose');

const ConnectSessionSchema = new mongoose.Schema({
    userId: {
        type: String,
        required: true,
        unique: false
    },
    endpoint: {
        type: String,
        required: true,
        unique: false
    },
    isMobile: {
        type: Boolean,
        required: true
    }
});

const ConnectSessionModel = mongoose.model('connectSession', ConnectSessionSchema);

module.exports = ConnectSessionModel;
