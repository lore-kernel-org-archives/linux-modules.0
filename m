Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F5A3B5319
	for <linux-modules@vger.kernel.org>; Mon,  9 Mar 2026 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064942; cv=none; b=jUi8NPzQzVMqsk9xHlsJFrAJZXIFQloRSWKyWkq8dEEx10xHgK/IQ7yaGDE1pCxzNP7Snxu1aVrltaDBh7yMK2vCloKBHvAZcP+cf+LvNaQXDR4jZn8RWIAxw778eK3bBjU/KymBIwx9m7IeaRpvedPh8pCZHejgTvDm4TlbzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064942; c=relaxed/simple;
	bh=dDjvXLUChXJCSdy0Nijlubez9c1eccntEyiw3Hnh09A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WsPqvZkizFfrfiHAC/jByITxlxAGp09a8aOiOs96RgxwdByWe3suwn3Pv5DJdrvrrZ4vfqoxI4CEIL25XRk2Ykg+xiv+rxqZTMGeqHwsPYKaDs7T/GN4emGwu1lnMiyFzG45ZDqZldhxmPq+ejbbdkKTuEDIOmW4BFDrZrAekuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fT3u3nSd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fT3u3nSd"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so22882665e9.2
        for <linux-modules@vger.kernel.org>; Mon, 09 Mar 2026 07:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773064939; x=1773669739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7BivMfnbxgWNtcrd8HtvCtrKq+TC9ALNGRREHL2ARkw=;
        b=fT3u3nSd7kv3k92FAyub6KD/znn24xaECCDqSuSR1HNJCxiZM4B9kX/JZ/QK54Qtvq
         KeOuSjOcxvShzy+tooEr3Y8aoJKBBLmascRAnt+CVY43WVp2gF5Ok7zud941c4//foc8
         XP5mRllyFxliTFleTx0CMC/84kmSuChYbsd4KHu0EhC6YOzkH43/bIPLQVPVdut/mi+d
         jvqTsuWh+kqHm0jdSmdxFXIYC+iz9LWkOTK4lUiEcmH7NTH5huGsKjMta509qBTfhNZA
         FbxvPHbwsXfineOPsbAxdE61NG7bm8g6Rle0SXEq+Tp1N9bOF64ZoTBm8ENwn6dHj9ye
         RK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773064939; x=1773669739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7BivMfnbxgWNtcrd8HtvCtrKq+TC9ALNGRREHL2ARkw=;
        b=NS+Bp0lufvjB/8gbgC98U7VRExw5ITDkkwnZPXAFnJgz1Apbqw6oTiJPHdpRloOaOP
         /x/W9ErVXQQF7fhpBW18ozRCAJb/0xjM/vhnVcMrbTB6EpfSYE/mIdgoZjOAnc6kVhX6
         4Z9+89DW5hDUcK/ANGSs74szDX4UI5FmVK/8BKlpoeWp56UxMYWfAJ8IzL9f0gR22UKv
         kp+wY+0UHdg1DLVSj/66oChZ8nRQzE2p9cUzZ/X4O7rJ00sLuT2UJPVFGYSP7zmp2AiH
         6w+mehz3Kd4aPJeHG1JAuvvENvWMbjYP3ZZRz7KSjebwKXS9RNkCdjZjuFkdD97lxYB/
         XkNw==
X-Forwarded-Encrypted: i=1; AJvYcCXlADu/4PvHmYT+q6f+7eGl7YJsietNOWd61PkNAXhaWDwt7CJVnc4nj7jCGyyCN5MWub8yVhBehyIfYNZ9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtvsu33U6lByNSkk/yibohbU8O4jDYPRHdZbd8I9GolS7N1yyF
	Grhau8S05cFp6zVcyLyzlW9V0ag/G8jzuF+ZY8UYsQM7HkIi89Ym1bt3jlR6Sh54MpQ=
