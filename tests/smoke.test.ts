import { describe, it, expect } from "bun:test";

describe("dotfiles", () => {
  it("should load the main module", async () => {
    const mod = await import("../index.ts");
    expect(mod).toBeDefined();
  });
});
