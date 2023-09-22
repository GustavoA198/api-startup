import { config } from 'dotenv'

config()

export default {
  app: {
    port: process.env.PORT ?? 1234
  },
  mysql: {
    host: process.env.MYSQL_HOST ?? 'localhost',
    user: process.env.MYSQL_USER ?? 'root',
    port: process.env.MYSQL_PORT ?? 3306,
    password: process.env.MYSQL_PASSWORD ?? 'root',
    database: process.env.MYSQL_DATABASE ?? 'university'
  }
}