X-Gm-Gg: ATEYQzxcL2LpTMivYMqCkI8OzUJMlLxO1dKQYbAeH6W2yXsgLGqNuIOuAv0rDhc9jxw
	WdacS9nJf7fDvmjJbZUnCFP3hElypbaOpZbXooCdGEYK3buvgLM70UuUEKjStD2Ru/+1MM6w2fE
	sqYcVskGFQ+gb2bslyvwCdgZJaqSyZihr3/QcaDy5MBxeYcIdIScgL6UAYFpQGhzvrJ3WlB+/2v
	K5y9iBmuxyeAcoiep5eZWURizhMGvqoHp8+Tfa3FIBtIiYYOcP+vEKFLFe+T+T6Y3h0SY9t2ltk
	gw5FD6XDQPBZMPGAW3Iw7oa16vNieyBfV3vJBDlFxSrxkrDkeIZD0peXVFpltM3WXSrHKxLK7Hp
	f9Q+YVmCCEV8VIlKGsCo0SPI6JDq8jl++nME2KGnbkP0A9b9LlGsP5wEjnP01fO60ve++h/K2Ne
	u/euVjXMHI5Czy5GlmPr6w5iRALbTG6YWyFiCiriwb2X1CPUOZ0cHkERwlyhePB8dDrKLASxpgO
	9O/1/sYGVEg92e9KlTCifrCClmGAwWkN0cQvs0Qrb8PffkFTKWC3ktG42pQBxhunIxR7A==
X-Received: by 2002:a05:600c:4fc4:b0:485:40c6:f528 with SMTP id 5b1f17b1804b1-48540c6f743mr13314555e9.30.1773064938797;
        Mon, 09 Mar 2026 07:02:18 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853a59fc36sm184973375e9.9.2026.03.09.07.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 07:02:17 -0700 (PDT)
Message-ID: <e3e59565-d64e-4bfc-8800-47449d5b456d@suse.com>
Date: Mon, 9 Mar 2026 15:02:16 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: print version for external modules in
 print_modules()
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, mcgrof@kernel.org,
 da.gomez@kernel.org, atomlin@atomlin.com, linux-modules@vger.kernel.org
References: <20251231094004.37851-1-laoar.shao@gmail.com>
 <20260305234344.GA788042@google.com>
 <87a72531-5730-443d-8b6f-07ae9b8df6dc@suse.com>
 <CALOAHbAB=ubQ8X6gRY_04UYVvmGA1tY49o5w8GV7Nh==Y3nveQ@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CALOAHbAB=ubQ8X6gRY_04UYVvmGA1tY49o5w8GV7Nh==Y3nveQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/8/26 3:14 PM, Yafang Shao wrote:
> On Fri, Mar 6, 2026 at 6:10 PM Petr Pavlu <petr.pavlu@suse.com> wrote:
>>
>> On 3/6/26 12:43 AM, Sami Tolvanen wrote:
>>> On Wed, Dec 31, 2025 at 05:40:04PM +0800, Yafang Shao wrote:
>>>> --- a/kernel/module/main.c
>>>> +++ b/kernel/module/main.c
>>>> @@ -3901,7 +3901,11 @@ void print_modules(void)
>>>>      list_for_each_entry_rcu(mod, &modules, list) {
>>>>              if (mod->state == MODULE_STATE_UNFORMED)
>>>>                      continue;
>>>> -            pr_cont(" %s%s", mod->name, module_flags(mod, buf, true));
>>>> +            pr_cont(" %s", mod->name);
>>>> +            /* Only append version for out-of-tree modules */
>>>> +            if (mod->version && test_bit(TAINT_OOT_MODULE, &mod->taints))
>>>> +                    pr_cont("-%s", mod->version);
>>>> +            pr_cont("%s", module_flags(mod, buf, true));
>>>
>>> On second thought, is using mod->version here safe? We release the
>>> memory for mod->version in:
>>>
>>>   free_module
>>>     -> mod_sysfs_teardown
>>>     -> module_remove_modinfo_attrs
>>>     -> attr->free = free_modinfo_version
>>>
>>> And this happens before the module is removed from the
>>> list. Couldn't there be a race condition where we read a non-NULL
>>> mod->version here, but the buffer is being concurrently released
>>> by another core that's unloading the module, resulting in a
>>> use-after-free in the pr_cont call?
>>>
>>> In order to do this safely, we should presumably drop the attr->free
>>> call from module_remove_modinfo_attrs and release the attributes
>>> only after the synchronize_rcu call in free_module (there's already
>>> free_modinfo we can use), so mod->version is valid for the entire
>>> time the module is on the list.
>>
>> This looks reasonable to me as a simple fix.
> 
> I will send a fix for it first.

Ack.

> 
>> I also noticed that
>> setup_modinfo() with its attr->setup() calls is invoked unconditionally
>> in kernel/module/main.c, while module_remove_modinfo_attrs() with
>> attr->free() is present in kernel/module/sysfs.c, which is conditional
>> on CONFIG_SYSFS. In the unlikely configuration where CONFIG_SYSFS=n and
>> CONFIG_MODULES=y, this can result in a memory leak of module::version
>> when a module is unloaded.
>>
>> In general, I think this could benefit from more cleanup in the future.
>> Most of the code related to modinfo_attrs should be moved into
>> kernel/module/sysfs.c.
> 
> Following the change suggested by Sami, the modinfo_attrs definition,
> along with attr->free() and attr->setup(), remains in
> kernel/module/main.c. Should any of these components be relocated to
> kernel/module/sysfs.c?
> 
>> Since module::version is now used from
>> print_modules(), which is part of the general module loader code, the
>> initialization of the variable should be independent of all sysfs logic.
>> Ideally, the sysfs code should only read module::version and no longer
>> manage it.
> 
> After the above change, both the allocation and freeing of
> module::version now reside in kernel/module/main.c. Is this
> sufficient?

I think we can further clean up this area by moving more items into
kernel/module/sysfs.c and untangling module::(src)version from the sysfs
code. A quick prototype is shown below. However, this doesn't need to be
done now and I can send this separately later.

-- 
Thanks,
Petr


diff --git a/drivers/base/core.c b/drivers/base/core.c
index 791f9e444df8..dfff1b5fa463 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4296,7 +4296,7 @@ struct device *__root_device_register(const char *name, struct module *owner)
 		return ERR_PTR(err);
 	}
 
