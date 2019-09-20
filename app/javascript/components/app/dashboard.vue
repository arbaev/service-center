<template lang="pug">
  li {{ client.id }}: {{ client.attributes.email }}
</template>

<script>
    export default {
        name: "dashboard",
        props: ['client']
    }
</script>

<style scoped>

</style>
