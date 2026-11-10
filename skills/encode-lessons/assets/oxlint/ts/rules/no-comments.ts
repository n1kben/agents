import { defineRule } from "@oxlint/plugins";

export const noCommentsRule = defineRule({
  meta: {
    type: "suggestion",
    docs: { description: "Disallow comments of any kind." },
    messages: {
      comment:
        "Remove this comment. Make the code say it through names and types, or encode the rule in a check.",
    },
  },
  createOnce(context) {
    return {
      Program() {
        for (const comment of context.sourceCode.getAllComments()) {
          context.report({ loc: comment.loc, messageId: "comment" });
        }
      },
    };
  },
});