-#ifdef CONFIG_MODULES	/* gotta find a "cleaner" way to do this */
+#if defined(CONFIG_MODULES) && defined(CONFIG_SYSFS)	/* gotta find a "cleaner" way to do this */
 	if (owner) {
 		struct module_kobject *mk = &owner->mkobj;
 
diff --git a/include/linux/module.h b/include/linux/module.h
index 14f391b186c6..5959a9695d93 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -57,9 +57,7 @@ struct module_attribute {
 			char *);
 	ssize_t (*store)(const struct module_attribute *, struct module_kobject *,
 			 const char *, size_t count);
-	void (*setup)(struct module *, const char *);
 	int (*test)(struct module *);
-	void (*free)(struct module *);
 };
 
 struct module_version_attribute {
@@ -408,12 +406,15 @@ struct module {
 	unsigned char build_id[BUILD_ID_SIZE_MAX];
 #endif
 
+	const char *version;
+	const char *srcversion;
+
+#ifdef CONFIG_SYSFS
 	/* Sysfs stuff. */
 	struct module_kobject mkobj;
 	struct module_attribute *modinfo_attrs;
-	const char *version;
-	const char *srcversion;
 	struct kobject *holders_dir;
+#endif
 
 	/* Exported symbols */
 	const struct kernel_symbol *syms;
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 618202578b42..cbaa14af9b5a 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -47,9 +47,6 @@ struct kernel_symbol {
 extern struct mutex module_mutex;
 extern struct list_head modules;
 
-extern const struct module_attribute *const modinfo_attrs[];
-extern const size_t modinfo_attrs_count;
-
 /* Provided by the linker */
 extern const struct kernel_symbol __start___ksymtab[];
 extern const struct kernel_symbol __stop___ksymtab[];
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c3ce106c70af..c665c4144080 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -577,36 +577,6 @@ bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
 
 #endif /* CONFIG_SMP */
 
-#define MODINFO_ATTR(field)	\
-static void setup_modinfo_##field(struct module *mod, const char *s)  \
-{                                                                     \
-	mod->field = kstrdup(s, GFP_KERNEL);                          \
-}                                                                     \
-static ssize_t show_modinfo_##field(const struct module_attribute *mattr, \
-			struct module_kobject *mk, char *buffer)      \
-{                                                                     \
-	return scnprintf(buffer, PAGE_SIZE, "%s\n", mk->mod->field);  \
-}                                                                     \
-static int modinfo_##field##_exists(struct module *mod)               \
-{                                                                     \
-	return mod->field != NULL;                                    \
-}                                                                     \
-static void free_modinfo_##field(struct module *mod)                  \
-{                                                                     \
-	kfree(mod->field);                                            \
-	mod->field = NULL;                                            \
-}                                                                     \
-static const struct module_attribute modinfo_##field = {              \
-	.attr = { .name = __stringify(field), .mode = 0444 },         \
-	.show = show_modinfo_##field,                                 \
-	.setup = setup_modinfo_##field,                               \
-	.test = modinfo_##field##_exists,                             \
-	.free = free_modinfo_##field,                                 \
-};
-
-MODINFO_ATTR(version);
-MODINFO_ATTR(srcversion);
-
 static struct {
 	char name[MODULE_NAME_LEN];
 	char taints[MODULE_FLAGS_BUF_SIZE];
@@ -886,15 +856,6 @@ void symbol_put_addr(void *addr)
 }
 EXPORT_SYMBOL_GPL(symbol_put_addr);
 
-static ssize_t show_refcnt(const struct module_attribute *mattr,
-			   struct module_kobject *mk, char *buffer)
-{
-	return sprintf(buffer, "%i\n", module_refcount(mk->mod));
-}
-
-static const struct module_attribute modinfo_refcnt =
-	__ATTR(refcnt, 0444, show_refcnt, NULL);
-
 void __module_get(struct module *module)
 {
 	if (module) {
@@ -961,118 +922,6 @@ size_t module_flags_taint(unsigned long taints, char *buf)
 	return l;
 }
 
-static ssize_t show_initstate(const struct module_attribute *mattr,
-			      struct module_kobject *mk, char *buffer)
-{
-	const char *state = "unknown";
-
-	switch (mk->mod->state) {
-	case MODULE_STATE_LIVE:
-		state = "live";
-		break;
-	case MODULE_STATE_COMING:
-		state = "coming";
-		break;
-	case MODULE_STATE_GOING:
-		state = "going";
-		break;
-	default:
-		BUG();
-	}
-	return sprintf(buffer, "%s\n", state);
-}
-
-static const struct module_attribute modinfo_initstate =
-	__ATTR(initstate, 0444, show_initstate, NULL);
-
-static ssize_t store_uevent(const struct module_attribute *mattr,
-			    struct module_kobject *mk,
-			    const char *buffer, size_t count)
-{
-	int rc;
-
-	rc = kobject_synth_uevent(&mk->kobj, buffer, count);
-	return rc ? rc : count;
-}
-
-const struct module_attribute module_uevent =
-	__ATTR(uevent, 0200, NULL, store_uevent);
-
-static ssize_t show_coresize(const struct module_attribute *mattr,
-			     struct module_kobject *mk, char *buffer)
-{
-	unsigned int size = mk->mod->mem[MOD_TEXT].size;
-
-	if (!IS_ENABLED(CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC)) {
-		for_class_mod_mem_type(type, core_data)
-			size += mk->mod->mem[type].size;
-	}
-	return sprintf(buffer, "%u\n", size);
-}
-
-static const struct module_attribute modinfo_coresize =
-	__ATTR(coresize, 0444, show_coresize, NULL);
-
-#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
-static ssize_t show_datasize(const struct module_attribute *mattr,
-			     struct module_kobject *mk, char *buffer)
-{
-	unsigned int size = 0;
-
-	for_class_mod_mem_type(type, core_data)
-		size += mk->mod->mem[type].size;
-	return sprintf(buffer, "%u\n", size);
-}
-
-static const struct module_attribute modinfo_datasize =
-	__ATTR(datasize, 0444, show_datasize, NULL);
-#endif
-
-static ssize_t show_initsize(const struct module_attribute *mattr,
-			     struct module_kobject *mk, char *buffer)
-{
-	unsigned int size = 0;
-
-	for_class_mod_mem_type(type, init)
-		size += mk->mod->mem[type].size;
-	return sprintf(buffer, "%u\n", size);
-}
-
-static const struct module_attribute modinfo_initsize =
-	__ATTR(initsize, 0444, show_initsize, NULL);
-
-static ssize_t show_taint(const struct module_attribute *mattr,
-			  struct module_kobject *mk, char *buffer)
-{
-	size_t l;
-
-	l = module_flags_taint(mk->mod->taints, buffer);
-	buffer[l++] = '\n';
-	return l;
-}
-
-static const struct module_attribute modinfo_taint =
-	__ATTR(taint, 0444, show_taint, NULL);
-
-const struct module_attribute *const modinfo_attrs[] = {
-	&module_uevent,
-	&modinfo_version,
-	&modinfo_srcversion,
-	&modinfo_initstate,
-	&modinfo_coresize,
-#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
-	&modinfo_datasize,
-#endif
-	&modinfo_initsize,
-	&modinfo_taint,
-#ifdef CONFIG_MODULE_UNLOAD
-	&modinfo_refcnt,
-#endif
-	NULL,
-};
-
-const size_t modinfo_attrs_count = ARRAY_SIZE(modinfo_attrs);
-
 static const char vermagic[] = VERMAGIC_STRING;
 
 int try_to_force_load(struct module *mod, const char *reason)
@@ -1762,14 +1611,11 @@ static void module_license_taint_check(struct module *mod, const char *license)
 
 static int setup_modinfo(struct module *mod, struct load_info *info)
 {
-	const struct module_attribute *attr;
 	char *imported_namespace;
-	int i;
 
-	for (i = 0; (attr = modinfo_attrs[i]); i++) {
-		if (attr->setup)
-			attr->setup(mod, get_modinfo(info, attr->attr.name));
-	}
+	/* TODO Check for failed kstrdup(). */
+	mod->version = kstrdup(get_modinfo(info, "version"), GFP_KERNEL);
+	mod->srcversion = kstrdup(get_modinfo(info, "srcversion"), GFP_KERNEL);
 
 	for_each_modinfo_entry(imported_namespace, info, "import_ns") {
 		/*
@@ -1788,13 +1634,8 @@ static int setup_modinfo(struct module *mod, struct load_info *info)
 
 static void free_modinfo(struct module *mod)
 {
-	const struct module_attribute *attr;
-	int i;
-
-	for (i = 0; (attr = modinfo_attrs[i]); i++) {
-		if (attr->free)
-			attr->free(mod);
-	}
+	kfree(mod->version);
+	kfree(mod->srcversion);
 }
 
 bool __weak module_init_section(const char *name)
@@ -3060,8 +2901,10 @@ static noinline int do_init_module(struct module *mod)
 	blocking_notifier_call_chain(&module_notify_list,
 				     MODULE_STATE_LIVE, mod);
 
+#ifdef CONFIG_SYSFS
 	/* Delay uevent until module has finished its init routine */
 	kobject_uevent(&mod->mkobj.kobj, KOBJ_ADD);
+#endif
 
 	/*
 	 * We need to finish all async code before the module init sequence
diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index 01c65d608873..f2e3a625bcd5 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -14,6 +14,144 @@
 #include <linux/mutex.h>
 #include "internal.h"
 
+#define MODINFO_ATTR(field)	\
+static ssize_t show_modinfo_##field(const struct module_attribute *mattr, \
+			struct module_kobject *mk, char *buffer)      \
+{                                                                     \
+	return scnprintf(buffer, PAGE_SIZE, "%s\n", mk->mod->field);  \
+}                                                                     \
+static int modinfo_##field##_exists(struct module *mod)               \
+{                                                                     \
+	return mod->field != NULL;                                    \
+}                                                                     \
+static const struct module_attribute modinfo_##field = {              \
+	.attr = { .name = __stringify(field), .mode = 0444 },         \
+	.show = show_modinfo_##field,                                 \
+	.test = modinfo_##field##_exists,                             \
+};
+
+MODINFO_ATTR(version);
+MODINFO_ATTR(srcversion);
+
+static ssize_t show_initstate(const struct module_attribute *mattr,
+			      struct module_kobject *mk, char *buffer)
+{
+	const char *state = "unknown";
+
+	switch (mk->mod->state) {
+	case MODULE_STATE_LIVE:
+		state = "live";
+		break;
+	case MODULE_STATE_COMING:
+		state = "coming";
+		break;
+	case MODULE_STATE_GOING:
+		state = "going";
+		break;
+	default:
+		BUG();
+	}
+	return sprintf(buffer, "%s\n", state);
+}
+
+static const struct module_attribute modinfo_initstate =
+	__ATTR(initstate, 0444, show_initstate, NULL);
+
+static ssize_t store_uevent(const struct module_attribute *mattr,
+			    struct module_kobject *mk,
+			    const char *buffer, size_t count)
+{
+	int rc;
+
+	rc = kobject_synth_uevent(&mk->kobj, buffer, count);
+	return rc ? rc : count;
+}
+
+const struct module_attribute module_uevent =
+	__ATTR(uevent, 0200, NULL, store_uevent);
+
+static ssize_t show_coresize(const struct module_attribute *mattr,
+			     struct module_kobject *mk, char *buffer)
+{
+	unsigned int size = mk->mod->mem[MOD_TEXT].size;
+
+	if (!IS_ENABLED(CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC)) {
+		for_class_mod_mem_type(type, core_data)
+			size += mk->mod->mem[type].size;
+	}
+	return sprintf(buffer, "%u\n", size);
+}
+
+static const struct module_attribute modinfo_coresize =
+	__ATTR(coresize, 0444, show_coresize, NULL);
+
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+static ssize_t show_datasize(const struct module_attribute *mattr,
+			     struct module_kobject *mk, char *buffer)
+{
+	unsigned int size = 0;
+
+	for_class_mod_mem_type(type, core_data)
+		size += mk->mod->mem[type].size;
+	return sprintf(buffer, "%u\n", size);
+}
+
+static const struct module_attribute modinfo_datasize =
+	__ATTR(datasize, 0444, show_datasize, NULL);
+#endif
+
+static ssize_t show_initsize(const struct module_attribute *mattr,
+			     struct module_kobject *mk, char *buffer)
+{
+	unsigned int size = 0;
+
+	for_class_mod_mem_type(type, init)
+		size += mk->mod->mem[type].size;
+	return sprintf(buffer, "%u\n", size);
+}
+
+static const struct module_attribute modinfo_initsize =
+	__ATTR(initsize, 0444, show_initsize, NULL);
+
+static ssize_t show_taint(const struct module_attribute *mattr,
+			  struct module_kobject *mk, char *buffer)
+{
+	size_t l;
+
+	l = module_flags_taint(mk->mod->taints, buffer);
+	buffer[l++] = '\n';
+	return l;
+}
+
+static const struct module_attribute modinfo_taint =
+	__ATTR(taint, 0444, show_taint, NULL);
+
+static ssize_t show_refcnt(const struct module_attribute *mattr,
+			   struct module_kobject *mk, char *buffer)
+{
+	return sprintf(buffer, "%i\n", module_refcount(mk->mod));
+}
+
+static const struct module_attribute modinfo_refcnt =
+	__ATTR(refcnt, 0444, show_refcnt, NULL);
+
+static const struct module_attribute *const modinfo_attrs[] = {
+	&module_uevent,
+	&modinfo_version,
+	&modinfo_srcversion,
+	&modinfo_initstate,
+	&modinfo_coresize,
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+	&modinfo_datasize,
+#endif
+	&modinfo_initsize,
+	&modinfo_taint,
+#ifdef CONFIG_MODULE_UNLOAD
+	&modinfo_refcnt,
+#endif
+	NULL,
+};
+
 /*
  * /sys/module/foo/sections stuff
  * J. Corbet <corbet@lwn.net>
@@ -278,8 +416,6 @@ static void module_remove_modinfo_attrs(struct module *mod, int end)
 		if (!attr->attr.name)
 			break;
 		sysfs_remove_file(&mod->mkobj.kobj, &attr->attr);
-		if (attr->free)
-			attr->free(mod);
 	}
 	kfree(mod->modinfo_attrs);
 }
@@ -292,7 +428,7 @@ static int module_add_modinfo_attrs(struct module *mod)
 	int i;
 
 	mod->modinfo_attrs = kzalloc((sizeof(struct module_attribute) *
-					(modinfo_attrs_count + 1)),
+					(ARRAY_SIZE(modinfo_attrs) + 1)),
 					GFP_KERNEL);
 	if (!mod->modinfo_attrs)
 		return -ENOMEM;
