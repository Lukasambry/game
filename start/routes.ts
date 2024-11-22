/*
|--------------------------------------------------------------------------
| Routes file
|--------------------------------------------------------------------------
|
| The routes file is used for defining the HTTP routes.
|
*/

import router from '@adonisjs/core/services/router'
import { middleware } from './kernel.js'

const AuthController = () => import('#controllers/auth_controller')
const UsersController = () => import('#controllers/users_controller')
router.on('/').render('pages/home')
router.get('/signup', [UsersController, 'index'])
router.get('/register', [UsersController, 'register'])
router.get('/login', [UsersController, 'login'])

router
  .group(() => {
    router.post('register', [AuthController, 'register'])
    router.post('login', [AuthController, 'login'])
    router.post('logout', [AuthController, 'logout']).use(middleware.auth({ guards: ['api'] }))
  })
  .prefix('user')
