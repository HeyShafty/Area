const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const Schema = mongoose.Schema;

const ServiceSchema = new Schema({
    access_token: {
        type: String,
        default: ''
    },
    refresh_token: {
        type: String,
        default: ''
    }
});

const MicrosoftConnectSchema = new Schema({
    isConnected: {
        type: Boolean,
        required: true,
        default: false
    },
    homeAccountId: {
        type: String,
        default: ''
    },
    timeZone: {
        type: String,
        default: ''
    }
});

const MicrosoftConnect = mongoose.model('microsoftConnect', MicrosoftConnectSchema);

const UserSchema = new Schema({
    email: {
        type: String,
        required: true,
        unique: false
    },
    password: {
        type: String,
        default: ''
    },
    displayName: {
        type: String,
        default: ''
    },
    isMicrosoftAuthed: {
        type: Boolean,
        required: true,
        default: false
    },
    microsoftConnectData: {
        type: MicrosoftConnectSchema,
        default: MicrosoftConnect.create()
    },
    connectData: {
        type: Map,
        of: ServiceSchema,
        default: []
    }
});

UserSchema.pre('save', async function (next) {
    console.log(this.password);
    this.password = await bcrypt.hash(this.password, 10);
    next();
});

const UserModel = mongoose.model('user', UserSchema);

module.exports = UserModel;
