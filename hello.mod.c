#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);

__visible struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0xe00b4984, __VMLINUX_SYMBOL_STR(module_layout) },
	{ 0xe839969f, __VMLINUX_SYMBOL_STR(nf_unregister_hook) },
	{ 0x7002429a, __VMLINUX_SYMBOL_STR(nf_register_hook) },
	{ 0x20c55ae0, __VMLINUX_SYMBOL_STR(sscanf) },
	{ 0xc87c1f84, __VMLINUX_SYMBOL_STR(ktime_get) },
	{ 0x7d50a24, __VMLINUX_SYMBOL_STR(csum_partial) },
	{ 0xf82eacf7, __VMLINUX_SYMBOL_STR(kmem_cache_alloc_trace) },
	{ 0xe2cb65c5, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0x13d347a4, __VMLINUX_SYMBOL_STR(__pskb_pull_tail) },
	{ 0xf0fdf6cb, __VMLINUX_SYMBOL_STR(__stack_chk_fail) },
	{ 0x50eedeb8, __VMLINUX_SYMBOL_STR(printk) },
	{ 0xb4390f9a, __VMLINUX_SYMBOL_STR(mcount) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "D2393732DC2FD3428D72B68");
