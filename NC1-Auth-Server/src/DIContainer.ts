import { UserRepositoryRuntime } from "./repository";
import { UserService } from "./service";

export class DIContainer {
  public static instance: DIContainer = new DIContainer();

  private getRepository() {
    return new UserRepositoryRuntime();
  }
  public getService() {
    return new UserService(this.getRepository());
  }

  private constructor() {}
}
