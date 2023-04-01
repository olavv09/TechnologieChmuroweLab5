const express = require('express')
const app = express()
const os = require('os')
const fs = require('fs');

const port = 3000
const host = "0.0.0.0"
let version = "1.0.0"

fs.readFile('./version.txt', 'utf8', (err, data) => {
  if (err) {
    console.error(err);
    return;
  }
   version = data;
});

app.get('/', (req, res) => {
  const hostname = os.hostname()
  const serverIp = server.address().address +":"+ server.address().port
  res.send(`Server: ${hostname}<br>Version: ${version}<br>IP address: ${serverIp}`)
})

let server = app.listen(port, host, () => {
  console.log(`Example app listening on port ${port}`)
})