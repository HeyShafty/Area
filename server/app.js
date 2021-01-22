const express = require('express');
const expressSession = require('express-session');
const mongoose = require('mongoose');
const passport = require('passport');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');
const morgan = require('morgan');
const moment = require('moment');

const authRouter = require('./src/routes/authRoutes');

const { ALLOWED_ORIGINS } = require('./src/config/config');
const { MONGO_URI, MONGO_DB_NAME, MONGO_USER, MONGO_PASSWORD } = require('./src/config/mongoConfig');

const port = process.env.SERVER_PORT || 8080;

function startServer() {
  const app = express();

  app.use(morgan('combined'));
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded({
    extended: false
  }));
  app.use(expressSession({
    secret: 'keyboard cat',
    resave: false,
    saveUninitialized: false
  }));
  app.use(cookieParser());
  app.set('trust proxy', true);
  app.use(cors({
    origin: ALLOWED_ORIGINS,
    credentials: true
  }));
  app.use(passport.initialize({}));
  app.use(passport.session({}));

  app.get('/', (req, res) => {
    res.send('Hello World!');
  });

  app.use('/auth', authRouter);

  app.get('/about.json', (req, res) => {
    res.json({ client: { host: req.ip }, server: { current_time: moment().unix() } });
  });

  app.listen(port, () => { console.log(`Example app listening at http://localhost:${port}`); });
}

function connectToDb() {
  mongoose.connect(MONGO_URI, {
    user: MONGO_USER,
    pass: MONGO_PASSWORD,
    dbName: MONGO_DB_NAME,
    useNewUrlParser: true,
    useUnifiedTopology: true
  });
  const db = mongoose.connection;
  db.on('error', console.error.bind(console, 'connection error:'));
  db.once('open', () => {
    startServer();
  });
}

connectToDb();
