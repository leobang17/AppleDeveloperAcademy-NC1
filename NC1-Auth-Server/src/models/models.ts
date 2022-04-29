import { UserInputDto } from "./dto";

export interface User extends UserInputDto {
  id: number;
  username: string;
  email: string;
  password: string;
}
