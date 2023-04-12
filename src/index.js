const path = require('path');
require('dotenv').config({ path: path.join(__dirname, './../.env') })

const express = require('express')
const app = express()

// set views
app.set('views', path.join(__dirname, './../views'))
app.set('view engine', 'pug')
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

const port = 3000

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.get('/internal', (req, res, next) => {
  res.status(200).render('index')
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
  console.log(`Example env: ${process.env.TEST}`)
})