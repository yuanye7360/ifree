import { defineBuildConfig } from 'unbuild';

export default defineBuildConfig({
  clean: true,
  entries: ['src/index'],
  declaration: false,
  rollup: {
    emitCJS: true,
    output: {
      exports: "named",
    }
  },
});
