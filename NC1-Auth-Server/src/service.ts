import { BaseResponse } from "./baseReponse";
import { SignInDto, UserInputDto } from "./models/dto";
import { UserRepository } from "./repository";
import jwt from "jsonwebtoken";

export class UserService {
  constructor(private userRepository: UserRepository) {}

  public createUser(user: UserInputDto) {
    const findUser = this.userRepository.findUserByUsername(user.username);
    if (findUser) {
      return new BaseResponse("유저 있음", "false");
    }
    this.userRepository.addUser(user);
    return new BaseResponse("성공!", "true");
  }

  public getAllUsers() {
    return this.userRepository.findAllUsers();
  }

  public findUserByUsername(username: string) {
    const findUser = this.userRepository.findUserByUsername(username);
    if (!findUser) {
      return new BaseResponse("유저 없음", "false");
    }
    return findUser;
  }

  public signIn(signinValues: SignInDto) {
    const findUser = this.userRepository.findUserByUsername(
      signinValues.username
    );

    if (!findUser) {
      return new BaseResponse("유저 없음", "false");
    }

    if (findUser.password !== signinValues.password) {
      return new BaseResponse("유저 있는데 비번 틀림", "false");
    }

    const { password, ...restOfUserInfo } = findUser;

    const token = jwt.sign({ username: restOfUserInfo.username }, "SECRET");
    if (!token) {
      return new BaseResponse("토큰 생성 실패", "false");
    }

    return {
      ...new BaseResponse("성공!", "true"),
      data: {
        token,
        ...restOfUserInfo,
      },
    };
  }
}
