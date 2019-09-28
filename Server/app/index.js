const app = require('express')();
const args = require('yargs').argv;
const inspiration = require('./inspiration');
const { authorization, signin } = require('./signin');

app.use('/signin', signin);

const isEnforcingAuthorization = typeof args.authorization === 'undefined' || args.authorization === 'true';
if (isEnforcingAuthorization) {
  app.use(['/inspiration'], authorization(args.timeout));
}

app.use('/inspiration', inspiration);

const port = 8081;
app.listen(port, () => console.log(`Server listening on port ${port}`));
