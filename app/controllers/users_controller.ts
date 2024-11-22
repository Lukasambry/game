import type { HttpContext } from '@adonisjs/core/http'
import User from '#models/user'

export default class UsersController {
  public async index({ view }: HttpContext) {
    const users = await User.all()
    return view.render('pages/users/index', { users })
  }

  public async register({ view }: HttpContext) {
    return view.render('pages/users/register')
  }

  public async login({ view }: HttpContext) {
    return view.render('pages/users/login')
  }
}
