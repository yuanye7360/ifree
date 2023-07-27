const PrefixCls = 'free';

export const getPrefixCls = (suffixCls: string, customizePrefixCls?: string) => {
  if (customizePrefixCls) return customizePrefixCls;
  return `${PrefixCls}-${suffixCls}`;
};
