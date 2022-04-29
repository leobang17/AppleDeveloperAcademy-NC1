export class UserInputDto {
  constructor(
    public username: string,
    public password: string,
    public email: string
  ) {}
}

export class SignInDto {
  constructor(public username: string, public password: string) {}
}
