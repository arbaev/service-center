export const empty = {
  methods: {
    notEmpty(obj) {
      return Object.keys(obj).length > 0 && obj.constructor === Object
    },
    isEmpty(obj) {
      return !this.notEmpty(obj);
    }
  }
};
