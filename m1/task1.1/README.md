# Module 1. DevOps Introduction

## TASK 1.1

### Git traning at [learngitbranching](https://learngitbranching.js.org/)

1. **Main** section completed

![Main](/DevOps_online_Kyiv_2022Q1Q2\m1\task1.1\images\main.png)

2. **Remote** section completed

![Remote](/DevOps_online_Kyiv_2022Q1Q2\m1\task1.1\images\remote.png)

### Private repo on GitHub

Private repo [CodePathfinder/DevOps_online_Kyiv_2022Q1Q2](https://github.com/CodePathfinder/DevOps_online_Kyiv_2022Q1Q2) is created on GitHub.

This [README.md file](https://github.com/CodePathfinder/DevOps_online_Kyiv_2022Q1Q2/tree/develop/m1/task1.1/README.md) in the repository.

### _Git Merge_ and other repository commands

1. Merge of branch **_images_** into branch **_develop_**.

Example of no-conflict merge -- fast-forward

![Merge of Images into Develop. Fast-forward](/DevOps_online_Kyiv_2022Q1Q2\m1\task1.1\images\merge-images-develop-fast-forward.png)

2. Merge of branch **_styles_** into branch **_develop_**.

- Example of merge conflict

![Merge Conflict Stayles Develop](/DevOps_online_Kyiv_2022Q1Q2\m1\task1.1\images\merge-conflict-styles-develop.png)

- Resolved merge conflict

![Merge Conflict Resolved](/DevOps_online_Kyiv_2022Q1Q2\m1\task1.1\images\merge-conflict-resolved.png)

3. Inspect repository with different `git log` commands.

Samples:

| command                                | description                                                                      |
| :------------------------------------- | :------------------------------------------------------------------------------- |
| _git log --all_                        | shows all commits                                                                |
| _git log -2_                           | shows last two commits                                                           |
| _git log images..master_               | shows the commits that are on **_master_** branch and not on **_images_** branch |
| _git log --oneline_                    | shows shorten (one-line) format of log                                           |
| _git log --decorate --oneline --graph_ | shows pretty format of logs with visual seperation on branches                   |
| _git shortlog_                         | summarizes git log and groups by author                                          |

Snapshot of commands `git log images..master` and `git log --decorate --oneline --graph` with respective outputs is shown below:

![Git Log Options](/DevOps_online_Kyiv_2022Q1Q2\m1\task1.1\images\git-log-options.png)

4. Push all branches to origin

```
git push origin --all
```

![Git Push Origin All](/DevOps_online_Kyiv_2022Q1Q2\m1\task1.1\images\git-push-origin-all.png)

5. Execute command `git reflog`.

_File task1.1_GIT.txt_ is created and added [here](/DevOps_online_Kyiv_2022Q1Q2\m1\task1.1\task1.1_GIT.txt).

### Describe in your own words what DevOps is

DevOps is a chain between development and operation aimed to ensure smooth and quick integration, delivery, and deployment of programmatic products. DevOps's main tasks are implementation of CI/CD pipelines, raising proper infrastructure with due support of scalability, load balancing, container orchestration, and monitoring of the application. _Cloud platforms/services_, _code/image repositories_, and _infrastructure as a code_ are convenient tools to effectively handle these issues.
