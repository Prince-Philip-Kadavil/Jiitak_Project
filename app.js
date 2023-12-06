const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('<h1><center>Hello World NodeJS-app! test Version 1</center></h1>');
});

const port = 5000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
