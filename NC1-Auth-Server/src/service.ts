import { BaseResponse } from "./baseReponse";
import { UserInputDto } from "./models/dto";
import { UserRepository } from "./repository";

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
}
