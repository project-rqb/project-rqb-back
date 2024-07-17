const { Octokit } = require("@octokit/rest");
const octokit = new Octokit({ auth: process.env.GITHUB_TOKEN });

let MAIN_REVIEWERS = ['gorilla-muscle', 'topi0247'];
let SUB_REVIEWERS = ['UNNNYO', 'neko967', 'miura-taiga'];

const prAuthor = process.env.PR_AUTHOR;

MAIN_REVIEWERS = MAIN_REVIEWERS.filter(user => user !== prAuthor);
SUB_REVIEWERS = SUB_REVIEWERS.filter(user => user !== prAuthor);

const getRandomReviewer = (reviewers) => {
  const randomIndex = Math.floor(Math.random() * reviewers.length);
  return reviewers[randomIndex];
};

const mainReviewer = getRandomReviewer(MAIN_REVIEWERS);
const subReviewer = getRandomReviewer(SUB_REVIEWERS);

const reviewers = [mainReviewer, subReviewer];

(async () => {
  try {
    const [owner, repo] = process.env.GITHUB_REPOSITORY.split('/');
    const pull_number = process.env.GITHUB_REF.split('/').pop().replace('merge', '').trim();

    await octokit.pulls.requestReviewers({
      owner,
      repo,
      pull_number,
      reviewers
    });

    await octokit.issues.addAssignees({
      owner,
      repo,
      issue_number: pull_number,
      assignees: [prAuthor]
    });
  } catch (error) {
    console.error(`Error assigning reviewers or assignee: ${error}`);
  }
})();
