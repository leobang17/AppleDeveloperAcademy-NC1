import { UserRepositoryRuntime } from "./repository";
import { UserService } from "./service";

export class DIContainer {
  private getRepository() {
    return new UserRepositoryRuntime();
  }
  public getService() {
    return new UserService(this.getRepository());
  }
}
