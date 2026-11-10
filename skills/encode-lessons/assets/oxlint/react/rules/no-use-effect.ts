import { defineRule } from "@oxlint/plugins";

export const noUseEffectRule = defineRule({
  meta: {
    type: "problem",
    docs: { description: "Disallow React's useEffect." },
    messages: {
      useEffect:
        "Don't use `useEffect`. Derive the value during render, handle it in an event handler, or use the framework's data loading.",
    },
  },
  createOnce(context) {
    return {
      ImportSpecifier(node) {
        const source = node.parent.type === "ImportDeclaration" ? node.parent.source.value : null;
        const imported = node.imported.type === "Identifier" ? node.imported.name : node.imported.value;
        if (source === "react" && imported === "useEffect") {
          context.report({ node, messageId: "useEffect" });
        }
      },
      MemberExpression(node) {
        if (
          node.object.type === "Identifier" &&
          node.object.name === "React" &&
          !node.computed &&
          node.property.type === "Identifier" &&
          node.property.name === "useEffect"
        ) {
          context.report({ node, messageId: "useEffect" });
        }
      },
    };
  },
});
