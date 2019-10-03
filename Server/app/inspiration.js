const gm = require('gm');
const inspiration = require('express').Router();

const imageD = (
  background = '#ffffff',
  stroke = 1,
  strokeFill = '#000000',
  fillOne = '#ffffff',
  fillTwo = '#ffffff',
  fillThree = '#ffffff',
) =>
  gm(400, 320, background)
    .stroke(strokeFill, stroke)
    .fill(fillOne)
    .drawCircle(210, 160, 330, 160)
    .fill(fillTwo)
    .drawCircle(210, 160, 240, 160)
    .fill(fillThree)
    .drawPolyline(
      [130, 40],
      [70, 40],
      [70, 280],
      [130, 280],
      [130, 40],
    );

const imageE = (
  background = '#ffffff',
  stroke = 1,
  strokeFill = '#000000',
  fillOne = '#ffffff',
  fillTwo = '#ffffff',
  fillThree = '#ffffff',
) =>
  gm(400, 320, background)
    .stroke(strokeFill, stroke)
    .fill(fillOne)
    .drawRectangle(70, 40, 330, 100)
    .fill(fillTwo)
    .drawRectangle(70, 130, 290, 190)
    .fill(fillThree)
    .drawRectangle(70, 220, 330, 280);

const imageS = (
  background = '#ffffff',
  stroke = 1,
  strokeFill = '#000000',
  fill = '#ffffff',
) =>
  gm(400, 320, background)
    .stroke(strokeFill, stroke)
    .fill(background)
    .drawLine(70, 160, 150, 160)
    .drawLine(250, 160, 330, 160)
    .drawArc(70, 35, 330, 285, 0, 160)
    .drawArc(70, 35, 330, 285, 180, 340)
    .fill(fill)
    .drawCircle(200, 160, 250, 160);

const imageI = (
  background = '#ffffff',
  stroke = 1,
  strokeFill = '#000000',
) =>
  gm(400, 320, background)
    .stroke(strokeFill, stroke)
    .fill(background)
    .drawPolyline(
      [150, 90],
      [150, 40],
      [250, 40],
      [250, 120],
      [150, 120],
      [150, 280],
      [250, 280],
      [250, 160],
    );

const imageG = (
  background = '#ffffff',
  stroke = 1,
  strokeFill = '#000000',
  fillOne = '#ffffff',
  fillTwo = '#ffffff',
  fillThree = '#ffffff',
) =>
  gm(400, 320, background)
    .stroke(strokeFill, stroke)
    .fill(fillOne)
    .drawCircle(200, 160, 300, 160)
    .fill(fillTwo)
    .drawCircle(200, 255, 245, 255)
    .fill(fillThree)
    .drawRectangle(240, 65, 310, 135);

const imageN = (
  background = '#ffffff',
  stroke = 1,
  strokeFill = '#000000',
  fillOne = '#ffffff',
  fillTwo = '#ffffff',
  fillThree = '#ffffff',
) =>
  gm(400, 320, background)
    .stroke(strokeFill, stroke)
    .fill(fillOne)
    .drawRectangle(70, 40, 130, 280)
    .fill(fillTwo)
    .drawRectangle(270, 40, 330, 280)
    .fill(fillThree)
    .drawPolyline(
      [105, 35],
      [65, 75],
      [295, 285],
      [335, 245],
      [105, 35],
    );

// Attribution: http://disq.us/p/di2t9p
const randomHexColor = () =>
  '#' + ('000000' + (Math.random() * 0xFFFFFF << 0).toString(16)).slice(-6);

const randomStroke = () =>
  Math.floor(Math.random() * 5) + 1;

inspiration.get('/', (req, res) => {
  const images = [];
  for (let i = 0; i < req.query.count; ++i) {
    images.push(
      {
        letter: Math.floor(Math.random() * 6),
        background: randomHexColor(),
        stroke: randomStroke(),
        strokeFill: randomHexColor(),
        fillOne: randomHexColor(),
        fillTwo: randomHexColor(),
        fillThree: randomHexColor(),
      }
    );
  }
  res.send(images);
});

inspiration.get('/image', (req, res) => {
  const letter = parseInt(req.query.letter);
  if (isNaN(letter) || letter < 0 || letter > 5) {
    res.sendStatus(500);
    return;
  }

  const image = [
    imageD,
    imageE,
    imageS,
    imageI,
    imageG,
    imageN,
  ][req.query.letter];

  image(
    req.query.background,
    req.query.stroke,
    req.query.strokeFill,
    req.query.fillOne,
    req.query.fillTwo,
    req.query.fillThree,
  ).toBuffer('PNG', function (err, buffer) {
    if (err) {
      res.sendStatus(500);
    } else {
      setTimeout(() => {
        res.writeHead(200, {
          'Content-Type': 'image/png',
          'Content-Length': buffer.length
        });
        res.end(buffer);
      }, 1000)
    }
  });
});

module.exports = inspiration;