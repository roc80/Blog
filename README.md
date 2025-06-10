### 关于Github Actions
- 找GoogleGemini2.5Flash Battle那么久，试了八次，都没达到正确预期，到最后让我手写script，思路太窄了。
- 找ClaudeSonnet4 给他说明情况，一下子就指出问题所在：
    ```bash
    script 块中，你试图使用 ${{ github.workspace }}/dist/ 作为源目录，但这个路径是 GitHub Actions runner 上的路径，而 script 块是在你的远程服务器上执行的，远程服务器上并不存在这个路径。
    ```

>总结：用AI还是得灵活一些，发现它蠢了之后，自己得赶紧抽离出来。