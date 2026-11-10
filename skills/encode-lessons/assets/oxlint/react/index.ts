import { eslintCompatPlugin } from "@oxlint/plugins";

import { noUseEffectRule } from "./rules/no-use-effect.ts";

const reactLessonsPlugin = eslintCompatPlugin({
	meta: { name: "lessons-react" },
	rules: {
		"no-use-effect": noUseEffectRule,
	},
});

export default reactLessonsPlugin;
