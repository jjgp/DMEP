const jwt = require('jsonwebtoken');
var path = require('path');
const signin = require('express').Router();

const SERVER_SECRET = 'server_secret';

const erroredInvalidCredentials = (res, next) => {
  res.sendStatus(401);
  next(new Error('Invalid credentials'));
}

signin.use('/', (req, res, next) => {
  if (req.method !== 'POST') {
    next();
    return;
  }

  req.rawBody = '';
  req.on('data', chunk => {
    req.rawBody += chunk;
  });

  req.on('end', () => {
    jwt.verify(req.rawBody, 'client_secret', (err, decoded) => {
      if (err) {
        erroredInvalidCredentials(res, next);
      } else {
        req.body = decoded;
        next();
      }
    });
  });
});

signin.get('/', (_, res) => {
  console.log('GET /signin')
  res.sendFile(path.join(__dirname + '/index.html'));
});

signin.get('/webflow', (req, res) => {
  const { username, password } = req.query;
  
  if (!username || !password) {
    console.log('POST /signin/webflow invalid credentials');
    res.sendStatus(401);
    return;
  }

  const token = jwt.sign({
    access_token: 'access_token',
    iat: Date.now(),
  },
    SERVER_SECRET);
  setTimeout(() => {
    res.set('Content-Type', 'text/plain');
    res.send(token);
  }, 2000);
});


signin.post('/', (req, res) => {
  console.log('POST /signin received: ', req.body);
  if (!req.body) {
    res.sendStatus(401);
  }

  const { client_id, username, password } = req.body;
  if (client_id !== 'client_id' || !username || !password) {
    console.log('POST /signin invalid credentials');
    res.sendStatus(401);
    return;
  }

  const token = jwt.sign({
    access_token: 'access_token',
    iat: Date.now(),
  },
    SERVER_SECRET);
  setTimeout(() => {
    res.set('Content-Type', 'text/plain');
    res.send(token);
  }, 2000);
});

const authorization = (timeout) => (req, res, next) => {
  const authorization = req.get('Authorization');
  if (!authorization) {
    erroredInvalidCredentials(res, next);
    return;
  }

  jwt.verify(authorization, SERVER_SECRET, (err, decoded) => {
    if (err) {
      erroredInvalidCredentials(res, next);
      return;
    }

    const { access_token, iat } = decoded;

    if (access_token !== 'access_token') {
      erroredInvalidCredentials(res, next);
      return;
    }

    if (timeout && (Date.now() - iat) > timeout) {
      erroredInvalidCredentials(res, next);
      return;
    }

    next();
  });
}

module.exports = {
  authorization,
  signin,
};