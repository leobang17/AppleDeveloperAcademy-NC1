import { UserInputDto } from "./models/dto";
import { User } from "./models/models";
import { Users } from "./models/static";

export interface UserRepository {
  findUserByUsername(username: string): User | undefined;
  addUser(user: UserInputDto): void;
  findAllUsers(): User[];
}

export class UserRepositoryRuntime implements UserRepository {
  private users: User[] = Users;
  private seq: number = Users.length;

  public findUserByUsername(username: string) {
    return this.users.find((user) => {
      return user.username.toLowerCase() === username.toLowerCase();
    });
  }

  public addUser(user: UserInputDto) {
    this.seq += 1;
    const insertUser: User = {
      id: this.seq,
      ...user,
    };
    this.users.push(insertUser);
  }

  public findAllUsers() {
    return this.users;
  }
}
