import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { ethers } from "hardhat";

describe("OOG experiment", function () {
  it("Messing Around and Finding Out", async function () {
    const caller = await (await ethers.getContractFactory("Caller")).deploy();
    await caller.messAround();
  });
});
