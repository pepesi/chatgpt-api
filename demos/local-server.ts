import dotenv from 'dotenv-safe'
import express from 'express'

import { ChatGPTAPIBrowser } from '../src'

dotenv.config()

async function getapi() {
  const email = process.env.OPENAI_EMAIL
  const password = process.env.OPENAI_PASSWORD

  const api = new ChatGPTAPIBrowser({
    email,
    password,
    debug: false,
    minimize: true
  })
  await api.initSession()
  return api
}

async function server() {
  const api = await getapi()

  const app = express()
  const port = 3000
  app.get('/', async (req, res) => {
    const q = req.query['q']
    const conversationId = req.query['conversationId']
    const parentMessageId = req.query['parentMessageId']
    const result = await api.sendMessage(q, { conversationId, parentMessageId })
    res.send(result)
  })
  app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
  })
}

server()
