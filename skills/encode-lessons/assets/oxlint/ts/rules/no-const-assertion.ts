import { defineRule } from "@oxlint/plugins";

export const noConstAssertionRule = defineRule({
  meta: {
    type: "problem",
    docs: { description: "Disallow `as const` and `<const>` assertions." },
    messages: {
      constAssertion:
        "Don't use a const assertion. Declare the type you want, for example with `satisfies` or a named union.",
    },
  },
  createOnce(context) {
    function isConst(type: { type: string; typeName?: { type: string; name?: string } }) {
      return (
        type.type === "TSTypeReference" &&
        type.typeName?.type === "Identifier" &&
        type.typeName.name === "const"
      );
    }
    return {
      TSAsExpression(node) {
        if (isConst(node.typeAnnotation)) context.report({ node, messageId: "constAssertion" });
      },
      TSTypeAssertion(node) {
        if (isConst(node.typeAnnotation)) context.report({ node, messageId: "constAssertion" });
      },
    };
  },
});
